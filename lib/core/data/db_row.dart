/// Typed access to a single row returned by PostgREST.
///
/// Keeps casts, nested relation handling, and required-field errors at the
/// database boundary instead of spreading them through repositories/widgets.
class DbRow {
  DbRow(Object? value, {this.context = 'database row'})
    : _values = _asMap(value, context);

  final String context;
  final Map<String, dynamic> _values;
  Map<String, dynamic> get values => _values;

  static Map<String, dynamic> _asMap(Object? value, String context) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    throw FormatException('$context must be an object');
  }

  Object? operator [](String key) => _values[key];

  String requiredString(String key) {
    final value = _values[key];
    if (value is String && value.isNotEmpty) return value;
    throw FormatException('$context.$key must be a non-empty string');
  }

  String? optionalString(String key) {
    final value = _values[key];
    if (value == null) return null;
    if (value is String) return value;
    throw FormatException('$context.$key must be a string or null');
  }

  int requiredInt(String key) => _int(_values[key], '$context.$key');
  int intOr(String key, int fallback) =>
      _values[key] == null ? fallback : _int(_values[key], '$context.$key');

  double requiredDouble(String key) => _double(_values[key], '$context.$key');
  double doubleOr(String key, double fallback) =>
      _values[key] == null ? fallback : _double(_values[key], '$context.$key');
  double? optionalDouble(String key) =>
      _values[key] == null ? null : _double(_values[key], '$context.$key');
  int? optionalInt(String key) =>
      _values[key] == null ? null : _int(_values[key], '$context.$key');

  bool boolOr(String key, bool fallback) {
    final value = _values[key];
    if (value == null) return fallback;
    if (value is bool) return value;
    throw FormatException('$context.$key must be a boolean');
  }

  DateTime requiredDateTime(String key) =>
      _dateTime(_values[key], '$context.$key');
  DateTime? optionalDateTime(String key) {
    final value = _values[key];
    return value == null ? null : _dateTime(value, '$context.$key');
  }

  DbRow? optionalRow(String key) {
    final value = _values[key];
    return value == null ? null : DbRow(value, context: '$context.$key');
  }

  List<DbRow> rowsOrEmpty(String key) {
    final value = _values[key];
    if (value == null) return const [];
    if (value is! List) throw FormatException('$context.$key must be a list');
    return [
      for (var i = 0; i < value.length; i++)
        DbRow(value[i], context: '$context.$key[$i]'),
    ];
  }

  List<String> stringsOrEmpty(String key) {
    final value = _values[key];
    if (value == null) return const [];
    if (value is! List) throw FormatException('$context.$key must be a list');
    return [
      for (var i = 0; i < value.length; i++)
        if (value[i] is String)
          value[i] as String
        else
          throw FormatException('$context.$key[$i] must be a string'),
    ];
  }

  T enumValue<T extends Enum>(String key, Iterable<T> values, T fallback) {
    final raw = optionalString(key);
    for (final value in values) {
      if (value.name == raw) return value;
    }
    return fallback;
  }

  static int _int(Object? value, String path) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    throw FormatException('$path must be a number');
  }

  static double _double(Object? value, String path) {
    if (value is num) return value.toDouble();
    throw FormatException('$path must be a number');
  }

  static DateTime _dateTime(Object? value, String path) {
    if (value is DateTime) return value;
    if (value is String) {
      final parsed = DateTime.tryParse(value);
      if (parsed != null) return parsed;
    }
    throw FormatException('$path must be a valid date-time');
  }
}
