import 'package:i_called/core/failures/failures.dart';

class BaseFailures extends Failures {
  const BaseFailures({required String message, StackTrace? trace})
      : super(message: message, trace: trace);
}

class SocketFailures extends Failures {
  const SocketFailures({required String message, StackTrace? trace})
      : super(message: message, trace: trace);
}
