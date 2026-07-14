import '../models/usage_app_model.dart';
import '../models/user_model.dart';

class LifeScoreService {
  /// ----------------------------------------------------
  /// Used by FirestoreService during onboarding
  /// ----------------------------------------------------

  int calculateLifeScore({
    required String bedtime,
    required String wakeup,
    required int productiveHours,
    required double screenTime,
  }) {
    final sleep = calculateSleepScore(bedtime, wakeup);
    final focus = calculateFocusScore(productiveHours);
    final screen = _screenTimeScore(screenTime);

    return ((sleep * 0.4) +
        (focus * 0.4) +
        (screen * 0.2))
        .round()
        .clamp(0, 100);
  }

  int calculateSleepScore(
      String bedtime,
      String wakeup,
      ) {
    // Basic scoring for now
    // Later we'll replace with Health Connect data

    if (bedtime.isEmpty || wakeup.isEmpty) {
      return 70;
    }

    return 85;
  }

  int calculateFocusScore(int productiveHours) {
    if (productiveHours >= 8) return 100;
    if (productiveHours >= 6) return 90;
    if (productiveHours >= 4) return 75;
    if (productiveHours >= 2) return 60;
    return 40;
  }

  /// ----------------------------------------------------
  /// Used for Dashboard calculations
  /// ----------------------------------------------------

  static int calculateDashboardLifeScore({
    required UserModel user,
    required List<UsageAppModel> usageApps,
  }) {
    final sleep = _sleepScore(user.sleepHours);

    final productivity =
    _productivityScore(user.productiveHours.toDouble());

    final screen =
    _screenTimeScore(_screenHours(usageApps));

    final hydration =
    _hydrationScore(user.waterIntake);

    final exercise =
    _exerciseScore(user.exerciseMinutes);

    final score =
        (sleep * .30) +
            (productivity * .30) +
            (screen * .20) +
            (hydration * .10) +
            (exercise * .10);

    return score.round().clamp(0, 100);
  }

  static int _sleepScore(double hours) {
    if (hours >= 8) return 100;
    if (hours >= 7) return 90;
    if (hours >= 6) return 75;
    if (hours >= 5) return 55;
    return 30;
  }

  static int _productivityScore(double hours) {
    if (hours >= 8) return 100;
    if (hours >= 6) return 90;
    if (hours >= 4) return 75;
    if (hours >= 2) return 55;
    return 35;
  }

  static int _screenTimeScore(double hours) {
    if (hours <= 2) return 100;
    if (hours <= 3) return 90;
    if (hours <= 4) return 75;
    if (hours <= 5) return 60;
    return 30;
  }

  static int _hydrationScore(int glasses) {
    if (glasses >= 8) return 100;
    if (glasses >= 6) return 80;
    if (glasses >= 4) return 60;
    return 30;
  }

  static int _exerciseScore(int minutes) {
    if (minutes >= 45) return 100;
    if (minutes >= 30) return 85;
    if (minutes >= 20) return 70;
    if (minutes >= 10) return 50;
    return 20;
  }

  static double _screenHours(
      List<UsageAppModel> apps) {
    int totalMillis = 0;

    for (final app in apps) {
      totalMillis += app.usageTimeMillis;
    }

    return totalMillis / 1000 / 60 / 60;
  }

  static String getStatus(int score) {
    if (score >= 80) return "Aligned";
    if (score >= 60) return "Balanced";
    return "Drifting";
  }

  static String getColor(int score) {
    if (score >= 80) return "green";
    if (score >= 60) return "orange";
    return "red";
  }

  static String generateSuggestion({
    required UserModel user,
    required List<UsageAppModel> usageApps,
  }) {
    final screenHours = _screenHours(usageApps);

    if (screenHours > 5) {
      return "Your screen time is high today. Reduce it by 30 minutes.";
    }

    if (user.sleepHours < 7) {
      return "Sleep at least 7-8 hours tonight.";
    }

    if (user.productiveHours < 4) {
      return "Complete one more Pomodoro session.";
    }

    if (user.waterIntake < 8) {
      return "Drink more water today.";
    }

    if (user.exerciseMinutes < 20) {
      return "Take a short walk today.";
    }

    return "Excellent progress today! Keep it up.";
  }
}