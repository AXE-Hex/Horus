import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/features/shared/data/models/shared_records.dart';
import 'package:horus/features/shared/data/repositories/shared_repository.dart';

final forumsProvider = FutureProvider.autoDispose<List<ForumRecord>>(
  (ref) => ref.read(sharedRepositoryProvider).getForums(),
);

final userSessionsProvider =
    FutureProvider.autoDispose<List<UserSessionRecord>>((ref) async {
      final userId = ref.watch(authControllerProvider).user?.id;
      if (userId == null) return const [];
      return ref.read(sharedRepositoryProvider).getUserSessions(userId);
    });
