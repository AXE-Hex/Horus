import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/features/admin/data/models/institutional_models.dart';
import 'package:hue/features/admin/data/repositories/institutional_repository.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hue/features/shared/presentation/widgets/premium_success_overlay.dart';

class AddCollegeScreen extends ConsumerStatefulWidget {
  final CollegeModel? college;

  const AddCollegeScreen({super.key, this.college});

  @override
  ConsumerState<AddCollegeScreen> createState() => _AddCollegeScreenState();
}

class _AddCollegeScreenState extends ConsumerState<AddCollegeScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameEnController;
  late final TextEditingController _nameArController;
  late final TextEditingController _codeController;
  late final TextEditingController _descEnController;
  late final TextEditingController _descArController;
  late final TextEditingController _imageUrlController;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameEnController = TextEditingController(text: widget.college?.nameEn);
    _nameArController = TextEditingController(text: widget.college?.nameAr);
    _codeController = TextEditingController(text: widget.college?.code);
    _descEnController = TextEditingController(
      text: widget.college?.descriptionEn,
    );
    _descArController = TextEditingController(
      text: widget.college?.descriptionAr,
    );
    _imageUrlController = TextEditingController(text: widget.college?.imageUrl);
  }

  @override
  void dispose() {
    _nameEnController.dispose();
    _nameArController.dispose();
    _codeController.dispose();
    _descEnController.dispose();
    _descArController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    HapticFeedback.mediumImpact();

    try {
      final repo = ref.read(institutionalRepositoryProvider);

      final Map<String, dynamic> data = {
        'name': _nameEnController.text.trim(),
        'name_en': _nameEnController.text.trim(),
        'name_ar': _nameArController.text.trim(),
        'code': _codeController.text.trim(),
        'description': _descEnController.text.trim(),
        'description_ar': _descArController.text.trim(),
      };

      if (_imageUrlController.text.trim().isNotEmpty) {
        data['image_url'] = _imageUrlController.text.trim();
      } else {
        data['image_url'] = null;
      }

      if (widget.college == null) {
        await repo.createCollege(data);
      } else {
        await repo.updateCollege(widget.college!.id, data);
      }

      HapticFeedback.heavyImpact();
      if (mounted) {
        PremiumSuccessOverlay.show(
          context,
          title: t.admin.changes_saved_successfully,
          message: widget.college == null
              ? (t.$meta.locale.languageCode == 'ar' ? 'تمت إضافة الكلية بنجاح' : 'College added successfully')
              : (t.$meta.locale.languageCode == 'ar' ? 'تم تحديث بيانات الكلية' : 'College details updated'),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.onSurface,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ).animate().fadeIn().slideX(begin: -0.05, end: 0);
  }

  Widget _buildPremiumField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    Color iconColor = Colors.white,
    bool enabled = true,
    int? maxLines = 1,
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
        enabled: enabled,
        maxLines: maxLines,
        validator: validator,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.inter(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.4),
            fontSize: 13,
          ),
          prefixIcon: maxLines == 1
              ? Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 16),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                    left: 14.0,
                    right: 14.0,
                    top: 14.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: iconColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(icon, color: iconColor, size: 16),
                      ),
                    ],
                  ),
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: primaryColor.withValues(alpha: 0.5),
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: Colors.redAccent.withValues(alpha: 0.5),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.college != null;
    final primaryColor = Theme.of(context).primaryColor;

    return GlassScaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit College' : 'Add New College',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSectionHeader(
                        'General Details',
                        LucideIcons.building,
                        primaryColor,
                      ),
                      const SizedBox(height: 16),
                      _buildPremiumField(
                            label: 'College Name (English)',
                            controller: _nameEnController,
                            icon: LucideIcons.type,
                            iconColor: const Color(0xFF6366F1),
                            validator: (val) =>
                                val == null || val.isEmpty ? 'Required' : null,
                          )
                          .animate()
                          .fadeIn(delay: 100.ms)
                          .slideY(begin: 0.08, end: 0),
                      const SizedBox(height: 14),
                      _buildPremiumField(
                            label: 'College Name (Arabic)',
                            controller: _nameArController,
                            icon: LucideIcons.type,
                            iconColor: const Color(0xFF10B981),
                            validator: (val) =>
                                val == null || val.isEmpty ? 'Required' : null,
                          )
                          .animate()
                          .fadeIn(delay: 150.ms)
                          .slideY(begin: 0.08, end: 0),
                      const SizedBox(height: 14),
                      _buildPremiumField(
                            label: 'College Code',
                            controller: _codeController,
                            icon: LucideIcons.hash,
                            iconColor: Colors.amberAccent,
                            validator: (val) =>
                                val == null || val.isEmpty ? 'Required' : null,
                          )
                          .animate()
                          .fadeIn(delay: 200.ms)
                          .slideY(begin: 0.08, end: 0),
                      const SizedBox(height: 14),
                      _buildPremiumField(
                            label: 'College Logo URL (Optional)',
                            controller: _imageUrlController,
                            icon: LucideIcons.image,
                            iconColor: Colors.pinkAccent,
                          )
                          .animate()
                          .fadeIn(delay: 220.ms)
                          .slideY(begin: 0.08, end: 0),

                      const SizedBox(height: 32),

                      _buildSectionHeader(
                        'Optional Descriptions',
                        LucideIcons.fileText,
                        Colors.tealAccent,
                      ),
                      const SizedBox(height: 16),
                      _buildPremiumField(
                            label: 'Description (English)',
                            controller: _descEnController,
                            icon: LucideIcons.alignLeft,
                            iconColor: Colors.tealAccent,
                            maxLines: 4,
                          )
                          .animate()
                          .fadeIn(delay: 250.ms)
                          .slideY(begin: 0.08, end: 0),
                      const SizedBox(height: 14),
                      _buildPremiumField(
                            label: 'Description (Arabic)',
                            controller: _descArController,
                            icon: LucideIcons.alignRight,
                            iconColor: Colors.tealAccent,
                            maxLines: 4,
                          )
                          .animate()
                          .fadeIn(delay: 300.ms)
                          .slideY(begin: 0.08, end: 0),

                      const SizedBox(height: 40),

                      // Save Button
                      SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _isSaving ? null : _handleSave,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                elevation: 8,
                                shadowColor: primaryColor.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                              child: _isSaving
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(LucideIcons.check, size: 20),
                                        const SizedBox(width: 8),
                                        Text(
                                          isEdit
                                              ? 'Save Changes'
                                              : 'Create College',
                                          style: GoogleFonts.outfit(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 400.ms)
                          .slideY(begin: 0.2, end: 0),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
