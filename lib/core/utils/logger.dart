import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class LoggerHelper {
  static log(e, [s = '']) {
    if (kDebugMode == false) return;
    developer.log(e.toString());
    developer.log(s.toString());
  }
}
