import 'package:flutter/material.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/features/academic/data/models/academic_records.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

const legacyAcademicColors = [
  Color(0xFF6366F1),
  Color(0xFFEC4899),
  Color(0xFF10B981),
  Color(0xFFF59E0B),
  Color(0xFF8B5CF6),
  Color(0xFF06B6D4),
];

Map<String, dynamic> legacyGradeView(GradeRecord grade, int index) => {
  'name':
      (t.$meta.locale.languageCode == 'ar'
          ? grade.course?.nameAr
          : grade.course?.nameEn) ??
      grade.course?.nameEn ??
      grade.course?.code ??
      grade.courseId,
  'code': grade.course?.code ?? grade.courseId,
  'grade': grade.gradeLetter ?? '—',
  'points': grade.gpaPoints,
  'credits': grade.course?.creditHours,
  'score': grade.total,
  'totalScore': grade.total?.round(),
  // The current grade contract uses a percentage total; component maxima are not in the schema.
  'maxScore': 100,
  'color': legacyAcademicColors[index % legacyAcademicColors.length],
  'icon': LucideIcons.graduationCap,
  'components': [
    for (final component in [
      (t.academic.coursework, grade.coursework),
      (t.academic.midterm_exam, grade.midterm),
      (t.academic.practical_project, grade.practical),
      (t.academic.final_exam, grade.finalExam),
    ])
      {
        'title': component.$1,
        'score': component.$2,
        'max': null,
        'icon': LucideIcons.clipboardList,
        'color': legacyAcademicColors[index % legacyAcademicColors.length],
      },
  ],
};
