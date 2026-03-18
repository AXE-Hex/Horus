import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/features/admin/data/models/audit_models.dart';
import 'package:hue/features/admin/data/repositories/audit_repository.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

class AuditLogsScreen extends ConsumerStatefulWidget {
  const AuditLogsScreen({super.key});

  @override
  ConsumerState<AuditLogsScreen> createState() => _AuditLogsScreenState();
}

class _AuditLogsScreenState extends ConsumerState<AuditLogsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<AuditLogModel> _filterLogs(List<AuditLogModel> logs, int tabIndex) {
    if (tabIndex == 0) return logs;

    return logs.where((log) {
      if (tabIndex == 1) {
        return ['login', 'logout', 'password_reset'].contains(log.action);
      } else if (tabIndex == 2) {
        return [
              'create',
              'delete',
              'toggle_status',
              'role_change',
            ].contains(log.action) ||
            log.tableName == 'profiles' ||
            log.tableName == 'users';
      } else if (tabIndex == 3) {
        return ['update', 'insert'].contains(log.action) ||
            (log.tableName != 'profiles' &&
                log.tableName != 'users' &&
                !['login', 'logout', 'password_reset'].contains(log.action));
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: AppBar(
        title: Text(
          t.administration.audit_logs.title,
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Theme.of(context).primaryColor,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.white60,
          tabs: [
            Tab(text: t.administration.audit_logs.tabs.all),
            Tab(text: t.administration.audit_logs.tabs.security),
            Tab(text: t.administration.audit_logs.tabs.user_management),
            Tab(text: t.administration.audit_logs.tabs.data_updates),
          ],
        ),
      ),
      body: StreamBuilder<List<AuditLogModel>>(
        stream: ref.read(auditRepositoryProvider).watchLogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final allLogs = snapshot.data ?? [];

          return TabBarView(
            controller: _tabController,
            children: List.generate(4, (index) {
              final logs = _filterLogs(allLogs, index);

              if (logs.isEmpty) {
                return Center(
                  child: Text(
                    t.administration.audit_logs.no_logs_found,
                    style: GoogleFonts.inter(color: Colors.white70),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: logs.length,
                itemBuilder: (context, i) {
                  return _AuditLogCard(log: logs[i], index: i);
                },
              );
            }),
          );
        },
      ),
    );
  }
}

class _AuditLogCard extends StatelessWidget {
  final AuditLogModel log;
  final int index;

  const _AuditLogCard({required this.log, required this.index});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child:
          GlassContainer(
                padding: const EdgeInsets.all(24),
                borderRadius: BorderRadius.circular(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _ActionBadge(action: log.action),
                        Text(
                          dateFormat.format(log.createdAt),
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    _InfoRow(
                      icon: LucideIcons.user,
                      label: t.administration.audit_logs.labels.actor,
                      value:
                          log.actorName ??
                          (log.performedBy != null ? "User" : "System"),
                      trailing: log.performedBy != null
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.05),
                                ),
                              ),
                              child: Text(
                                '#${log.performedBy!.length > 8 ? log.performedBy!.substring(0, 8) : log.performedBy}',
                                style: GoogleFonts.firaCode(
                                  fontSize: 10,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : null,
                    ),

                    if (log.tableName != null) ...[
                      SizedBox(height: 8),
                      _InfoRow(
                        icon: LucideIcons.database,
                        label: t.administration.audit_logs.labels.table,
                        value: log.tableName!,
                      ),
                    ],

                    if (log.recordId != null) ...[
                      SizedBox(height: 8),
                      _InfoRow(
                        icon: LucideIcons.fileKey2,
                        label: t.administration.audit_logs.labels.record,
                        value: log.recordId!,
                      ),
                    ],

                    if (log.notes != null && log.notes!.isNotEmpty) ...[
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.administration.audit_logs.labels.notes,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              log.notes!,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    if (log.oldData != null || log.newData != null) ...[
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () => _showDataDialog(context, log),
                          icon: Icon(LucideIcons.fileJson, size: 16),
                          label: Text(
                            t.administration.audit_logs.labels.view_details,
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              )
              .animate()
              .fadeIn(delay: (index * 50).ms)
              .slideX(begin: 0.05, end: 0, delay: (index * 50).ms),
    );
  }

  void _showDataDialog(BuildContext context, AuditLogModel log) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          t.administration.audit_logs.labels.view_details,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (log.oldData != null) ...[
                  Text(
                    t.administration.audit_logs.labels.old_data,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _JsonView(data: log.oldData!),
                  const SizedBox(height: 16),
                ],
                if (log.newData != null) ...[
                  Text(
                    t.administration.audit_logs.labels.new_data,
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _JsonView(data: log.newData!),
                ],
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.administration.audit_logs.labels.close_details),
          ),
        ],
      ),
    );
  }
}

class _ActionBadge extends StatelessWidget {
  final String action;

  const _ActionBadge({required this.action});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (action.toLowerCase()) {
      case 'create':
      case 'insert':
      case 'login':
        color = Colors.greenAccent;
        break;
      case 'delete':
      case 'logout':
        color = Colors.redAccent;
        break;
      case 'update':
      case 'toggle_status':
      case 'role_change':
      case 'password_reset':
        color = Colors.amberAccent;
        break;
      default:
        color = Theme.of(context).primaryColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        action.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.white54),
        SizedBox(width: 8),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    children: [
                      TextSpan(
                        text: '$label: ',
                        style: const TextStyle(color: Colors.white54),
                      ),
                      TextSpan(
                        text: value,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              if (trailing != null) ...[const SizedBox(width: 8), trailing!],
            ],
          ),
        ),
      ],
    );
  }
}

class _JsonView extends StatelessWidget {
  final Map<String, dynamic> data;

  const _JsonView({required this.data});

  @override
  Widget build(BuildContext context) {
    const encoder = JsonEncoder.withIndent('  ');
    final formatted = encoder.convert(data);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SelectableText(
        formatted,
        style: GoogleFonts.firaCode(fontSize: 12, color: Colors.green[200]),
      ),
    );
  }
}
