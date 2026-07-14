class DailyHistoryModel {
  final String date;

  // Sleep
  final double sleepHours;
  final String bedtime;
  final String wakeupTime;

  // Productivity
  final double productiveHours;
  final int completedPomodoros;

  // Screen Time
  final double totalScreenHours;
  final double entertainmentHours;
  final double productiveScreenHours;

  // Health
  final int waterIntake;
  final int exerciseMinutes;

  // Scores
  final int lifeScore;
  final int sleepScore;
  final int focusScore;
  final int healthScore;

  // AI
  final String aiInsight;

  const DailyHistoryModel({
    required this.date,

    required this.sleepHours,
    required this.bedtime,
    required this.wakeupTime,

    required this.productiveHours,
    required this.completedPomodoros,

    required this.totalScreenHours,
    required this.entertainmentHours,
    required this.productiveScreenHours,

    required this.waterIntake,
    required this.exerciseMinutes,

    required this.lifeScore,
    required this.sleepScore,
    required this.focusScore,
    required this.healthScore,

    required this.aiInsight,
  });

  factory DailyHistoryModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return DailyHistoryModel(
      date: map["date"] ?? "",

      sleepHours: (map["sleepHours"] ?? 0).toDouble(),
      bedtime: map["bedtime"] ?? "",
      wakeupTime: map["wakeupTime"] ?? "",

      productiveHours:
      (map["productiveHours"] ?? 0).toDouble(),

      completedPomodoros:
      map["completedPomodoros"] ?? 0,

      totalScreenHours:
      (map["totalScreenHours"] ?? 0).toDouble(),

      entertainmentHours:
      (map["entertainmentHours"] ?? 0).toDouble(),

      productiveScreenHours:
      (map["productiveScreenHours"] ?? 0)
          .toDouble(),

      waterIntake: map["waterIntake"] ?? 0,

      exerciseMinutes:
      map["exerciseMinutes"] ?? 0,

      lifeScore: map["lifeScore"] ?? 0,

      sleepScore: map["sleepScore"] ?? 0,

      focusScore: map["focusScore"] ?? 0,

      healthScore: map["healthScore"] ?? 0,

      aiInsight: map["aiInsight"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "date": date,

      "sleepHours": sleepHours,
      "bedtime": bedtime,
      "wakeupTime": wakeupTime,

      "productiveHours": productiveHours,
      "completedPomodoros": completedPomodoros,

      "totalScreenHours": totalScreenHours,
      "entertainmentHours": entertainmentHours,
      "productiveScreenHours":
      productiveScreenHours,

      "waterIntake": waterIntake,
      "exerciseMinutes": exerciseMinutes,

      "lifeScore": lifeScore,
      "sleepScore": sleepScore,
      "focusScore": focusScore,
      "healthScore": healthScore,

      "aiInsight": aiInsight,
    };
  }

  DailyHistoryModel copyWith({
    String? date,

    double? sleepHours,
    String? bedtime,
    String? wakeupTime,

    double? productiveHours,
    int? completedPomodoros,

    double? totalScreenHours,
    double? entertainmentHours,
    double? productiveScreenHours,

    int? waterIntake,
    int? exerciseMinutes,

    int? lifeScore,
    int? sleepScore,
    int? focusScore,
    int? healthScore,

    String? aiInsight,
  }) {
    return DailyHistoryModel(
      date: date ?? this.date,

      sleepHours:
      sleepHours ?? this.sleepHours,

      bedtime:
      bedtime ?? this.bedtime,

      wakeupTime:
      wakeupTime ?? this.wakeupTime,

      productiveHours:
      productiveHours ??
          this.productiveHours,

      completedPomodoros:
      completedPomodoros ??
          this.completedPomodoros,

      totalScreenHours:
      totalScreenHours ??
          this.totalScreenHours,

      entertainmentHours:
      entertainmentHours ??
          this.entertainmentHours,

      productiveScreenHours:
      productiveScreenHours ??
          this.productiveScreenHours,

      waterIntake:
      waterIntake ??
          this.waterIntake,

      exerciseMinutes:
      exerciseMinutes ??
          this.exerciseMinutes,

      lifeScore:
      lifeScore ?? this.lifeScore,

      sleepScore:
      sleepScore ?? this.sleepScore,

      focusScore:
      focusScore ?? this.focusScore,

      healthScore:
      healthScore ??
          this.healthScore,

      aiInsight:
      aiInsight ?? this.aiInsight,
    );
  }
}