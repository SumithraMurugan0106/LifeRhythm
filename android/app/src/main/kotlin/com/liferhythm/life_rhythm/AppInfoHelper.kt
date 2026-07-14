package com.liferhythm.life_rhythm
import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager

object AppInfoHelper {

    /**
     * Returns the readable application name.
     * Example:
     * com.instagram.android -> Instagram
     */
    fun getAppName(
        context: Context,
        packageName: String
    ): String {

        return try {

            val packageManager = context.packageManager

            val applicationInfo: ApplicationInfo =
                packageManager.getApplicationInfo(
                    packageName,
                    0
                )

            packageManager
                .getApplicationLabel(applicationInfo)
                .toString()

        } catch (e: PackageManager.NameNotFoundException) {

            packageName

        } catch (e: Exception) {

            packageName

        }
    }

    /**
     * Checks whether an app is installed.
     */
    fun isInstalled(
        context: Context,
        packageName: String
    ): Boolean {

        return try {

            context.packageManager.getPackageInfo(
                packageName,
                0
            )

            true

        } catch (e: Exception) {

            false

        }

    }

    /**
     * Returns all installed applications.
     */
    fun getInstalledApps(
        context: Context
    ): List<ApplicationInfo> {

        return context.packageManager
            .getInstalledApplications(0)

    }

    /**
     * Returns launcher app icon resource id.
     * (Flutter can't directly use this drawable,
     * but this can be useful later if you decide
     * to send icon data over the MethodChannel.)
     */
    fun getAppIconResId(
        context: Context,
        packageName: String
    ): Int {

        return try {

            val applicationInfo =
                context.packageManager.getApplicationInfo(
                    packageName,
                    0
                )

            applicationInfo.icon

        } catch (e: Exception) {

            android.R.drawable.sym_def_app_icon

        }

    }
}