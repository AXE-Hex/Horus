import 'dart:async';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'performance_provider.g.dart';

class PerformanceState {
  final double latestLatency;
  final List<double> latencyHistory;

  PerformanceState({required this.latestLatency, required this.latencyHistory});

  PerformanceState copyWith({
    double? latestLatency,
    List<double>? latencyHistory,
  }) {
    return PerformanceState(
      latestLatency: latestLatency ?? this.latestLatency,
      latencyHistory: latencyHistory ?? this.latencyHistory,
    );
  }
}

@Riverpod(keepAlive: true)
class Performance extends _$Performance {
  Timer? _timer;
  final int _maxHistory = 20;

  @override
  PerformanceState build() {
    _startMonitoring();
    ref.onDispose(() => _timer?.cancel());
    return PerformanceState(
      latestLatency: 0,
      latencyHistory: List.filled(20, 0.0),
    );
  }

  void _startMonitoring() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _measureLatency();
    });
  }

  Future<void> _measureLatency() async {
    final stopwatch = Stopwatch()..start();
    try {
      await Supabase.instance.client.from('profiles').select('id').limit(1);
      stopwatch.stop();

      final latency = stopwatch.elapsedMilliseconds.toDouble();
      final newHistory = List<double>.from(state.latencyHistory);

      if (newHistory.length >= _maxHistory) {
        newHistory.removeAt(0);
      }
      newHistory.add(latency);

      state = state.copyWith(
        latestLatency: latency,
        latencyHistory: newHistory,
      );
    } catch (e) {
      stopwatch.stop();
      debugPrint('Performance monitoring error: $e');
    }
  }
}
