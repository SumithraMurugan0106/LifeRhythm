class UsageAppModel {
  final String appName;
  final String packageName;
  final int usageTimeMillis;

  UsageAppModel({
    required this.appName,
    required this.packageName,
    required this.usageTimeMillis,
  });

  factory UsageAppModel.fromMap(Map<dynamic, dynamic> map) {
    return UsageAppModel(
      appName: map["appName"] ?? "",
      packageName: map["packageName"] ?? "",
      usageTimeMillis: map["usageTimeMillis"] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "appName": appName,
      "packageName": packageName,
      "usageTimeMillis": usageTimeMillis,
    };
  }

  double get usageHours => usageTimeMillis / (1000 * 60 * 60);

  int get usageMinutes => usageTimeMillis ~/ (1000 * 60);

  String get formattedTime {
    final hours = usageMinutes ~/ 60;
    final minutes = usageMinutes % 60;

    if (hours > 0) {
      return "${hours}h ${minutes}m";
    }

    return "${minutes}m";
  }
}