import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/core/config/supabase_client.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isSaving = false;
  bool _isLoaded = false;
  bool _isUploadingAvatar = false;

  File? _selectedImage;
  late final AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _nationalIdController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _loadProfile() {
    if (_isLoaded) return;
    final auth = ref.read(authControllerProvider);
    _nameController.text = auth.fullName ?? '';

    final supabase = ref.read(supabaseClientProvider);
    if (auth.user != null) {
      supabase
          .from('profiles')
          .select('phone, bio, national_id')
          .eq('id', auth.user!.id)
          .single()
          .then((data) {
            if (mounted) {
              setState(() {
                _phoneController.text = data['phone'] as String? ?? '';
                _bioController.text = data['bio'] as String? ?? '';
                _nationalIdController.text =
                    data['national_id'] as String? ?? '';
                _isLoaded = true;
              });
            }
          })
          .catchError((_) {
            if (mounted) setState(() => _isLoaded = true);
          });
    }
    _isLoaded = true;
  }

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
                ref.read(authControllerProvider).avatarUrl != null) ...[
              const SizedBox(height: 12),
              _imagePickerOption(
                ctx,
                icon: LucideIcons.trash2,
                label: t.extracted.remove_photo,
                color: Colors.redAccent,
                onTap: () {
                  Navigator.pop(ctx);
                  setState(() => _selectedImage = null);
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
        setState(() => _selectedImage = File(picked.path));
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

    setState(() => _isUploadingAvatar = true);
    try {
      final supabase = ref.read(supabaseClientProvider);
      final bytes = await _selectedImage!.readAsBytes();
      final ext = _selectedImage!.path.split('.').last;
      final filePath = 'avatars/${auth.user!.id}.$ext';

      await supabase.storage.from('avatars').uploadBinary(filePath, bytes);

      final publicUrl = supabase.storage.from('avatars').getPublicUrl(filePath);

      await supabase
          .from('profiles')
          .update({'avatar_url': publicUrl})
          .eq('id', auth.user!.id);

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
      if (mounted) setState(() => _isUploadingAvatar = false);
    }
  }

  Future<void> _saveProfile() async {
    if (!(_formKey.currentState?.validate() ?? true)) return;
    setState(() => _isSaving = true);
    HapticFeedback.mediumImpact();

    try {
      final auth = ref.read(authControllerProvider);
      if (auth.user == null) return;

      final supabase = ref.read(supabaseClientProvider);
      await supabase
          .from('profiles')
          .update({
            'full_name': _nameController.text.trim(),
            'phone': _phoneController.text.trim(),
            'bio': _bioController.text.trim(),
            'national_id': _nationalIdController.text.trim(),
          })
          .eq('id', auth.user!.id);

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
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadProfile();
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final auth = ref.watch(authControllerProvider);
    final primaryColor = Theme.of(context).primaryColor;

    ImageProvider? avatarProvider;
    if (_selectedImage != null) {
      avatarProvider = FileImage(_selectedImage!);
    } else if (auth.avatarUrl != null && auth.avatarUrl!.isNotEmpty) {
      avatarProvider = NetworkImage(auth.avatarUrl!);
    }

    final body = CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: 340,
          pinned: true,
          stretch: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  LucideIcons.arrowLeft,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () => context.pop(),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: AnimatedBuilder(
                animation: _glowController,
                builder: (context, child) => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primaryColor,
                        primaryColor.withValues(alpha: 0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withValues(
                          alpha: 0.3 + 0.2 * _glowController.value,
                        ),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: _isSaving ? null : _saveProfile,
                    child: _isSaving
                        ? SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          )
                        : Text(
                            t.extracted.save,
                            style: GoogleFonts.outfit(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.zoomBackground,
              StretchMode.blurBackground,
            ],
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1A0533),
                        primaryColor.withValues(alpha: 0.8),
                        Color(0xFF0D1B2A),
                      ],
                      stops: const [0.0, 0.45, 1.0],
                    ),
                  ),
                ),

                Positioned.fill(
                  child: Opacity(
                    opacity: 0.06,
                    child: Icon(
                      LucideIcons.userCircle2,
                      size: 260,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),

                Positioned(
                  right: isArabic ? null : 40,
                  left: isArabic ? 40 : null,
                  top: 40,
                  child: AnimatedBuilder(
                    animation: _glowController,
                    builder: (context, _) => Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            primaryColor.withValues(
                              alpha: 0.15 * _glowController.value,
                            ),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            AnimatedBuilder(
                              animation: _glowController,
                              builder: (context, child) => Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [primaryColor, Color(0xFF10B981)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withValues(
                                        alpha:
                                            0.35 + 0.2 * _glowController.value,
                                      ),
                                      blurRadius: 30,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF0D1B2A),
                                  ),
                                  child: _isUploadingAvatar
                                      ? SizedBox(
                                          width: 120,
                                          height: 120,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3,
                                            ),
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 60,
                                          backgroundColor: Colors.white
                                              .withValues(alpha: 0.08),
                                          backgroundImage: avatarProvider,
                                          child: avatarProvider == null
                                              ? Icon(
                                                  LucideIcons.userCircle2,
                                                  size: 55,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface
                                                      .withValues(alpha: 0.7),
                                                )
                                              : null,
                                        ),
                                ),
                              ),
                            ).animate().scale(
                              duration: 700.ms,
                              curve: Curves.easeOutBack,
                            ),

                            Positioned(
                              bottom: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () => _pickImage(context),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        primaryColor,
                                        primaryColor.withValues(alpha: 0.8),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          (Theme.of(context).cardTheme.color ??
                                          Theme.of(context).cardColor),
                                      width: 3,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryColor.withValues(
                                          alpha: 0.4,
                                        ),
                                        blurRadius: 12,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    LucideIcons.camera,
                                    size: 18,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        auth.fullName ?? (t.extracted.user),
                        style: GoogleFonts.outfit(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.onSurface,
                          letterSpacing: -0.5,
                        ),
                      ).animate().fadeIn(delay: 200.ms),
                      SizedBox(height: 4),
                      Text(
                        auth.user?.email ?? '',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.55),
                        ),
                      ).animate().fadeIn(delay: 300.ms),
                      SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: primaryColor.withValues(alpha: 0.35),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              LucideIcons.shield,
                              size: 13,
                              color: Colors.greenAccent,
                            ),
                            SizedBox(width: 6),
                            Text(
                              auth.role.displayName(isArabic: isArabic),
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 400.ms),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionLabel(
                      t.extracted.personal_info,
                      LucideIcons.user,
                      primaryColor,
                    ),
                    const SizedBox(height: 16),

                    _buildPremiumField(
                      context: context,
                      label: t.extracted.full_name,
                      controller: _nameController,
                      icon: LucideIcons.user,
                      iconColor: const Color(0xFF6366F1),
                      isGlass: isGlass,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? (t.extracted.required)
                          : null,
                    ),
                    const SizedBox(height: 14),

                    _buildPremiumField(
                      context: context,
                      label: t.extracted.email,
                      controller: TextEditingController(
                        text: auth.user?.email ?? '',
                      ),
                      icon: LucideIcons.mail,
                      iconColor: Colors.tealAccent,
                      isGlass: isGlass,
                      readOnly: true,
                    ),
                    const SizedBox(height: 14),

                    _buildPremiumField(
                      context: context,
                      label: t.extracted.phone_number,
                      controller: _phoneController,
                      icon: LucideIcons.phone,
                      iconColor: Colors.greenAccent,
                      isGlass: isGlass,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 14),

                    _buildPremiumField(
                      context: context,
                      label: t.extracted.national_id,
                      controller: _nationalIdController,
                      icon: LucideIcons.creditCard,
                      iconColor: Colors.amberAccent,
                      isGlass: isGlass,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 28),

                    _sectionLabel(
                      t.extracted.about_me,
                      LucideIcons.fileText,
                      primaryColor,
                    ),
                    const SizedBox(height: 16),

                    _buildPremiumField(
                      context: context,
                      label: t.extracted.write_something_about_yourself,
                      controller: _bioController,
                      icon: LucideIcons.pencil,
                      iconColor: Colors.pinkAccent,
                      isGlass: isGlass,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 28),

                    _sectionLabel(
                      t.extracted.account_info,
                      LucideIcons.shield,
                      primaryColor,
                    ),
                    const SizedBox(height: 16),
                    _buildAccountInfoCard(
                      context,
                      auth,
                      isArabic,
                      primaryColor,
                    ),
                    const SizedBox(height: 32),

                    _buildSaveButton(context, isArabic, primaryColor),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );

    return isGlass
        ? GlassScaffold(resizeToAvoidBottomInset: true, body: body)
        : Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            resizeToAvoidBottomInset: true,
            body: body,
          );
  }

  Widget _sectionLabel(String title, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.onSurface,
            letterSpacing: 0.5,
          ),
        ),
      ],
    ).animate().fadeIn().slideX(begin: -0.05, end: 0);
  }

  Widget _buildPremiumField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required bool isGlass,
    Color iconColor = Colors.white,
    bool readOnly = false,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.04),
        border: Border.all(
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: 0.08),
        ),
      ),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        style: GoogleFonts.inter(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.inter(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.5),
            fontSize: 14,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          suffixIcon: readOnly
              ? Icon(
                  LucideIcons.lock,
                  size: 16,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.25),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: primaryColor.withValues(alpha: 0.6),
              width: 1.5,
            ),
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.05, end: 0);
  }

  Widget _buildAccountInfoCard(
    BuildContext context,
    AuthState auth,
    bool isArabic,
    Color primaryColor,
  ) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _infoRow(
            icon: LucideIcons.shield,
            iconColor: Colors.greenAccent,
            label: t.extracted.role,
            value: auth.role.displayName(isArabic: isArabic),
          ),
          Divider(
            height: 24,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.08),
          ),
          _infoRow(
            icon: LucideIcons.mail,
            iconColor: Colors.blueAccent,
            label: t.extracted.email,
            value: auth.user?.email ?? '—',
          ),
          Divider(
            height: 24,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.08),
          ),
          _infoRow(
            icon: LucideIcons.checkCircle2,
            iconColor: primaryColor,
            label: t.extracted.account_status,
            value: t.extracted.active,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.08, end: 0);
  }

  Widget _infoRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 16, color: iconColor),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.4),
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(
    BuildContext context,
    bool isArabic,
    Color primaryColor,
  ) {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, child) => GestureDetector(
        onTap: _isSaving ? null : _saveProfile,
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, Color(0xFF10B981)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withValues(
                  alpha: 0.3 + 0.2 * _glowController.value,
                ),
                blurRadius: 20,
                spreadRadius: -4,
              ),
            ],
          ),
          child: Center(
            child: _isSaving
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        LucideIcons.save,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 20,
                      ),
                      SizedBox(width: 12),
                      Text(
                        t.extracted.save_changes,
                        style: GoogleFonts.outfit(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0);
  }
}
