import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/config/supabase_client.dart';

const fallbackSemesterName = 'Spring 2024';

final currentSemesterProvider = FutureProvider<String>((ref) async {
  final client = ref.watch(supabaseClientProvider);

  try {
    final current = await client
        .from('semesters')
        .select('name_en')
        .eq('is_current', true)
        .eq('is_active', true)
        .maybeSingle();

    final name = current?['name_en'] as String?;
    if (name != null && name.trim().isNotEmpty) {
      return name;
    }
  } catch (_) {
    // Keep legacy screens usable while local/development databases catch up.
  }

  return fallbackSemesterName;
});
