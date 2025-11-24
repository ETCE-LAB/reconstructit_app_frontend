package com.example.reconstructitapp


import android.app.ActivityManager
import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log

class MainActivity : FlutterActivity() {
    private val CPU_CHANNEL = "alina.simon.tuclausthal.com/cputime"

    @Override
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val context = applicationContext
        val pid = android.os.Process.myPid()
        val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        val processName = activityManager.runningAppProcesses
                ?.firstOrNull { it.pid == pid }
                ?.processName

        Log.i("reconstruct", "Running in processAppppp: $processName (PID $pid)")
        MethodChannel(flutterEngine.dartExecutor, CPU_CHANNEL)
                .setMethodCallHandler { call, result ->
                    if (call.method.equals("getCPUTime")) {
                        val cpuTime = getCPUTime()
                        if (cpuTime != -1L) {
                            result.success(cpuTime)
                        } else {
                            result.error(
                                    "UNAVAILABLE",
                                    "CPU time not available.",
                                    null)
                        }
                    } else {
                        result.notImplemented()
                    }
                }
    }

    private fun getCPUTime(): Long {
        return android.os.Process.getElapsedCpuTime()
    }
}