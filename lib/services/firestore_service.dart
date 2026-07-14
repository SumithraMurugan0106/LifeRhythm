import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import 'life_score_service.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LifeScoreService _lifeScore = LifeScoreService();

  /// Current User ID
  String get uid => _auth.currentUser!.uid;

  /// -----------------------------
  /// Save Questionnaire
  /// -----------------------------
  Future<void> saveOnboarding({
    required String bedtime,
    required String wakeup,
    required double screenTime,
    required String careerGoal,
    required int productiveHours,
    required List<String> painPoints,
  }) async {
    final user = _auth.currentUser;

    if (user == null) return;

    // 1. Calculate scores BEFORE defining the map payload
    final int score = _lifeScore.calculateLifeScore(
      bedtime: bedtime,
      wakeup: wakeup,
      productiveHours: productiveHours,
      screenTime: screenTime,
    );

    final int sleepScore = _lifeScore.calculateSleepScore(bedtime, wakeup);
    final int focusScore = _lifeScore.calculateFocusScore(productiveHours);

    // 2. Write safely to Firestore
    await _firestore.collection("users").doc(user.uid).set({
      "profile": {
        "name": user.displayName ?? "",
        "email": user.email ?? "",
      },
      "onboarding": {
        "bedtime": bedtime,
        "wakeup": wakeup,
        "screenTime": screenTime,
        "careerGoal": careerGoal,
        "productiveHours": productiveHours,
        "painPoints": painPoints,
        "onboardingComplete": true,
      },
      "scores": {
        "lifeScore": score,
        "sleepScore": sleepScore,
        "focusScore": focusScore,
        "healthScore": 80, // Static baseline
      }
    }, SetOptions(merge: true));
  }

  /// -----------------------------
  /// Get User
  /// -----------------------------
  Future<UserModel?> getUser() async {
    final doc = await _firestore.collection("users").doc(uid).get();

    if (!doc.exists) {
      return null;
    }

    return UserModel.fromMap(
      doc.id,
      doc.data()!,
    );
  }

  /// -----------------------------
  /// Stream User
  /// -----------------------------
  Stream<UserModel?> userStream() {
    return _firestore
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;

      return UserModel.fromMap(
        doc.id,
        doc.data()!,
      );
    });
  }

  /// -----------------------------
  /// Update Life Score
  /// -----------------------------
  Future<void> updateLifeScore(int score) async {
    await _firestore.collection("users").doc(uid).update({
      "scores.lifeScore": score,
    });
  }

  /// -----------------------------
  /// Update Sleep Score
  /// -----------------------------
  Future<void> updateSleepScore(int score) async {
    await _firestore.collection("users").doc(uid).update({
      "scores.sleepScore": score,
    });
  }

  /// -----------------------------
  /// Update Focus Score
  /// -----------------------------
  Future<void> updateFocusScore(int score) async {
    await _firestore.collection("users").doc(uid).update({
      "scores.focusScore": score,
    });
  }

  /// -----------------------------
  /// Update Health Score
  /// -----------------------------
  Future<void> updateHealthScore(int score) async {
    await _firestore.collection("users").doc(uid).update({
      "scores.healthScore": score,
    });
  }

  /// -----------------------------
  /// Update Career Goal
  /// -----------------------------
  Future<void> updateCareerGoal(String goal) async {
    await _firestore.collection("users").doc(uid).update({
      "onboarding.careerGoal": goal,
    });
  }

  /// -----------------------------
  /// Update Productive Hours
  /// -----------------------------
  Future<void> updateProductiveHours(int hours) async {
    await _firestore.collection("users").doc(uid).update({
      "onboarding.productiveHours": hours,
    });
  }

  /// -----------------------------
  /// Update Screen Time
  /// -----------------------------
  Future<void> updateScreenTime(double hours) async {
    await _firestore.collection("users").doc(uid).update({
      "onboarding.screenTime": hours,
    });
  }

  /// -----------------------------
  /// Update Pain Points
  /// -----------------------------
  Future<void> updatePainPoints(List<String> painPoints) async {
    await _firestore.collection("users").doc(uid).update({
      "onboarding.painPoints": painPoints,
    });
  }

  /// -----------------------------
  /// Check Onboarding
  /// -----------------------------
  Future<bool> isOnboardingCompleted() async {
    final doc = await _firestore.collection("users").doc(uid).get();

    if (!doc.exists) return false;

    final data = doc.data();

    return data?["onboarding"]?["onboardingComplete"] ?? false;
  }

  /// -----------------------------
  /// Delete User Data
  /// -----------------------------
  Future<void> deleteUserData() async {
    await _firestore.collection("users").doc(uid).delete();
  }
  Future<void> saveAIInsight(String insight) async {
    await _firestore.collection("users").doc(uid).update({
      "todayAIInsight": insight,
    });
  }
  Future<String> getAIInsight() async {
    final doc =
    await _firestore.collection("users").doc(uid).get();

    if (!doc.exists) {
      return "";
    }

    return doc.data()?["todayAIInsight"] ?? "";
  }
  Future<void> updateProfile({

    required String name,
    required String careerGoal,
    required int productiveHours,
    required double screenTime,
    required String bedtime,
    required String wakeup,

  }) async {

    await _firestore
        .collection("users")
        .doc(uid)
        .update({

      "profile.name": name,

      "onboarding.careerGoal": careerGoal,

      "onboarding.productiveHours": productiveHours,

      "onboarding.screenTime": screenTime,

      "onboarding.bedtime": bedtime,

      "onboarding.wakeup": wakeup,

    });

  }
}