import 'package:flutter/material.dart';

import '../models/daily_history_model.dart';
import '../services/history_service.dart';

class HistoryProvider extends ChangeNotifier {
  final HistoryService _historyService = HistoryService();

  DailyHistoryModel? _today;

  List<DailyHistoryModel> _last7Days = [];

  List<DailyHistoryModel> _last30Days = [];

  bool _loading = false;

  String? _error;

  double _averageLifeScore = 0;

  double _averageProductiveHours = 0;

  double _averageScreenTime = 0;

  int _weeklyImprovement = 0;

  DailyHistoryModel? get today => _today;

  List<DailyHistoryModel> get last7Days => _last7Days;

  List<DailyHistoryModel> get last30Days => _last30Days;

  bool get loading => _loading;

  String? get error => _error;

  double get averageLifeScore => _averageLifeScore;

  double get averageProductiveHours =>
      _averageProductiveHours;

  double get averageScreenTime =>
      _averageScreenTime;

  int get weeklyImprovement =>
      _weeklyImprovement;

  /// Load everything
  Future<void> loadHistory() async {
    try {
      _loading = true;

      _error = null;

      notifyListeners();

      _today =
      await _historyService.getTodayHistory();

      _last7Days =
      await _historyService.getLast7Days();

      _last30Days =
      await _historyService.getLast30Days();

      _averageLifeScore =
      await _historyService
          .getAverageLifeScore();

      _averageProductiveHours =
      await _historyService
          .getAverageProductiveHours();

      _averageScreenTime =
      await _historyService
          .getAverageScreenTime();

      _weeklyImprovement =
      await _historyService
          .getWeeklyImprovement();

    } catch (e) {

      _error = e.toString();

    } finally {

      _loading = false;

      notifyListeners();

    }
  }

  /// Refresh
  Future<void> refresh() async {
    await loadHistory();
  }

  /// Save today's history
  Future<void> saveToday(
      DailyHistoryModel history) async {

    await _historyService
        .saveTodayHistory(history);

    _today = history;

    await loadHistory();
  }
  Future<void> autoSaveToday(
      DailyHistoryModel history,
      ) async {

    await _historyService.autoSaveTodayHistory(
      history,
    );

    await loadHistory();
  }
  /// Update today's history
  Future<void> updateToday(
      Map<String, dynamic> data) async {

    await _historyService
        .updateTodayHistory(data);

    _today =
    await _historyService.getTodayHistory();

    notifyListeners();
  }

  /// Delete one day
  Future<void> deleteHistory(
      String date) async {

    await _historyService
        .deleteHistory(date);

    await loadHistory();
  }

  /// Delete all history
  Future<void> deleteAllHistory() async {

    await _historyService
        .deleteAllHistory();

    _today = null;

    _last7Days.clear();

    _last30Days.clear();

    notifyListeners();
  }

  /// Stream today's history
  void listenToday() {

    _historyService.todayStream().listen((history) {

      _today = history;

      notifyListeners();

    });

  }

  /// Current Life Score
  int get currentLifeScore {

    return _today?.lifeScore ?? 0;

  }

  /// Current Focus Score
  int get currentFocusScore {

    return _today?.focusScore ?? 0;

  }

  /// Current Sleep Score
  int get currentSleepScore {

    return _today?.sleepScore ?? 0;

  }

  /// Current Health Score
  int get currentHealthScore {

    return _today?.healthScore ?? 0;

  }

  /// Current Screen Time
  double get currentScreenHours {

    return _today?.totalScreenHours ?? 0;

  }

  /// Current Productive Hours
  double get currentProductiveHours {

    return _today?.productiveHours ?? 0;

  }

  /// Current Sleep Hours
  double get currentSleepHours {

    return _today?.sleepHours ?? 0;

  }

  /// Today's AI Insight
  String get aiInsight {

    return _today?.aiInsight ??
        "No AI insight available.";

  }

  /// Weekly Trend
  bool get improving {

    return _weeklyImprovement > 0;

  }

  /// Clear provider
  void clear() {

    _today = null;

    _last7Days.clear();

    _last30Days.clear();

    _averageLifeScore = 0;

    _averageProductiveHours = 0;

    _averageScreenTime = 0;

    _weeklyImprovement = 0;

    _error = null;

    notifyListeners();

  }
}