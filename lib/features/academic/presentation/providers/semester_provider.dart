import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/features/academic/data/models/academic_records.dart';
import 'package:horus/features/academic/data/repositories/academic_repository.dart';

final currentSemesterProvider = FutureProvider<AcademicSemester?>((ref) async {
  final repository = ref.watch(academicRepositoryProvider);
  return repository.getCurrentSemester();
});
