// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/core/config/supabase_client.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:hue/i18n/strings.g.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  bool _isSaving = false;
  bool _isLoaded = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _loadProfile() {
    if (_isLoaded) return;
    final auth = ref.read(authControllerProvider);
    _nameController.text = auth.fullName ?? '';

    // Load additional fields from Supabase
    final supabase = ref.read(supabaseClientProvider);
    if (auth.user != null) {
      supabase
          .from('profiles')
          .select('phone, bio')
          .eq('id', auth.user!.id)
          .single()
          .then((data) {
            if (mounted) {
              setState(() {
                _phoneController.text = data['phone'] as String? ?? '';
                _bioController.text = data['bio'] as String? ?? '';
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

  Future<void> _saveProfile() async {
    setState(() => _isSaving = true);
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
          })
          .eq('id', auth.user!.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              t.$meta.locale.languageCode == 'ar'
                  ? 'تم حفظ الملف الشخصي'
                  : 'Profile saved successfully',
            ),
            backgroundColor: Colors.green.shade700,
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

    final body = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        GlassSliverAppBar(
          expandedHeight: 120,
          pinned: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft),
            onPressed: () => context.pop(),
          ),
          title: Text(
            isArabic ? 'الملف الشخصي' : 'Edit Profile',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: _isSaving ? null : _saveProfile,
              child: _isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      isArabic ? 'حفظ' : 'Save',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Avatar
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.1),
                      backgroundImage: auth.avatarUrl != null
                          ? NetworkImage(auth.avatarUrl!)
                          : null,
                      child: auth.avatarUrl == null
                          ? Icon(
                              LucideIcons.user,
                              size: 50,
                              color: Theme.of(context).primaryColor,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Full Name
              _buildField(
                context,
                label: isArabic ? 'الاسم الكامل' : 'Full Name',
                controller: _nameController,
                icon: LucideIcons.user,
                isGlass: isGlass,
              ),
              const SizedBox(height: 16),

              // Email (read-only)
              _buildField(
                context,
                label: isArabic ? 'البريد الإلكتروني' : 'Email',
                controller: TextEditingController(text: auth.user?.email ?? ''),
                icon: LucideIcons.mail,
                isGlass: isGlass,
                readOnly: true,
              ),
              const SizedBox(height: 16),

              // Phone
              _buildField(
                context,
                label: isArabic ? 'رقم الهاتف' : 'Phone',
                controller: _phoneController,
                icon: LucideIcons.phone,
                isGlass: isGlass,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              // Bio
              _buildField(
                context,
                label: isArabic ? 'نبذة' : 'Bio',
                controller: _bioController,
                icon: LucideIcons.fileText,
                isGlass: isGlass,
                maxLines: 4,
              ),

              // Role info (read-only)
              const SizedBox(height: 24),
              GlassContainer(
                borderRadius: BorderRadius.circular(16),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.shield,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isArabic ? 'الدور' : 'Role',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        Text(
                          auth.role.displayName(isArabic: isArabic),
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }

  Widget _buildField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required bool isGlass,
    bool readOnly = false,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        filled: isGlass,
        fillColor: isGlass ? Colors.white.withValues(alpha: 0.4) : null,
        enabled: !readOnly,
      ),
    );
  }
}
