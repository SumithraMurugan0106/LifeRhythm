import 'package:flutter/services.dart';

import '../models/usage_app_model.dart';

class UsageStatsService {
  static const MethodChannel _channel =
  MethodChannel('life_rhythm');

  /// Check whether Usage Access permission is granted
  Future<bool> hasPermission() async {
    try {
      final bool granted =
      await _channel.invokeMethod('hasPermission');

      return granted;
    } catch (_) {
      return false;
    }
  }

  /// Open Android Usage Access Settings
  Future<void> openPermissionSettings() async {
    try {
      await _channel.invokeMethod(
        'openPermissionSettings',
      );
    } catch (_) {}
  }

  /// Get app usage statistics
  Future<List<UsageAppModel>> getUsageStats() async {
    try {
      final List<dynamic> result =
      await _channel.invokeMethod(
        'getUsageStats',
      );

      return result
          .map(
            (e) => UsageAppModel.fromMap(
          Map<dynamic, dynamic>.from(e),
        ),
      )
          .toList();
    } catch (e) {
      print("Usage Stats Error: $e");
      return [];
    }
  }

  /// Total Screen Time
  Future<Duration> getTotalScreenTime() async {
    final apps = await getUsageStats();

    int total = 0;

    for (final app in apps) {
      total += app.usageTimeMillis;
    }

    return Duration(milliseconds: total);
  }

  /// Top Used Apps
  Future<List<UsageAppModel>> getTopApps({
    int limit = 5,
  }) async {
    final apps = await getUsageStats();

    apps.sort(
          (a, b) =>
          b.usageTimeMillis.compareTo(
            a.usageTimeMillis,
          ),
    );

    if (apps.length <= limit) {
      return apps;
    }

    return apps.take(limit).toList();
  }

  /// Get Usage for a Particular Package
  Future<UsageAppModel?> getAppUsage(
      String packageName,
      ) async {
    final apps = await getUsageStats();

    try {
      return apps.firstWhere(
            (app) =>
        app.packageName == packageName,
      );
    } catch (_) {
      return null;
    }
  }

  /// Entertainment Apps
  Future<List<UsageAppModel>> getEntertainmentApps() async {
    final apps = await getUsageStats();

    const entertainmentPackages = [
      "com.instagram.android",
      "com.google.android.youtube",
      "com.facebook.katana",
      "com.whatsapp",
      "com.twitter.android",
      "com.snapchat.android",
      "org.telegram.messenger",
      "com.zhiliaoapp.musically",
    ];

    return apps
        .where(
          (app) => entertainmentPackages.contains(
        app.packageName,
      ),
    )
        .toList();
  }

  /// Productivity Apps
  Future<List<UsageAppModel>> getProductivityApps() async {
    final apps = await getUsageStats();

    const productivityPackages = [
      "com.microsoft.vscode",
      "com.sololearn",
      "com.udemy.android",
      "com.linkedin.android",
      "com.google.android.apps.docs",
      "com.google.android.apps.classroom",
      "com.leetcode",
      "com.github.android",
    ];

    return apps
        .where(
          (app) => productivityPackages.contains(
        app.packageName,
      ),
    )
        .toList();
  }
}