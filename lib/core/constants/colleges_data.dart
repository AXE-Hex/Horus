import 'package:flutter/material.dart';

part 'college_catalog.dart';

class StaticCollegeData {
  final String id;
  final String nameEn;
  final String nameAr;
  final String imagePath;
  final Color themeColor;
  final String established;

  final CollegeSection about;
  final DeanInfo dean;
  final CollegeStats stats;
  final List<String> departmentsAr;
  final List<String> departmentsEn;

  const StaticCollegeData({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.imagePath,
    required this.themeColor,
    required this.established,
    required this.about,
    required this.dean,
    required this.stats,
    required this.departmentsAr,
    required this.departmentsEn,
  });
}

class CollegeSection {
  final String originsAr;
  final String originsEn;
  final String visionAr;
  final String visionEn;
  final String missionAr;
  final String missionEn;
  final List<String> goalsAr;
  final List<String> goalsEn;

  const CollegeSection({
    required this.originsAr,
    required this.originsEn,
    required this.visionAr,
    required this.visionEn,
    required this.missionAr,
    required this.missionEn,
    required this.goalsAr,
    required this.goalsEn,
  });
}

class DeanInfo {
  final String nameAr;
  final String nameEn;
  final String titleAr;
  final String titleEn;
  final String bioAr;
  final String bioEn;
  final String? imagePath;

  const DeanInfo({
    required this.nameAr,
    required this.nameEn,
    required this.titleAr,
    required this.titleEn,
    required this.bioAr,
    required this.bioEn,
    this.imagePath,
  });
}

class CollegeStats {
  final int students;
  final int faculty;
  final int assistantStaff;
  final int researchPapers;

  const CollegeStats({
    required this.students,
    required this.faculty,
    required this.assistantStaff,
    required this.researchPapers,
  });
}
