import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
}

class SomethingWentWrong extends Failure {
  const SomethingWentWrong(super.message);

  String get getErrorMessage => message;

  @override
  List<Object?> get props => [message];
}

// Network Failure
class NetworkFailure extends Failure {
  const NetworkFailure(message) : super(message);
  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(message) : super(message);
  @override
  List<Object> get props => [message];
}
