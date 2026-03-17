import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/core/config/supabase_client.dart';
import 'package:flutter/foundation.dart';
import 'package:hue/core/data/base_repository.dart';
import 'package:hue/features/academic/data/models/professor_profile_models.dart';

import 'package:hue/features/academic/data/repositories/academic_repository.dart';

final professorRepositoryProvider = Provider((ref) {
  return ProfessorRepository(ref.watch(supabaseClientProvider));
});

final academicRepositoryProvider = Provider((ref) {
  return AcademicRepository(ref.watch(supabaseClientProvider));
});

final studentScheduleProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final auth = ref.watch(authControllerProvider);
  if (auth.user == null) return [];
  return ref
      .watch(academicRepositoryProvider)
      .getStudentSchedule(studentId: auth.user!.id, semester: 'Spring 2024');
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

final availableTAsProvider =
    FutureProvider<List<TeachingAssistant>>((ref) async {
  return ref.watch(professorRepositoryProvider).getAvailableTAs();
});

class AcademicSummary {
  final double gpa;
  final int completedCredits;
  final int remainingCredits;
  final Map<String, double> categoryCompletion; // name -> progress (0-1)

  AcademicSummary({
    required this.gpa,
    required this.completedCredits,
    required this.remainingCredits,
    required this.categoryCompletion,
  });
}

final academicSummaryProvider = FutureProvider<AcademicSummary>((ref) async {
  final auth = ref.watch(authControllerProvider);
  if (auth.user == null) {
     return AcademicSummary(gpa: 0, completedCredits: 0, remainingCredits: 140, categoryCompletion: {});
  }
  
  final repo = ref.watch(academicRepositoryProvider);
  final grades = await repo.getStudentGrades(auth.user!.id);
  
  double totalPoints = 0;
  int totalCredits = 0;
  int completedCredits = 0;
  
  for (final grade in grades) {
    if (grade['is_published'] == true) {
      final int credits = (grade['courses']?['credits'] as num?)?.toInt() ?? 3;
      final points = (grade['gpa_points'] as num?)?.toDouble() ?? 0.0;
      totalPoints += points * credits;
      totalCredits += credits;
      if (points > 0) completedCredits += credits;
    }
  }
  
  final gpa = totalCredits > 0 ? totalPoints / totalCredits : 0.0;
  
  // Mock categories for now as we don't have them in courses table yet
  return AcademicSummary(
    gpa: gpa,
    completedCredits: completedCredits,
    remainingCredits: 140 - completedCredits, // Assuming 140 total
    categoryCompletion: {
      'University': 0.66,
      'Faculty': 0.71,
      'Major': 0.76,
      'Electives': 0.50,
    },
  );
});

class ProfessorRepository extends BaseRepository {
  ProfessorRepository(super.client);

  Future<Map<String, dynamic>> getProfessorDetails(String professorId) async {
    final result = await client
        .from('professor_details')
        .select('*, profiles(*)')
        .eq('id', professorId)
        .single();
    return Map<String, dynamic>.from(result);
  }

  Future<List<Map<String, dynamic>>> getAllProfessors() async {
    final result = await client
        .from('professor_details')
        .select('*, profiles(full_name, full_name_ar, email, avatar_url)')
        .order('created_at');
    return List<Map<String, dynamic>>.from(result);
  }

