import 'package:flutter/material.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/features/shared/presentation/widgets/horus_empty_state.dart';

class SubmitRatingScreen extends StatelessWidget {
  const SubmitRatingScreen({super.key, required this.staffMember});
  final Map<String, dynamic> staffMember;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(t.academic.reviews_unavailable)),
    body: HorusEmptyState(
      icon: Icons.rate_review_outlined,
      title: t.academic.reviews_unavailable,
      subtitle: t.academic.reviews_unavailable_description,
    ),
  );
}
