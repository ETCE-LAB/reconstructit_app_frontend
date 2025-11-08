import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformChannel extends StatefulWidget {
  const PlatformChannel({super.key});

  @override
  State<PlatformChannel> createState() => _PlatformChannelState();
}

class _PlatformChannelState extends State<PlatformChannel> {
  static const MethodChannel methodChannel = MethodChannel(
    'alina.simon.tuclausthal.com/battery',
  );
  static const MethodChannel memoryChannel = MethodChannel(
    'alina.simon.tuclausthal.com/memory',
  );
  static const MethodChannel CPUChannel = MethodChannel(
    'alina.simon.tuclausthal.com/cputime',
  );

  String _batteryLevel = 'Battery level: unknown.';

  String _memoryLevel = 'Memory level: unknown.';

  String _cpuTime = 'CPU Time: unknown.';

  /// Liefert aktuellen RAM-Verbrauch (MB)
  Future<void> _getMemoryMB() async {
    final result = await memoryChannel.invokeMethod("getProcessMemoryMB");
    setState(() {
      _memoryLevel = "Verbauch:${(result as num).toDouble()} MB";
    });
  }

  /// Misst Speicherverbrauch einer Funktion [action]
  /// und gibt Start, Peak, End, Duration zurück.
  /*
  Future<Map<String, dynamic>> measure(
    Function action, {
    Duration pollInterval = const Duration(milliseconds: 200),
  }) async {
    final startMem = await _getMemoryMB();
    final startTime = DateTime.now();

    double peakMem = startMem;
    bool done = false;

    // Paralleles Polling starten
    final poller = () async {
      while (!done) {
        final current = await _getMemoryMB();
        if (current > peakMem) peakMem = current;
        await Future.delayed(pollInterval);
      }
    }();

    // Funktion ausführen
    await Future.microtask(() async => await action());

    done = true; // Poller stoppen
    final endMem = await _getMemoryMB();
    final endTime = DateTime.now();

    return {
      "start": startMem,
      "end": endMem,
      "peak": peakMem,
      "delta": endMem - startMem,
      "durationMs": endTime.difference(startTime).inMilliseconds,
    };
  }


   */
  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int? result = await methodChannel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level: $result%.';
    } on PlatformException catch (e) {
      if (e.code == 'NO_BATTERY') {
        batteryLevel = 'No battery.';
      } else {
        batteryLevel = 'Failed to get battery level.';
      }
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  Future<void> _getCPUTime() async {
    String cpuTime;
    try {
      final int? result = await CPUChannel.invokeMethod('getCPUTime');
      cpuTime = 'CPU Time: $result. ms';
    } on PlatformException catch (e) {
      if (e.code == 'NO_BATTERY') {
        cpuTime = 'No battery.';
      } else {
        cpuTime = 'Failed to get cpu time.';
      }
    }
    setState(() {
      _cpuTime = cpuTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_batteryLevel, key: const Key('Battery level label')),
              Text(_memoryLevel, key: const Key('Memory level label')),
              Text(_cpuTime, key: const Key('CPU time label')),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _getBatteryLevel();
                    _getMemoryMB();
                    _getCPUTime();
                  },
                  child: const Text('Refresh'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/*
void main() {
  runApp(const MaterialApp(home: PlatformChannel()));
}

 */
