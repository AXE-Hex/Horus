abstract class AppException implements Exception {
  final String code;
  final String message;
  final dynamic details;

  AppException({required this.code, required this.message, this.details});

  @override
  String toString() => '[$code] $message';
}

class SecurityException extends AppException {
  SecurityException({
    required String code,
    required super.message,
    super.details,
  }) : super(code: 'SEC-$code');
}

class NetworkException extends AppException {
  NetworkException({
    required String code,
    required super.message,
    super.details,
  }) : super(code: 'NET-$code');
}

class ValidationException extends AppException {
  ValidationException({
    required String code,
    required super.message,
    super.details,
  }) : super(code: 'DAT-$code');
}

class SystemException extends AppException {
  SystemException({required String code, required super.message, super.details})
    : super(code: 'SYS-$code');
}
