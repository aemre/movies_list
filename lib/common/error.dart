import 'package:equatable/equatable.dart';

abstract class Error extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Error {}
