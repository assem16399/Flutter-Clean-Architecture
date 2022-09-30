import 'package:equatable/equatable.dart';

import '../strings/failures_strings.dart';

abstract class Failure extends Equatable {
  String get failureMsg;
}

class NoInternetFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;

  @override
  // TODO: implement failureMsg
  String get failureMsg => kInternetFailureString;
}

//Failure for dio exceptions (i.e timeout, status codes errors)
class DioFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;

  @override
  // TODO: implement failureMsg
  String get failureMsg => kServerFailureString;
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;

  @override
  // TODO: implement failureMsg
  String get failureMsg => kCacheFailureString;
}

class UndefinedFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;

  @override
  // TODO: implement failureMsg
  String get failureMsg => kUndefinedFailureString;
}
