// THIS FILE CONTAINS ALL THE EXCEPTIONS {ERROS} to clearly understand the error .

class AppExceptions implements Exception {
  final _message;
  final _prefix;
  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

// Request Timeout
class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(message, 'Request Timeout With The Server');
}

// Wrong Url Hitted
class BadRequestException extends AppExceptions {
  BadRequestException([String? message])
      : super(message, 'Invalid Api Request');
}

// Unauthorized token error
class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String? message])
      : super(message, 'Unauthorized Request');
}

//Invalid Input error
class InvalidInputException extends AppExceptions {
  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}

class ServerException extends AppExceptions {
  ServerException([String? message]) : super(message, 'Internal Server Error');
}
