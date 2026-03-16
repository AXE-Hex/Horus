import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hue/features/academic/data/repositories/academic_repository.dart';
import 'package:hue/features/academic/data/repositories/professor_repository.dart';
import 'package:hue/features/enrollment/data/repositories/enrollment_repository.dart';
import 'package:hue/features/shared/data/repositories/shared_repository.dart';
import 'package:hue/features/onboarding/data/repositories/onboarding_repository.dart';

final academicRepositoryProvider = Provider<AcademicRepository>((ref) {
  return AcademicRepository(Supabase.instance.client);
});

final professorRepositoryProvider = Provider<ProfessorRepository>((ref) {
  return ProfessorRepository(Supabase.instance.client);
});

final enrollmentRepositoryProvider = Provider<EnrollmentRepository>((ref) {
  return EnrollmentRepository(Supabase.instance.client);
});

final sharedRepositoryProvider = Provider<SharedRepository>((ref) {
  return SharedRepository(Supabase.instance.client);
});

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  return OnboardingRepository(Supabase.instance.client);
});
