import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show FileOptions, PostgrestException;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/config/supabase_client.dart';
import 'package:horus/core/data/base_repository.dart';
import 'package:horus/features/academic/data/models/professor_profile_models.dart';
import 'package:horus/features/academic/data/models/academic_records.dart';
import 'package:horus/features/shared/data/models/shared_records.dart';

import 'package:horus/features/academic/data/repositories/academic_repository.dart';
import 'package:horus/features/academic/presentation/providers/semester_provider.dart';

final professorRepositoryProvider = Provider<ProfessorRepository>((ref) {
  return ProfessorRepository(ref.watch(supabaseClientProvider));
});

final studentScheduleProvider = FutureProvider<List<StudentScheduleRecord>>((
  ref,
) async {
  final auth = ref.watch(authControllerProvider);
  if (auth.user == null) return [];
  final semester = await ref.watch(currentSemesterProvider.future);
  if (semester == null) return [];
  return ref
      .watch(academicRepositoryProvider)
      .getStudentSchedule(studentId: auth.user!.id, semester: semester.code);
});

final professorProfileProvider = FutureProvider<ProfessorProfile?>((ref) async {
  final auth = ref.watch(authControllerProvider);
  if (auth.user == null) return null;
  return ref
      .watch(professorRepositoryProvider)
      .getFullProfessorProfile(auth.user!.id);
});

final professorProfileByIdProvider =
    FutureProvider.family<ProfessorProfile?, String>((ref, id) async {
      return ref.watch(professorRepositoryProvider).getFullProfessorProfile(id);
    });

final availableTAsProvider = FutureProvider<List<TeachingAssistant>>((
  ref,
) async {
  return ref.watch(professorRepositoryProvider).getAvailableTAs();
});

final professorAverageRatingProvider = FutureProvider.family<double, String>((
  ref,
  professorId,
) async {
  final details = await ref
      .watch(professorRepositoryProvider)
      .getProfessorDetails(professorId);
  return (details['general_rating'] as num?)?.toDouble() ?? 0.0;
});

class AcademicSummary {
  const AcademicSummary({
    required this.publishedCourseCount,
    required this.recordedCredits,
    required this.gpa,
  });

  final int publishedCourseCount;
  final int recordedCredits;
  final double? gpa;

  bool get hasPublishedGrades => publishedCourseCount > 0;

  factory AcademicSummary.fromGrades(List<GradeRecord> grades) {
    double totalPoints = 0;
    var totalCredits = 0;
    var publishedCourses = 0;

    for (final grade in grades) {
      if (!grade.isPublished) continue;
      publishedCourses++;
      final credits = grade.course?.creditHours;
      final points = grade.gpaPoints;
      if (credits == null || points == null) continue;
      totalPoints += points * credits;
      totalCredits += credits;
    }

    return AcademicSummary(
      publishedCourseCount: publishedCourses,
      recordedCredits: totalCredits,
      gpa: totalCredits == 0 ? null : totalPoints / totalCredits,
    );
  }
}

final academicSummaryProvider = FutureProvider<AcademicSummary>((ref) async {
  final auth = ref.watch(authControllerProvider);
  if (auth.user == null) {
    return const AcademicSummary(
      publishedCourseCount: 0,
      recordedCredits: 0,
      gpa: null,
    );
  }

  final repo = ref.watch(academicRepositoryProvider);
  final grades = await repo.getStudentGrades(auth.user!.id);

  return AcademicSummary.fromGrades(grades);
});

class ProfessorRepository extends BaseRepository {
  ProfessorRepository(super.client);

  Future<Map<String, dynamic>> getProfessorDetails(String professorId) async {
    final result = await client
        .from('professor_details')
        .select(
          '*, profiles(id, full_name, full_name_ar, avatar_url, college_id, department_id, created_at, updated_at)',
        )
        .eq('id', professorId)
        .single();
    return Map<String, dynamic>.from(result);
  }

  Future<List<Map<String, dynamic>>> getAllProfessors() async {
    final result = await client
        .from('professor_details')
        .select('*, profiles(full_name, full_name_ar, avatar_url)')
        .order('created_at');
    return List<Map<String, dynamic>>.from(result);
  }

