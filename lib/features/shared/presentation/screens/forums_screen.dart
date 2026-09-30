import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/features/shared/data/models/shared_records.dart';
import 'package:horus/features/shared/data/shared_data_providers.dart';
import 'package:horus/features/shared/presentation/widgets/horus_empty_state.dart';
import 'package:horus/shared/widgets/horus_error_state.dart';
import 'package:horus/shared/widgets/app_card.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ForumsScreen extends ConsumerWidget {
  const ForumsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forums = ref.watch(forumsProvider);
    final isArabic = t.$meta.locale.languageCode == 'ar';
    return Scaffold(
      appBar: AppBar(
        title: Text(t.shared.forums),
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => context.pop(),
          icon: const Icon(LucideIcons.arrowLeft),
        ),
      ),
      body: forums.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => HorusErrorState(
          message: t.enrollment.error_loading,
          onRetry: () => ref.invalidate(forumsProvider),
        ),
        data: (items) {
          if (items.isEmpty) {
            return HorusEmptyState(
              icon: LucideIcons.messagesSquare,
              title: t.academic.no_data,
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final forum = items[index];
              final title = isArabic && forum.nameAr?.isNotEmpty == true
                  ? forum.nameAr!
                  : forum.name;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppCard(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(_iconFor(forum.category)),
                    title: Text(title),
                    subtitle: forum.description == null
                        ? null
                        : Text(forum.description!),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  IconData _iconFor(ForumCategory category) => switch (category) {
    ForumCategory.general => LucideIcons.messagesSquare,
    ForumCategory.academic => LucideIcons.graduationCap,
    ForumCategory.social => LucideIcons.users,
    ForumCategory.feedback => LucideIcons.messageSquareText,
    ForumCategory.unknown => LucideIcons.messageCircle,
  };
}
