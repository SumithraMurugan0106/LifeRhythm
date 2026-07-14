package com.liferhythm.life_rhythm

import android.content.Intent
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "life_rhythm"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {

        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->

            when (call.method) {

                "hasPermission" -> {

                    result.success(
                        PermissionHelper.hasUsagePermission(this)
                    )

                }

                "openPermissionSettings" -> {

                    startActivity(
                        Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
                    )

                    result.success(true)

                }

                "getUsageStats" -> {

                    val list =
                        UsageStatsHelper.getUsageStats(this)

                    result.success(list)

                }

                else -> {

                    result.notImplemented()

                }

            }

        }

    }

}