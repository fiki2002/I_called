import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  const Failures({
    this.message = "Something Went Wrong, Please Try Again",
    this.trace,
  });

  final String message;
  final StackTrace? trace;

  @override
  List<Object?> get props => [message, trace];
}
