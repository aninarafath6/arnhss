abstract class NetworkException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  NetworkException([this.message, this.prefix, this.url]);
}

class AppException implements Exception {
  final String? message;
  final String? prefix;
  final bool? status;

  AppException([this.message, this.prefix, this.status]);
}

// app exception

class InvalidException extends AppException {
  InvalidException(String? message, bool? status)
      : super(message, "Invalid", status);
}

//network
class BadRequestException extends NetworkException {
  BadRequestException([String? message, String? url])
      : super(message, 'bad request', url);
}

class FetchDataException extends NetworkException {
  FetchDataException([String? message, String? url])
      : super(message, 'Unable to process', url);
}

class ApiNotRespondingException extends NetworkException {
  ApiNotRespondingException([String? message, String? url])
      : super(message, 'Api not responding', url);
}

class UnAuthorizedException extends NetworkException {
  UnAuthorizedException([String? message, String? url])
      : super(message, 'un authorized', url);
}
