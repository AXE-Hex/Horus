class AuditLogModel {
  final String id;
  final String? performedBy;
  final String? actorName;
  final String action;
  final String? tableName;
  final String? recordId;
  final Map<String, dynamic>? oldData;
  final Map<String, dynamic>? newData;
  final String? ipAddress;
  final String? userAgent;
  final String? notes;
  final DateTime createdAt;

  AuditLogModel({
    required this.id,
    this.performedBy,
    this.actorName,
    required this.action,
    this.tableName,
    this.recordId,
    this.oldData,
    this.newData,
    this.ipAddress,
    this.userAgent,
    this.notes,
    required this.createdAt,
  });

  factory AuditLogModel.fromJson(Map<String, dynamic> json) {
    // Extract actor name if the 'profiles' relation is included
    String? actorName;
    if (json['profiles'] != null && json['profiles'] is Map) {
      actorName = json['profiles']['full_name'] as String?;
    }

    return AuditLogModel(
      id: (json['id'] ?? '') as String,
      performedBy: json['performed_by'] as String?,
      actorName: actorName,
      action: (json['action'] ?? 'unknown') as String,
      tableName: json['table_name'] as String?,
      recordId: json['record_id'] as String?,
      oldData: json['old_data'] as Map<String, dynamic>?,
      newData: json['new_data'] as Map<String, dynamic>?,
      ipAddress: json['ip_address'] as String?,
      userAgent: json['user_agent'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'performed_by': performedBy,
      'action': action,
      'table_name': tableName,
      'record_id': recordId,
      'old_data': oldData,
      'new_data': newData,
      'ip_address': ipAddress,
      'user_agent': userAgent,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
