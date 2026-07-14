package com.liferhythm.life_rhythm

import android.app.usage.UsageStats
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.pm.PackageManager

object UsageStatsHelper {

    fun getUsageStats(context: Context): List<HashMap<String, Any>> {

        val usageStatsManager =
            context.getSystemService(Context.USAGE_STATS_SERVICE)
                    as UsageStatsManager

        val packageManager = context.packageManager

        val endTime = System.currentTimeMillis()

        val startTime = endTime - (24 * 60 * 60 * 1000)

        val stats: List<UsageStats> =
            usageStatsManager.queryUsageStats(

                UsageStatsManager.INTERVAL_DAILY,

                startTime,

                endTime

            )

        val appList = ArrayList<HashMap<String, Any>>()

        for (usage in stats) {

            if (usage.totalTimeInForeground <= 0)
                continue

            val appName = AppInfoHelper.getAppName(
                context,
                usage.packageName
            )

            val map = HashMap<String, Any>()

            map["appName"] = appName

            map["packageName"] = usage.packageName

            map["usageTimeMillis"] =
                usage.totalTimeInForeground

            appList.add(map)

        }

        appList.sortByDescending {

            it["usageTimeMillis"] as Long

        }

        return appList
    }

    private fun getAppName(

        packageManager: PackageManager,

        packageName: String

    ): String {

        return try {

            val applicationInfo =
                packageManager.getApplicationInfo(
                    packageName,
                    0
                )

            packageManager
                .getApplicationLabel(applicationInfo)
                .toString()

        } catch (e: Exception) {

            packageName

        }

    }

}