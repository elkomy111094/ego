// 📁 lib/core/errors/failure.dart


import 'exceptions.dart';

/// Failures 
abstract class Failure {
  final String ? message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(String ? message) : super(message);
}

class ConnectivityFailure extends Failure {
  const ConnectivityFailure(String ? message) : super(message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(String ? message) : super(message);
}

class GeneralFailure extends Failure {
  String ? message;
  GeneralFailure(String ? message) : super(message);
}


/// Function To Convert An Exception To Failure 
Failure handleException(Exception exception) {
  if (exception is AppException) {
    if (exception is ServerException) {
      return ServerFailure(exception.message);
    } else if (exception is ConnectivityException) {
      return ConnectivityFailure(exception.message);
    } else if (exception is TimeoutException) {
      return ServerFailure(exception.message); // يمكن تعديله لو عايز نوع مخصص
    } else if (exception is UnauthorizedException) {
      return ServerFailure("Unauthorized"); // أو تعمل Failure خاص بالتفويض
    } else if (exception is FormatException) {
      return UnexpectedFailure(exception.message);
    } else if (exception is CacheException) {
      return GeneralFailure(exception.message);
    } else {
      return GeneralFailure(exception.message);
    }
  } else {
    return  GeneralFailure("Unhandled exception occurred.");
  }
}


