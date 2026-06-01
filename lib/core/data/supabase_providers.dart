import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/config/supabase_client.dart';
import 'package:horus/features/shared/data/repositories/shared_repository.dart';
import 'package:horus/features/onboarding/data/repositories/onboarding_repository.dart';

final sharedRepositoryProvider = Provider<SharedRepository>((ref) {
  return SharedRepository(ref.watch(supabaseClientProvider));
});

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  return OnboardingRepository(ref.watch(supabaseClientProvider));
});
