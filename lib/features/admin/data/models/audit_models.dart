class AuditLogModel {
  final String id;
  final String? actorId;
  final String? actorName;
  final String action;
  final String entityType;
  final String? entityId;
  final Map<String, dynamic>? oldData;
  final Map<String, dynamic>? newData;
  final String? ipAddress;
  final String? userAgent;
  final String? report;
  final DateTime createdAt;

  AuditLogModel({
    required this.id,
    this.actorId,
    this.actorName,
    required this.action,
    required this.entityType,
    this.entityId,
    this.oldData,
    this.newData,
    this.ipAddress,
    this.userAgent,
    this.report,
    required this.createdAt,
  });

  factory AuditLogModel.fromJson(Map<String, dynamic> json) {
    return AuditLogModel(
      id: json['id'] as String,
      actorId: json['actor_id'] as String?,
      actorName: json['actor_name'] as String?,
      action: json['action'] as String,
      entityType: json['entity_type'] as String,
      entityId: json['entity_id'] as String?,
      oldData: json['old_data'] as Map<String, dynamic>?,
      newData: json['new_data'] as Map<String, dynamic>?,
      ipAddress: json['ip_address'] as String?,
      userAgent: json['user_agent'] as String?,
      report: json['report'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'actor_id': actorId,
      'actor_name': actorName,
      'action': action,
      'entity_type': entityType,
      'entity_id': entityId,
      'old_data': oldData,
      'new_data': newData,
      'ip_address': ipAddress,
      'user_agent': userAgent,
      'report': report,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
