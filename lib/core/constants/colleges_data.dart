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
