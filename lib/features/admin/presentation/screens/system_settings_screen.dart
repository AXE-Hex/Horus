import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SystemSettingsScreen extends ConsumerWidget {
  const SystemSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';

    return GlassScaffold(
      appBar: AppBar(
        title: Text(
          t.admin.system_settings,
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: Supabase.instance.client
            .from('system_settings')
            .stream(primaryKey: ['id']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                t.admin.error_snapshoterror(
                  error: snapshot.error ?? 'Unknown error',
                ),
              ),
            );
          }

          final data = snapshot.data ?? [];
          if (data.isEmpty) {
            return Center(
              child: Text(
                t.admin.no_settings_found_in_the_datab,
                style: GoogleFonts.outfit(fontSize: 16),
              ),
            );
          }

          final Map<String, List<Map<String, dynamic>>> groupedSettings = {};
          for (var item in data) {
            final cat = isArabic
                ? (item['category_ar'] ?? item['category_en'] ?? 'General')
                : (item['category_en'] ?? 'General');
            groupedSettings.putIfAbsent(cat, () => []).add(item);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: groupedSettings.length,
            itemBuilder: (context, index) {
              final category = groupedSettings.keys.elementAt(index);
              final items = groupedSettings[category]!;

              return _buildSettingsSection(
                context,
                title: category,
                icon: LucideIcons.settings,
                children: items.map((item) {
                  return _buildSettingItem(
                    context,
                    item: item,
                    isArabic: isArabic,
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSettingsSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Theme.of(context).primaryColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...children,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required Map<String, dynamic> item,
    required bool isArabic,
  }) {
    final title = isArabic
        ? (item['description_ar'] ?? item['setting_key'] ?? 'Unknown Key')
        : (item['description_en'] ?? item['setting_key'] ?? 'Unknown Key');
    final value = item['setting_value']?.toString() ?? 'N/A';

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title.toString(),
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 12),
                Icon(
                  LucideIcons.edit2,
                  size: 16,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
