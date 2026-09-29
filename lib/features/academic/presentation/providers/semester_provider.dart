import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/features/academic/data/repositories/academic_repository.dart';

const fallbackSemesterName = 'Spring 2024';

final currentSemesterProvider = FutureProvider<String>((ref) async {
  final repository = ref.watch(academicRepositoryProvider);

  try {
    final name = await repository.getCurrentSemesterName();
    if (name != null && name.trim().isNotEmpty) {
      return name;
    }
  } catch (_) {
    // Keep legacy screens usable while local/development databases catch up.
  }

  return fallbackSemesterName;
});
