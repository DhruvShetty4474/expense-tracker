class DatabaseException implements Exception {
  final String message;
  const DatabaseException(this.message);
  @override
  String toString() => 'DatabaseException: $message';
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
  @override
  String toString() => 'NetworkException: $message';
}

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);
  @override
  String toString() => 'AuthException: $message';
}

class AiException implements Exception {
  final String message;
  const AiException(this.message);
  @override
  String toString() => 'AiException: $message';
}

class SmsParseException implements Exception {
  final String message;
  const SmsParseException(this.message);
  @override
  String toString() => 'SmsParseException: $message';
}
