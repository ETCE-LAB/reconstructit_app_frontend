package com.example.reconstructitapp

import android.app.ActivityManager
import android.content.Context
import android.os.BatteryManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val BATTERY_CHANNEL = "alina.simon.tuclausthal.com/battery";
    private val MEMORY_CHANNEL = "alina.simon.tuclausthal.com/memory";
    private val CPU_CHANNEL = "alina.simon.tuclausthal.com/cputime";


    @Override
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor, BATTERY_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method.equals("getBatteryLevel")) {
                val batteryLevel = getBatteryLevel()
                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
        MethodChannel(flutterEngine.dartExecutor, CPU_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method.equals("getCPUTime")) {
                val cpuTime = getCPUTime()
                if (cpuTime != -1L) {
                    result.success(cpuTime)
                } else {
                    result.error("UNAVAILABLE", "CPU time not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
        MethodChannel(flutterEngine.dartExecutor, MEMORY_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method.equals("getProcessMemoryMB")) {
                val memoryMB = getProcessMemoryMB()

                if (memoryMB != -1f) {
                    result.success(memoryMB)
                } else {
                    result.error("UNAVAILABLE", "Memory not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }


    }

    private fun getProcessMemoryMB(): Float {
        val activityManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        val pid = android.os.Process.myPid()
        val memoryInfo = activityManager.getProcessMemoryInfo(intArrayOf(pid))[0]
        return memoryInfo.totalPss / 1024f  // MB
    }

    private fun getBatteryLevel(): Int {
        val batteryManager: BatteryManager = getSystemService(BATTERY_SERVICE) as BatteryManager
        return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }

    private fun getCPUTime(): Long {
        return android.os.Process.getElapsedCpuTime()

    }

}