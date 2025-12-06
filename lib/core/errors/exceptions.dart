// ignore_for_file: avoid_init_to_null

class BaseException implements Exception {
  late String title;
  late String message;
  late int status;
  late String time;
  late dynamic details;

  BaseException(this.title, this.message,
      {this.status = 0, this.time = "", this.details = null});

  @override
  String toString() {
    return message;
  }
}

class ServerException extends BaseException {
  ServerException(String message)
      : super("Server Error", message,
            status: 500, time: DateTime.now().toString());
}

class CacheException extends BaseException {
  CacheException(String message)
      : super("Server Error", message,
            status: 0, time: DateTime.now().toString());
}

class NetworkException extends BaseException {
  NetworkException(String message)
      : super("Server Error", message,
            status: 0, time: DateTime.now().toString());
}

class NoInternetException extends BaseException {
  NoInternetException()
      : super("NoInternetException Occurred", "No Internet Found!",
            status: 0, time: DateTime.now().toString());
}

class BadRequestException extends BaseException {
  BadRequestException(String message, {int status = 400, String time = ""})
      : super("BadRequestException Occurred", message,
            status: 0, time: DateTime.now().toString());
}

class UnauthorizeException extends BaseException {
  UnauthorizeException(String message, {int status = 401, String time = ""})
      : super("UnauthorizeException Occurred", message,
            status: 0, time: time != "" ? time : DateTime.now().toString());
}

class ApiResponseException extends BaseException {
  ApiResponseException()
      : super("Server Error", "Response format error",
            status: 500, time: DateTime.now().toString());
}
