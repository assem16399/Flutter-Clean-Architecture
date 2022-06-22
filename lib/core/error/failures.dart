import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class NoInternetFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

//Failure for dio exceptions (i.e timeout, status codes errors)
class DioFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class UndefinedFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}