  Future<ProfessorProfile?> getFullProfessorProfile(String professorId) async {
    try {
      final profileResponse = await client
          .from('profiles')
          .select(
            'id, full_name, full_name_ar, avatar_url, college_id, department_id, created_at, updated_at',
          )
          .eq('id', professorId)
          .maybeSingle();

      if (profileResponse == null) return null;

      // Keep public identity independent of optional details. The current
      // details policy may deny its nested profile read; do not broaden grants
      // or let that denial hide all otherwise authorized campus data.
      Map<String, dynamic>? pDetails;
      try {
        final detailsRows = await client
            .from('professor_details')
            .select(
              'id,office_symbol,general_rating,curriculum_rating,total_ratings',
            )
            .eq('id', professorId)
            .limit(1);
        pDetails = detailsRows.firstOrNull;
      } on PostgrestException catch (error) {
        if (error.code != '42501') rethrow;
      }
      final departmentId = profileResponse['department_id'] as String?;
      final department = departmentId == null
          ? null
          : await client
                .from('departments')
                .select('name_en,name_ar')
                .eq('id', departmentId)
                .maybeSingle();
      final deptName = department?['name_en'] ?? '';

      final officeSym = pDetails != null ? pDetails['office_symbol'] : '';
      final genRating = pDetails != null
          ? (pDetails['general_rating'] as num?)?.toDouble() ?? 0.0
          : 0.0;
      final curRating = pDetails != null
          ? (pDetails['curriculum_rating'] as num?)?.toDouble() ?? 0.0
          : 0.0;

      final tasResponse = await client
          .from('teaching_assistants')
          .select(
            'id, ta_role, profiles!teaching_assistants_profile_id_fkey!inner(id, full_name)',
          )
          .eq('professor_id', professorId)
          .eq('is_active', true);

      final tas = (tasResponse as List).map((row) {
        final profile = row['profiles'];
        return TeachingAssistant(
          id: row['id'].toString(),
          name: profile['full_name'],
          email: '',
          role: row['ta_role'] ?? 'TA',
        );
      }).toList();

      final groupsResponse = await client
          .from('student_groups')
          .select('id,name,description,group_members(count)')
          .eq('professor_id', professorId)
          .eq('is_active', true)
          .limit(100);

      final groups = (groupsResponse as List).map((g) {
        return StudentGroup(
          id: g['id'].toString(),
          name: g['name'],
          description: g['description'] ?? '',
          studentCount: (g['group_members'] as List).isEmpty
              ? 0
              : (g['group_members'][0]['count'] as num).toInt(),
          isJoined: false,
        );
      }).toList();

      final announcementsResponse = await client
          .from('announcements')
          .select('id,title,content,priority,created_at')
          .eq('author_id', professorId)
          .isFilter('deleted_at', null)
          .order('created_at', ascending: false)
          .limit(5);

      final announcements = (announcementsResponse as List).map((a) {
        return ProfessorAnnouncement(
          id: a['id'].toString(),
          title: a['title'],
          content: a['content'],
          date: DateTime.parse(a['created_at']),
          isUrgent: a['priority'] == 'urgent',
        );
      }).toList();

      final filesResponse = await client
          .from('shared_files')
          .select(
            'id,uploader_id,title,title_ar,file_path,file_type,file_size,download_count,is_public,created_at,course_id,deleted_at',
          )
          .eq('uploader_id', professorId)
          .isFilter('deleted_at', null)
          .order('created_at', ascending: false)
          .limit(5);

      final files = (filesResponse as List)
          .map(
            (row) => SharedFileRecord.fromJson(Map<String, dynamic>.from(row)),
          )
          .toList();

      final ohResponse = await client
          .from('office_hours')
          .select('id,day,start_time,end_time,location,is_walk_in')
          .eq('professor_id', professorId);

      final officeHours = (ohResponse as List).map((o) {
        return OfficeHour(
          id: o['id'].toString(),
          dayOfWeek: o['day'].toString(),
          timeRange: '${o['start_time']} - ${o['end_time']}',
          location: o['location'],
          isWalkIn: o['is_walk_in'],
        );
      }).toList();

      return ProfessorProfile(
        id: profileResponse['id'],
        name: profileResponse['full_name'],
        role: '',
        department: deptName,
        generalRating: genRating,
        totalRatings: (pDetails?['total_ratings'] as num?)?.toInt() ?? 0,
        curriculumRating: curRating,
        email: '',
        officeSymbol: officeSym ?? '',
        bio: profileResponse['bio'] ?? '',
        teachingAssistants: tas,
        groups: groups,
        announcements: announcements,
        sharedFiles: files,
        officeHours: officeHours,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getOfficeHours(String professorId) =>
      fetchWhere('office_hours', 'professor_id', professorId, orderBy: 'day');

  Future<Map<String, dynamic>> addOfficeHour(Map<String, dynamic> data) =>
      insert('office_hours', data);

  Future<void> removeOfficeHour(String id) => hardDelete('office_hours', id);

  Future<List<Map<String, dynamic>>> getTAs(String professorId) async {
    final result = await client
        .from('teaching_assistants')
        .select('*, profiles:profile_id(full_name, avatar_url)')
        .eq('professor_id', professorId)
        .eq('is_active', true);
    return List<Map<String, dynamic>>.from(result);
  }

  Future<List<TeachingAssistant>> getAvailableTAs() async {
    final result = await client
        .from('profile_directory')
        .select('id, full_name, role_codes')
        .contains('role_codes', ['teaching_assistant']);

    return (result as List).map((row) {
      return TeachingAssistant(
        id: row['id'] as String,
        name: row['full_name'] as String? ?? 'Unknown',
        email: '',
        role: 'teaching_assistant',
      );
    }).toList();
  }

  Future<Map<String, dynamic>> addTA(Map<String, dynamic> data) =>
      insert('teaching_assistants', data);

  Future<void> removeTA(String id) =>
      update('teaching_assistants', id, {'is_active': false});

  Future<List<Map<String, dynamic>>> getGroups(String professorId) =>
      fetchWhere(
        'student_groups',
        'professor_id',
        professorId,
        orderBy: 'name',
      );

  Future<Map<String, dynamic>> createGroup(Map<String, dynamic> data) =>
      insert('student_groups', data);

  Future<List<Map<String, dynamic>>> getGroupMembers(String groupId) async {
    final result = await client
        .from('group_members')
        .select('*, profiles:student_id(full_name)')
        .eq('group_id', groupId)
        .order('joined_at');
    return List<Map<String, dynamic>>.from(result);
  }

  Future<void> joinGroup(String groupId, String studentId) =>
      insert('group_members', {'group_id': groupId, 'student_id': studentId});

  Future<void> leaveGroup(String groupId, String studentId) async {
    await client
        .from('group_members')
        .delete()
        .eq('group_id', groupId)
        .eq('student_id', studentId);
  }

  Future<void> uploadSharedFile({
    required String professorId,
    required String courseId,
    required String title,
    required Uint8List bytes,
    required String fileName,
  }) async {
    if (client.auth.currentUser?.id != professorId ||
        title.trim().isEmpty ||
        bytes.isEmpty ||
        bytes.length > 50 * 1024 * 1024) {
      throw ArgumentError('Invalid file upload.');
    }
    final extension = fileName.split('.').last.toLowerCase();
    const mimeTypes = {
      'pdf': 'application/pdf',
      'doc': 'application/msword',
      'docx':
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'pptx':
          'application/vnd.openxmlformats-officedocument.presentationml.presentation',
      'xlsx':
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'txt': 'text/plain',
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'png': 'image/png',
      'webp': 'image/webp',
      'mp4': 'video/mp4',
      'webm': 'video/webm',
    };
    final mimeType = mimeTypes[extension];
    if (mimeType == null) throw ArgumentError('Unsupported file type.');
    final id = const Uuid().v4();
    final path = SharedFileUpload.buildCourseFilePath(
      courseId: courseId,
      uploaderId: professorId,
      fileId: id,
      fileName: fileName,
    );
    final type = switch (extension) {
      'pdf' => SharedFileType.pdf,
      'docx' => SharedFileType.docx,
      'pptx' => SharedFileType.pptx,
      'xlsx' => SharedFileType.xlsx,
      'jpg' || 'jpeg' || 'png' || 'webp' => SharedFileType.image,
      'mp4' || 'webm' => SharedFileType.video,
      _ => SharedFileType.other,
    };
    final bucket = client.storage.from('course_files');
    await bucket.uploadBinary(
      path,
      bytes,
      fileOptions: FileOptions(contentType: mimeType),
    );
    try {
      await client
          .from('shared_files')
          .insert(
            SharedFileUpload(
              id: id,
              uploaderId: professorId,
              courseId: courseId,
              title: title.trim(),
              path: path,
              fileType: type,
              fileSizeBytes: bytes.length,
            ).toDatabase(),
          );
    } catch (_) {
      // Compensate an incomplete upload rather than leave an unbound object.
      await bucket.remove([path]);
      rethrow;
    }
  }

  Future<void> addMemberToGroup(String groupId, String studentId) async {
    await client.from('group_members').insert({
      'group_id': groupId,
      'student_id': studentId,
    });
  }

  Future<void> updateProfessorDetail(
    String id,
    Map<String, dynamic> data,
  ) async {
    await client.from('professor_details').update(data).eq('id', id);
  }
}