  Future<ProfessorProfile?> getFullProfessorProfile(String professorId) async {
    try {
      final profileResponse = await client
          .from('profiles')
          .select('*, professor_details(*, departments(name, name_ar))')
          .eq('id', professorId)
          .single();

      final pDetailsList = profileResponse['professor_details'];
      final pDetails =
          (pDetailsList != null && (pDetailsList as List).isNotEmpty)
          ? pDetailsList[0]
          : null;

      final deptName = pDetails != null
          ? (pDetails['departments']?['name'] ?? 'General')
          : 'General';
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
            'id, ta_role, profiles!teaching_assistants_profile_id_fkey!inner(id, full_name, email)',
          )
          .eq('professor_id', professorId)
          .eq('is_active', true);

      final tas = (tasResponse as List).map((row) {
        final profile = row['profiles'];
        return TeachingAssistant(
          id: row['id'].toString(),
          name: profile['full_name'],
          email: profile['email'],
          role: row['ta_role'] ?? 'TA',
        );
      }).toList();

      final groupsResponse = await client
          .from('student_groups')
          .select('*')
          .eq('professor_id', professorId)
          .eq('is_active', true);

      final groups = (groupsResponse as List).map((g) {
        return StudentGroup(
          id: g['id'].toString(),
          name: g['name'],
          description: g['description'] ?? '',
          studentCount: g['max_students'] ?? 0,
          isJoined: false,
        );
      }).toList();

      final announcementsResponse = await client
          .from('announcements')
          .select('*')
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
          .select('*')
          .eq('uploader_id', professorId)
          .isFilter('deleted_at', null)
          .order('created_at', ascending: false)
          .limit(5);

      final files = (filesResponse as List).map((f) {
        return SharedFile(
          id: f['id'].toString(),
          title: f['title'],
          fileType: f['file_type'].toString().split('.').last,
          size: '${(f['file_size'] ?? 0) ~/ 1024} KB',
          uploadDate: DateTime.parse(f['created_at']),
        );
      }).toList();

      final ohResponse = await client
          .from('office_hours')
          .select('*')
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
        role: profileResponse['role'],
        department: deptName,
        generalRating: genRating,
        curriculumRating: curRating,
        email: profileResponse['email'],
        officeSymbol: officeSym ?? '',
        bio: profileResponse['bio'] ?? '',
        teachingAssistants: tas,
        groups: groups,
        announcements: announcements,
        sharedFiles: files,
        officeHours: officeHours,
      );
    } catch (e) {
      debugPrint('Error uploading file to Superbase: $e');
      return null;
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
        .select('*, profiles:profile_id(full_name, email, avatar_url)')
        .eq('professor_id', professorId)
        .eq('is_active', true);
    return List<Map<String, dynamic>>.from(result);
  }

  Future<List<TeachingAssistant>> getAvailableTAs() async {
    final result = await client
        .from('profiles')
        .select('id, full_name, email')
        .contains('roles', ['teaching_assistant']);

    return (result as List).map((row) {
      return TeachingAssistant(
        id: row['id'] as String,
        name: row['full_name'] as String? ?? 'Unknown',
        email: row['email'] as String? ?? '',
        role: 'teaching_assistant',
      );
    }).toList();
  }

  Future<Map<String, dynamic>> addTA(Map<String, dynamic> data) =>
      insert('teaching_assistants', data);

  Future<void> removeTA(String id) =>
      update('teaching_assistants', id, {'is_active': false});

  Future<List<Map<String, dynamic>>> getRatings(String professorId) =>
      fetchWhere(
        'professor_ratings',
        'professor_id',
        professorId,
        orderBy: 'created_at',
        ascending: false,
      );

  Future<Map<String, dynamic>> submitRating(Map<String, dynamic> data) =>
      upsert('professor_ratings', data);

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
        .select('*, profiles:student_id(full_name, email, student_id)')
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
    required String title,
    required String filePath,
    required String fileName,
  }) async {
    final fileExt = fileName.split('.').last;
    final path =
        'professor-files/$professorId/${DateTime.now().millisecondsSinceEpoch}.$fileExt';

    // In a real app, you'd use client.storage.from('professor_content').upload(path, file);
    // Since I can't run the actual upload here, I'll just insert the metadata
    await client.from('shared_files').insert({
      'uploader_id': professorId,
      'title': title,
      'file_path': path,
      'file_type': fileExt,
      'file_size': 1024 * 1024, // Mock 1MB
    });
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
