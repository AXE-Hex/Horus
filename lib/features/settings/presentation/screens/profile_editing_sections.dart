part of 'profile_screen.dart';

extension _ProfileEditingSections on _ProfileScreenState {
  Future<void> _pickImage(BuildContext context) async {
    HapticFeedback.mediumImpact();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E1E3A), Color(0xFF12122A)],
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          border: Border.all(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.1),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 24),
            Text(
              t.extracted.change_profile_photo,
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 24),
            _imagePickerOption(
              ctx,
              icon: LucideIcons.camera,
              label: t.extracted.take_photo,
              color:
                  (Theme.of(context).cardTheme.color ??
                  Theme.of(context).cardColor),
              onTap: () async {
                Navigator.pop(ctx);
                await _pickFromSource(ImageSource.camera);
              },
            ),
            SizedBox(height: 12),
            _imagePickerOption(
              ctx,
              icon: LucideIcons.image,
              label: t.extracted.choose_from_gallery,
              color:
                  (Theme.of(context).cardTheme.color ??
                  Theme.of(context).cardColor),
              onTap: () async {
                Navigator.pop(ctx);
                await _pickFromSource(ImageSource.gallery);
              },
            ),
            if (_selectedImage != null ||
                ref.read(authControllerProvider).profile?.avatarUrl !=
                    null) ...[
              const SizedBox(height: 12),
              _imagePickerOption(
                ctx,
                icon: LucideIcons.trash2,
                label: t.extracted.remove_photo,
                color: Colors.redAccent,
                onTap: () {
                  Navigator.pop(ctx);
                  _updateState(() => _selectedImage = null);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _imagePickerOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withValues(alpha: 0.25)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              SizedBox(width: 16),
              Text(
                label,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickFromSource(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
      );
      if (picked != null && mounted) {
        _updateState(() => _selectedImage = File(picked.path));
        await _uploadAvatar();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
      }
    }
  }

  Future<void> _uploadAvatar() async {
    if (_selectedImage == null) return;
    final auth = ref.read(authControllerProvider);
    if (auth.user == null) return;

    _updateState(() => _isUploadingAvatar = true);
    try {
      final supabase = ref.read(supabaseClientProvider);
      final bytes = await _selectedImage!.readAsBytes();
      final ext = _selectedImage!.path.split('.').last;
      final filePath =
          '${auth.user!.id}/${DateTime.now().millisecondsSinceEpoch}.$ext';

      await supabase.storage.from('avatars').uploadBinary(filePath, bytes);

      final publicUrl = supabase.storage.from('avatars').getPublicUrl(filePath);

      await supabase.rpc(
        'update_my_profile',
        params: {
          'p_full_name': auth.profile?.fullName ?? '',
          'p_phone': auth.profile?.phone ?? '',
          'p_bio': auth.profile?.bio ?? '',
          'p_avatar_url': publicUrl,
        },
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              t.$meta.locale.languageCode == 'ar'
                  ? 'تم تحديث الصورة الشخصية'
                  : 'Profile photo updated!',
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Upload failed: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) _updateState(() => _isUploadingAvatar = false);
    }
  }

  Future<void> _saveProfile() async {
    if (!(_formKey.currentState?.validate() ?? true)) return;
    _updateState(() => _isSaving = true);
    HapticFeedback.mediumImpact();

    try {
      final auth = ref.read(authControllerProvider);
      if (auth.user == null) return;

      final supabase = ref.read(supabaseClientProvider);
      await supabase.rpc(
        'update_my_profile',
        params: {
          'p_full_name': _nameController.text.trim(),
          'p_phone': _phoneController.text.trim(),
          'p_bio': _bioController.text.trim(),
        },
      );

      HapticFeedback.heavyImpact();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(
                  LucideIcons.checkCircle2,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 20,
                ),
                SizedBox(width: 12),
                Text(
                  t.$meta.locale.languageCode == 'ar'
                      ? 'تم حفظ الملف الشخصي بنجاح'
                      : 'Profile saved successfully!',
                  style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) _updateState(() => _isSaving = false);
    }
  }
}
