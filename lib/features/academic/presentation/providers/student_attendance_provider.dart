import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/features/academic/data/models/academic_records.dart';
import 'package:horus/features/academic/data/repositories/academic_repository.dart';

const attendancePageSize = 50;
final studentAttendanceProvider = FutureProvider.autoDispose
    .family<List<AttendanceRecord>, int>((ref, page) {
      final user = ref.watch(authControllerProvider).user;
      if (user == null) return const [];
      return ref
          .watch(academicRepositoryProvider)
          .getStudentAttendanceRecords(
            user.id,
            offset: page * attendancePageSize,
            limit: attendancePageSize,
          );
    });
