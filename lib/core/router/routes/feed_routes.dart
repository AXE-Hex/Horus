import 'package:go_router/go_router.dart';
import 'package:hue/features/feed/presentation/screens/create_post_screen.dart';
import 'package:hue/features/feed/domain/models/post_model.dart';

import 'package:hue/features/feed/presentation/screens/feed_screen.dart';

final List<RouteBase> feedRoutes = [
  GoRoute(
    path: '/create-post',
    builder: (context, state) {
      final extras = state.extra as Map<String, dynamic>? ?? {};
      final initialType = extras['type'] as PostType? ?? PostType.text;
      return CreatePostScreen(initialType: initialType);
    },
  ),
  GoRoute(path: '/feed', builder: (context, state) => const FeedScreen()),
];
