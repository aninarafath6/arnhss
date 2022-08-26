class AppExceptions implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppExceptions([this.message, this.prefix, this.url]);
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message, String? url])
      : super(message, 'bad request', url);
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message, String? url])
      : super(message, 'Unable to process', url);
}

class ApiNotRespodingException extends AppExceptions {
  ApiNotRespodingException([String? message, String? url])
      : super(message, 'Api not responding', url);
}

class UnAuthorizedException extends AppExceptions {
  UnAuthorizedException([String? message, String? url])
      : super(message, 'un authorized', url);
}
