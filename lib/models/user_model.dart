class UserModel {
  final String uid;
  final String name;
  final String email;

  // Onboarding
  final String bedtime;
  final String wakeup;
  final double screenTime;
  final String careerGoal;
  final int productiveHours;
  final List<String> painPoints;
  final bool onboardingComplete;

  // Scores
  final int lifeScore;
  final int sleepScore;
  final int focusScore;
  final int healthScore;

  // Health
  final double sleepHours;
  final int waterIntake;
  final int exerciseMinutes;

  // Usage
  final double entertainmentHours;
  final double totalScreenHours;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.bedtime,
    required this.wakeup,
    required this.screenTime,
    required this.careerGoal,
    required this.productiveHours,
    required this.painPoints,
    required this.onboardingComplete,
    required this.lifeScore,
    required this.sleepScore,
    required this.focusScore,
    required this.healthScore,
    required this.sleepHours,
    required this.waterIntake,
    required this.exerciseMinutes,
    required this.entertainmentHours,
    required this.totalScreenHours,
  });

  factory UserModel.fromMap(
      String uid,
      Map<String, dynamic> map,
      ) {

    final profile =
        (map["profile"] as Map<String, dynamic>?) ?? {};

    final onboarding =
        (map["onboarding"] as Map<String, dynamic>?) ?? {};

    final scores =
        (map["scores"] as Map<String, dynamic>?) ?? {};

    final health =
        (map["health"] as Map<String, dynamic>?) ?? {};

    final usage =
        (map["usage"] as Map<String, dynamic>?) ?? {};

    return UserModel(
      uid: uid,

      name: profile["name"] ?? "",

      email: profile["email"] ?? "",

      bedtime: onboarding["bedtime"] ?? "",

      wakeup: onboarding["wakeup"] ?? "",

      screenTime:
      (onboarding["screenTime"] ?? 0).toDouble(),

      careerGoal:
      onboarding["careerGoal"] ?? "",

      productiveHours:
      onboarding["productiveHours"] ?? 0,

      painPoints:
      List<String>.from(
          onboarding["painPoints"] ?? []),

      onboardingComplete:
      onboarding["onboardingComplete"] ?? false,

      lifeScore:
      scores["lifeScore"] ?? 0,

      sleepScore:
      scores["sleepScore"] ?? 0,

      focusScore:
      scores["focusScore"] ?? 0,

      healthScore:
      scores["healthScore"] ?? 0,

      sleepHours:
      (health["sleepHours"] ?? 0).toDouble(),

      waterIntake:
      health["waterIntake"] ?? 0,

      exerciseMinutes:
      health["exerciseMinutes"] ?? 0,

      entertainmentHours:
      (usage["entertainmentHours"] ?? 0).toDouble(),

      totalScreenHours:
      (usage["totalScreenHours"] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {

      "profile": {
        "name": name,
        "email": email,
      },

      "onboarding": {
        "bedtime": bedtime,
        "wakeup": wakeup,
        "screenTime": screenTime,
        "careerGoal": careerGoal,
        "productiveHours": productiveHours,
        "painPoints": painPoints,
        "onboardingComplete": onboardingComplete,
      },

      "scores": {
        "lifeScore": lifeScore,
        "sleepScore": sleepScore,
        "focusScore": focusScore,
        "healthScore": healthScore,
      },

      "health": {
        "sleepHours": sleepHours,
        "waterIntake": waterIntake,
        "exerciseMinutes": exerciseMinutes,
      },

      "usage": {
        "entertainmentHours": entertainmentHours,
        "totalScreenHours": totalScreenHours,
      },

    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? bedtime,
    String? wakeup,
    double? screenTime,
    String? careerGoal,
    int? productiveHours,
    List<String>? painPoints,
    bool? onboardingComplete,
    int? lifeScore,
    int? sleepScore,
    int? focusScore,
    int? healthScore,
    double? sleepHours,
    int? waterIntake,
    int? exerciseMinutes,
    double? entertainmentHours,
    double? totalScreenHours,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      bedtime: bedtime ?? this.bedtime,
      wakeup: wakeup ?? this.wakeup,
      screenTime: screenTime ?? this.screenTime,
      careerGoal: careerGoal ?? this.careerGoal,
      productiveHours:
      productiveHours ?? this.productiveHours,
      painPoints:
      painPoints ?? this.painPoints,
      onboardingComplete:
      onboardingComplete ??
          this.onboardingComplete,
      lifeScore:
      lifeScore ?? this.lifeScore,
      sleepScore:
      sleepScore ?? this.sleepScore,
      focusScore:
      focusScore ?? this.focusScore,
      healthScore:
      healthScore ?? this.healthScore,
      sleepHours:
      sleepHours ?? this.sleepHours,
      waterIntake:
      waterIntake ?? this.waterIntake,
      exerciseMinutes:
      exerciseMinutes ??
          this.exerciseMinutes,
      entertainmentHours:
       entertainmentHours ??
          this.entertainmentHours,
      totalScreenHours:
      totalScreenHours ??
          this.totalScreenHours,
    );
  }
}