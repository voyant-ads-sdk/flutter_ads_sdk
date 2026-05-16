import 'dart:io';
import 'package:safe_device/safe_device.dart';
import 'package:flutter/foundation.dart';
import 'package:safe_device/safe_device_config.dart';

class CrossPlatformHelperStub {
  static void init() {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      SafeDevice.init(
        const SafeDeviceConfig(
          mockLocationCheckEnabled: false,
        ), // disables mock location check on Android
      );
    }
  }

  static Future<bool> isSafe() async {
    if (!kReleaseMode) return false;

    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      return true;
    }

    if (Platform.isAndroid) {
      final isJailBroken = await SafeDevice.isJailBroken;
      final isRealDevice = await SafeDevice.isRealDevice;
      final isSafeDevice = await SafeDevice.isSafeDevice;

      if (!isRealDevice || isJailBroken || !isSafeDevice) {
        return false;
      }
    }

    if (Platform.isIOS) {
      final isJailBroken = await SafeDevice.isJailBrokenCustom;
      final isRealDevice = await SafeDevice.isRealDevice;
      final isSafeDevice = await SafeDevice.isSafeDevice;

      if (!isRealDevice || isJailBroken || !isSafeDevice) {
        return false;
      }
    }

    return true;
  }
}
