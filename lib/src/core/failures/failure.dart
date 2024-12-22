import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

part 'failure.mapper.dart';

///
/// Failure is an abstract class that represents a failure
/// it is used in the response of the dio client if the request fails
/// it contains the error message, the stack trace of the error and an identifier
/// the identifier is used to identify the error in the response of the dio client
/// the identifier should be a unique identifier for the error
/// the error message should be a string that describes the error
/// the stack trace should be a StackTrace object that represents the stack trace of the error
///
/// in short? just a class that represents a failure. not sure what else to put here
///
/// The fields of the Failure class are:
/// - [message]: the error message of the failure. it is a dynamic type because it can be a string or a Map or a List or even an object
/// - [stackTrace]: the stack trace of the error. it is a StackTrace object that represents the stack trace of the error
/// - [identifier]: the identifier of the error. it is a string that represents a unique identifier for the error
///
/// The Failure class can be used to represent a failure in the response of the dio client
/// it can also be used to wrap an error and provide more information about the error
/// it can also be used to identify the error using the identifier
///
///
@MappableClass()
class Failure with FailureMappable {
  final dynamic message;
  final StackTrace? stackTrace;
  final String? identifier;

  Failure([
    this.message,
    this.stackTrace,
    this.identifier,
  ]);

  Failure.presentation([
    this.message,
    this.stackTrace,
    this.identifier,
  ]);

  Failure.auth([
    this.message,
    this.stackTrace,
    this.identifier,
  ]);

  static Failure tryCatchData([
    dynamic message,
    StackTrace? stackTrace,
  ]) {
    return Failure(message, stackTrace);
  }

  static Failure tryCatchPresentation([
    dynamic message,
    StackTrace? stackTrace,
  ]) {
    return Failure(message, stackTrace);
  }

  static Failure tryCatchDomain([
    dynamic message,
    StackTrace? stackTrace,
  ]) {
    return Failure(message, stackTrace);
  }

  String get messageString {
    final error = message;
    var returnMessage = 'Something went wrong';

    if (error is ClientException) {
      final defaultMessage = 'Server Request has failed';
      final data = error.response;
      returnMessage = data['message'] ?? defaultMessage;
    }

    if (error is String) {
      returnMessage = error;
    }

    if (error is Failure) {
      returnMessage = error.message;
    }

    return returnMessage;
  }

  static const fromMap = FailureMapper.fromMap;
  static const fromJson = FailureMapper.fromJson;
}
