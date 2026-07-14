import 'package:flutter/material.dart';

import '../models/usage_app_model.dart';
import '../services/usage_stats_service.dart';

class UsageProvider extends ChangeNotifier {
  final UsageStatsService _usageService = UsageStatsService();

  List<UsageAppModel> _apps = [];

  bool _isLoading = false;

  String? _error;

  List<UsageAppModel> get apps => _apps;

  bool get isLoading => _isLoading;

  String? get error => _error;

  /// Total screen time today in milliseconds
  int get totalUsageMillis {
    return _apps.fold(
      0,
          (sum, app) => sum + app.usageTimeMillis,
    );
  }

  /// Total screen time in hours
  double get totalUsageHours {
    return totalUsageMillis / 1000 / 60 / 60;
  }

  /// Most used application
  UsageAppModel? get mostUsedApp {
    if (_apps.isEmpty) return null;

    final sorted = List<UsageAppModel>.from(_apps)
      ..sort(
            (a, b) =>
            b.usageTimeMillis.compareTo(a.usageTimeMillis),
      );

    return sorted.first;
  }

  /// Entertainment apps
  List<UsageAppModel> get entertainmentApps {
    const entertainmentPackages = [

      "com.instagram.android",

      "com.google.android.youtube",

      "com.whatsapp",

      "com.facebook.katana",

      "com.twitter.android",

      "com.snapchat.android",

      "com.spotify.music",

      "com.netflix.mediaclient",

      "com.reddit.frontpage",

    ];

    return _apps.where((app) {
      return entertainmentPackages.contains(app.packageName);
    }).toList();
  }

  /// Productive apps
  List<UsageAppModel> get productiveApps {
    const productivePackages = [

      "com.microsoft.teams",

      "com.google.android.apps.docs",

      "com.google.android.apps.classroom",

      "com.linkedin.android",

      "com.microsoft.office.word",

      "com.microsoft.office.excel",

      "com.microsoft.office.powerpoint",

      "com.android.chrome",

      "com.jetbrains.intellij",

      "com.termux",

    ];

    return _apps.where((app) {
      return productivePackages.contains(app.packageName);
    }).toList();
  }

  int get entertainmentMillis {
    return entertainmentApps.fold(
      0,
          (sum, app) => sum + app.usageTimeMillis,
    );
  }

  int get productiveMillis {
    return productiveApps.fold(
      0,
          (sum, app) => sum + app.usageTimeMillis,
    );
  }

  double get entertainmentHours {
    return entertainmentMillis / 1000 / 60 / 60;
  }

  double get productiveHours {
    return productiveMillis / 1000 / 60 / 60;
  }

  /// Fetch today's usage
  Future<void> loadUsage() async {

    try {

      _isLoading = true;

      _error = null;

      notifyListeners();

      final permission =
      await _usageService.hasPermission();

      if (!permission) {

        await _usageService.openPermissionSettings();

        _isLoading = false;

        notifyListeners();

        return;

      }

      _apps = await _usageService.getUsageStats();

    } catch (e) {

      _error = e.toString();

    } finally {

      _isLoading = false;

      notifyListeners();

    }

  }

  /// Pull-to-refresh
  Future<void> refresh() async {
    await loadUsage();
  }

  /// Clear cached data
  void clear() {
    _apps.clear();
    _error = null;
    notifyListeners();
  }

  /// Format milliseconds into hh:mm
  String formatDuration(int millis) {

    final hours = millis ~/ 3600000;

    final minutes =
        (millis % 3600000) ~/ 60000;

    return "${hours}h ${minutes}m";

  }

  /// Top 5 apps
  List<UsageAppModel> get topApps {

    final sorted = List<UsageAppModel>.from(_apps)

      ..sort(
            (a, b) =>
            b.usageTimeMillis.compareTo(a.usageTimeMillis),
      );

    if (sorted.length <= 5) {
      return sorted;
    }

    return sorted.sublist(0, 5);

  }
}