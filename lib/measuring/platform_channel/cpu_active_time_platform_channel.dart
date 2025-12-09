import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';

///
class CPUActiveTimePlatformChannel {
  static const MethodChannel CPUChannel = MethodChannel(
    'alina.simon.tuclausthal.com/cputime',
  );

 static Future<int> getCPUTime() async {
    try {
      final int? result = await CPUChannel.invokeMethod('getCPUTime');
      if (result != null) {
        return result;
      }
      return -1;
    } on PlatformException catch (e) {
      log("Failed to get cpu active time: ${e.code} - ${e.message}");
      return -1;
    }
  }
}


