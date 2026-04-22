import 'package:flutter/foundation.dart';
import '../non_web_headless.dart'
    if (dart.library.js_interop) '../web_headless.dart';

class CrossPlatformHelperStub {
  static void init() {}

  static Future<bool> isSafe() async {
    if (!kReleaseMode) return false;

    if (isHeadlessWeb()) return false;

    return true;
  }
}
