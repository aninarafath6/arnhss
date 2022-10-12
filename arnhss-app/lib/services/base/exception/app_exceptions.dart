abstract class NetworkException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  NetworkException([this.message, this.prefix, this.url]);
}

abstract class AppException implements Exception {
  final String? message;
  final String? prefix;
  final bool? status;

  AppException([this.message, this.prefix, this.status]);
}

class InvalidException extends AppException {
  InvalidException(String? message, bool? status)
      : super(message, "Invalid", status);
}

class BadRequestException extends NetworkException {
  BadRequestException(String? message, String? url)
      : super(message, "Bad Request", url);
}

class ApiNotRespondingException extends NetworkException {
  ApiNotRespondingException(String? message, String? url)
      : super(message, "Api not responding", url);
}

class FetchDataException extends NetworkException {
  FetchDataException(String? message, String? url)
      : super(message, "unable to process", url);
}

class UnAuthorizedException extends NetworkException {
  UnAuthorizedException(String? message, String? url)
      : super(message, "un authorized exception", url);
}

class InternalServerException extends NetworkException {
  InternalServerException(String? message, String? url)
      : super(message, "internal server exception", url);
}
