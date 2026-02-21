// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

abstract class AppException implements Exception {
  final String code;
  final String message;
  final dynamic details;

  AppException({required this.code, required this.message, this.details});

  @override
  String toString() => '[$code] $message';
}

/// Security related errors (Auth, Permissions, Encryption)
class SecurityException extends AppException {
  SecurityException({
    required String code,
    required super.message,
    super.details,
  }) : super(code: 'SEC-$code');
}

/// Network/API related errors
class NetworkException extends AppException {
  NetworkException({
    required String code,
    required super.message,
    super.details,
  }) : super(code: 'NET-$code');
}

/// Data Validation errors
class ValidationException extends AppException {
  ValidationException({
    required String code,
    required super.message,
    super.details,
  }) : super(code: 'DAT-$code');
}

/// System/Internal errors
class SystemException extends AppException {
  SystemException({required String code, required super.message, super.details})
    : super(code: 'SYS-$code');
}
