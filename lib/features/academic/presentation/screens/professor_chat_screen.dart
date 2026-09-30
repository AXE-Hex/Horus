import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/features/academic/data/models/professor_profile_models.dart';

class ProfessorChatScreen extends StatelessWidget {
  const ProfessorChatScreen({super.key, required this.profile});

  final ProfessorProfile profile;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(profile.name),
      leading: BackButton(onPressed: () => context.pop()),
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.forum_outlined,
              size: 40,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(t.academic.no_data, textAlign: TextAlign.center),
          ],
        ),
      ),
    ),
  );
}
