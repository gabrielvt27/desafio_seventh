class AppException implements Exception {
  final String _message;
  final String _prefix;

  AppException(this._message, this._prefix);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException(String message)
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException(message) : super(message, "Invalid Request: ");
}

class UnauthorizedException extends AppException {
  UnauthorizedException(message) : super(message, "Unauthorized: ");
}

class NotFoundException extends AppException {
  NotFoundException(String message) : super(message, "Not Found: ");
}
