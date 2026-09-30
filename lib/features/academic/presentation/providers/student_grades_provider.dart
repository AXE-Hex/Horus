import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/features/academic/data/models/academic_records.dart';
import 'package:horus/features/academic/data/repositories/academic_repository.dart';

final studentGradesProvider = FutureProvider<List<GradeRecord>>((ref) async {
  final user = ref.watch(authControllerProvider).user;
  if (user == null) return const [];
  final records = await ref
      .watch(academicRepositoryProvider)
      .getStudentGrades(user.id);
  return records.where((record) => record.isPublished).toList();
});
