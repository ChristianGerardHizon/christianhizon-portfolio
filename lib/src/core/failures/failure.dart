import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

part 'failure.mapper.dart';

@MappableClass(discriminatorKey: 'type')
sealed class Failure with FailureMappable {
  final dynamic message;
  final StackTrace? stackTrace;
  final String? identifier;

  const Failure(this.message, this.stackTrace, this.identifier);

  String get messageString {
    final error = message;
    var returnMessage = 'Something went wrong';

    if (error is ClientException) {
      print(error.toString());
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

  static Failure handle(Object error, StackTrace stackTrace) {
    if (error is Failure) {
      return error;
    }

    // if(error is PcketbaseException) {
    //   return PocketbaseFailure(error, stackTrace, 'pocketbase_error');
    // }

    // Handle known auth-related errors
    if (error is ClientException) {
      final code = error.statusCode;
      if (code == 401 || code == 403) {
        return AuthFailure(error, stackTrace, 'auth_error');
      }
    }

    // Handle user-cancelled errors (e.g., platform cancel actions)
    if (error.toString().contains('User cancelled')) {
      return CancelledFailure(error, stackTrace, 'user_cancelled');
    }

    // Handle presentation-related errors (UI layer)
    if (error is FormatException || error is StateError) {
      return PresentationFailure(error, stackTrace, 'presentation_error');
    }

    // Catch-all fallback
    return GenericFailure(error, stackTrace, 'generic_error');
  }
}

@MappableClass()
class PocketbaseFailure extends Failure with PocketbaseFailureMappable {
  const PocketbaseFailure([
    dynamic message,
    StackTrace? stackTrace,
    String? identifier,
  ]) : super(message, stackTrace, identifier);
}

@MappableClass()
class AuthFailure extends Failure with AuthFailureMappable {
  const AuthFailure([
    dynamic message,
    StackTrace? stackTrace,
    String? identifier,
  ]) : super(message, stackTrace, identifier);
}

@MappableClass()
class PresentationFailure extends Failure with PresentationFailureMappable {
  const PresentationFailure([
    dynamic message,
    StackTrace? stackTrace,
    String? identifier,
  ]) : super(message, stackTrace, identifier);
}

@MappableClass()
class DataFailure extends Failure with DataFailureMappable {
  const DataFailure([
    dynamic message,
    StackTrace? stackTrace,
    String? identifier,
  ]) : super(message, stackTrace, identifier);
}

@MappableClass()
class CancelledFailure extends Failure with CancelledFailureMappable {
  const CancelledFailure([
    dynamic message,
    StackTrace? stackTrace,
    String? identifier,
  ]) : super(message, stackTrace, identifier);
}

@MappableClass()
class NoAuthFailure extends Failure with NoAuthFailureMappable {
  const NoAuthFailure([
    dynamic message,
    StackTrace? stackTrace,
    String? identifier,
  ]) : super(message, stackTrace, identifier);
}

@MappableClass()
class GenericFailure extends Failure with GenericFailureMappable {
  const GenericFailure([
    dynamic message,
    StackTrace? stackTrace,
    String? identifier,
  ]) : super(message, stackTrace, identifier);
}
