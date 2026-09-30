import 'package:flutter/material.dart';
import 'package:horus/core/router/route_guard.dart';

class HorusDestination {
  const HorusDestination({
    required this.route,
    required this.label,
    required this.icon,
  });
  final String route;
  final String label;
  final IconData icon;
}

/// Uses the same permission contract as direct route entry.
List<HorusDestination> accessibleDestinations(
  Iterable<HorusDestination> destinations,
  Set<String> permissions,
) => destinations
    .where((item) => canAccessRoute(item.route, permissions))
    .toList(growable: false);
