import 'package:horus/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/features/shared/data/notification_provider.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const isGlass = false;
    final notificationsAsync = ref.watch(notificationControllerProvider);

    final body = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        GlassSliverAppBar(
          expandedHeight: 140,
          floating: true,
          pinned: true,
          backgroundColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              t.shared.notifications,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            centerTitle: true,
          ),
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          actions: [
            IconButton(
              tooltip: t.$meta.locale.languageCode == 'ar'
                  ? 'تحديد الكل كمقروء'
                  : 'Mark all as read',
              icon: const Icon(Icons.done_all, color: Colors.white70),
              onPressed: () {
                HapticFeedback.mediumImpact();
                ref
                    .read(notificationControllerProvider.notifier)
                    .markAllAsRead();
              },
            ),
          ],
        ),
        notificationsAsync.when(
          data: (notifications) {
            if (notifications.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.bellOff,
                        size: 64,
                        color: Colors.white10,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        t.shared.no_notifications_yet,
                        style: TextStyle(color: Colors.white30),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return _buildGravityTile(
                    context,
                    notifications[index],
                    isGlass,
                    index,
                    ref,
                  );
                }, childCount: notifications.length),
              ),
            );
          },
          loading: () => const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, _) =>
              SliverFillRemaining(child: Center(child: Text(t.shared.error))),
        ),
      ],
    );

    return Scaffold(body: body);
  }

  Widget _buildGravityTile(
    BuildContext context,
    AppNotification note,
    bool isGlass,
    int index,
    WidgetRef ref,
  ) {
    Color color;
    IconData icon;
    switch (note.category) {
      case NotificationCategory.academic:
        color = Colors.blue;
        icon = LucideIcons.bookOpen;
        break;
      case NotificationCategory.finance:
        color = Colors.green;
        icon = LucideIcons.dollarSign;
        break;
      case NotificationCategory.security:
        color = Colors.red;
        icon = LucideIcons.shieldAlert;
        break;
      default:
        color = Colors.orange;
        icon = LucideIcons.bell;
    }

    final content = InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        ref.read(notificationControllerProvider.notifier).markAsRead(note.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: note.isRead ? 0.05 : 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color.withValues(alpha: note.isRead ? 0.3 : 1.0),
                size: 18,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: (note.isRead
                          ? Colors.grey
                          : Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    note.message,
                    style: TextStyle(
                      fontSize: 13,
                      color: (note.isRead
                          ? Colors.grey.shade300
                          : Theme.of(context).hintColor),
                    ),
                  ),
                ],
              ),
            ),
            if (!note.isRead)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ).animate().shimmer(duration: 1.seconds),
          ],
        ),
      ),
    );

    return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: content,
          ),
        )
        .animate()
        .fadeIn(delay: (index * 100).ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutBack)
        .shimmer(delay: 1.seconds, duration: 2.seconds);
  }
}
