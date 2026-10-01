import 'package:google_fonts/google_fonts.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/theme/app_spacing.dart';
import 'package:horus/features/academic/data/repositories/academic_repository.dart';
import 'package:horus/features/academic/data/repositories/professor_repository.dart';
import 'package:horus/features/enrollment/data/models/registration_models.dart';

final _uploadCoursesProvider = FutureProvider.autoDispose<List<Course>>((ref) {
  final user = ref.watch(authControllerProvider).user;
  if (user == null) return [];
  return ref.watch(academicRepositoryProvider).getCoursesByProfessor(user.id);
});

class CourseFileUploadDialog extends ConsumerStatefulWidget {
  const CourseFileUploadDialog({super.key});
  @override
  ConsumerState<CourseFileUploadDialog> createState() =>
      _CourseFileUploadDialogState();
}

class _CourseFileUploadDialogState
    extends ConsumerState<CourseFileUploadDialog> {
  final _title = TextEditingController();
  XFile? _file;
  String? _courseId;
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    try {
      final file = await openFile();
      if (file == null || !mounted) return;
      final length = await file.length();
      if (!mounted) return;
      setState(() {
        if (length == 0 || length > 50 * 1024 * 1024) {
          _error = t.academic.upload_file_size_error;
        } else {
          _file = file;
          _error = null;
        }
      });
    } catch (_) {
      if (mounted) setState(() => _error = t.academic.error);
    }
  }

  Future<void> _upload() async {
    final user = ref.read(authControllerProvider).user;
    if (user == null ||
        _file == null ||
        _courseId == null ||
        _title.text.trim().isEmpty) {
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref
          .read(professorRepositoryProvider)
          .uploadSharedFile(
            professorId: user.id,
            courseId: _courseId!,
            title: _title.text,
            bytes: await _file!.readAsBytes(),
            fileName: _file!.name,
          );
      ref.invalidate(professorProfileProvider);
      if (mounted) Navigator.pop(context, true);
    } catch (_) {
      if (mounted) {
        setState(() {
          _busy = false;
          _error = t.academic.error;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final courses = ref.watch(_uploadCoursesProvider);
    return PopScope(
      canPop: !_busy,
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white10),
          borderRadius: BorderRadius.circular(24),
        ),
        title: Text(
          t.academic.upload_new_file,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SizedBox(
          width: 320,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                courses.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (_, _) => Text(t.academic.error),
                  data: (items) => items.isEmpty
                      ? Text(t.academic.no_data)
                      : DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: t.academic.courses,
                          ),
                          items: [
                            for (final course in items)
                              DropdownMenuItem(
                                value: course.id,
                                child: Text(
                                  course.code,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                          onChanged: _busy
                              ? null
                              : (value) => setState(() => _courseId = value),
                        ),
                ),
                const SizedBox(height: AppSpacing.lg),
                TextField(
                  controller: _title,
                  enabled: !_busy,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: t.academic.file_title,
                    labelStyle: const TextStyle(color: Colors.white60),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white10),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6366F1)),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                OutlinedButton.icon(
                  onPressed: _busy ? null : _pickFile,
                  icon: const Icon(Icons.attach_file, color: Colors.white70),
                  label: Text(
                    _file?.name ?? t.academic.file_will_be_uploaded_to_cloud,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: _file != null ? Colors.white : Colors.white38,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.md),
                    child: Text(
                      _error!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                if (_busy) const LinearProgressIndicator(),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _busy ? null : () => Navigator.pop(context),
            child: Text(
              t.academic.cancel,
              style: const TextStyle(color: Colors.white60),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _busy || _file == null || _courseId == null
                ? null
                : _upload,
            child: Text(
              t.academic.upload,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
