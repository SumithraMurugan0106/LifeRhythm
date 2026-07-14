import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/daily_history_model.dart';

class HistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  String get todayId {
    final now = DateTime.now();

    return "${now.year}-"
        "${now.month.toString().padLeft(2, '0')}-"
        "${now.day.toString().padLeft(2, '0')}";
  }

  ///-------------------------------------------------------
  /// SAVE TODAY
  ///-------------------------------------------------------

  Future<void> saveTodayHistory(
      DailyHistoryModel history,
      ) async {
    await _firestore
        .collection("users")
        .doc(_uid)
        .collection("history")
        .doc(history.date)
        .set(
      history.toMap(),
      SetOptions(merge: true),
    );
  }

  ///-------------------------------------------------------
  /// AUTO SAVE TODAY (called by HistoryProvider)
  ///-------------------------------------------------------

  Future<void> autoSaveTodayHistory(
      DailyHistoryModel history,
      ) async {
    final exists = await todayExists();

    if (exists) return;

    await saveTodayHistory(history);
  }

  ///-------------------------------------------------------
  /// TODAY EXISTS
  ///-------------------------------------------------------

  Future<bool> todayExists() async {
    final doc = await _firestore
        .collection("users")
        .doc(_uid)
        .collection("history")
        .doc(todayId)
        .get();

    return doc.exists;
  }

  ///-------------------------------------------------------
  /// UPDATE TODAY
  ///-------------------------------------------------------

  Future<void> updateTodayHistory(
      Map<String, dynamic> data,
      ) async {
    await _firestore
        .collection("users")
        .doc(_uid)
        .collection("history")
        .doc(todayId)
        .set(
      data,
      SetOptions(merge: true),
    );
  }

  ///-------------------------------------------------------
  /// GET TODAY
  ///-------------------------------------------------------

  Future<DailyHistoryModel?> getTodayHistory() async {
    final doc = await _firestore
        .collection("users")
        .doc(_uid)
        .collection("history")
        .doc(todayId)
        .get();

    if (!doc.exists) {
      return null;
    }

    return DailyHistoryModel.fromMap(doc.data()!);
  }

  ///-------------------------------------------------------
  /// GET HISTORY BY DATE
  ///-------------------------------------------------------

  Future<DailyHistoryModel?> getHistoryByDate(
      String date,
      ) async {
    final doc = await _firestore
        .collection("users")
        .doc(_uid)
        .collection("history")
        .doc(date)
        .get();

    if (!doc.exists) {
      return null;
    }

    return DailyHistoryModel.fromMap(doc.data()!);
  }

  ///-------------------------------------------------------
  /// LAST 7 DAYS
  ///-------------------------------------------------------

  Future<List<DailyHistoryModel>> getLast7Days() async {
    final snapshot = await _firestore
        .collection("users")
        .doc(_uid)
        .collection("history")
        .orderBy("date", descending: true)
        .limit(7)
        .get();

    return snapshot.docs
        .map((e) => DailyHistoryModel.fromMap(e.data()))
        .toList();
  }

  ///-------------------------------------------------------
  /// LAST 30 DAYS
  ///-------------------------------------------------------

  Future<List<DailyHistoryModel>> getLast30Days() async {
    final snapshot = await _firestore
        .collection("users")
        .doc(_uid)
        .collection("history")
        .orderBy("date", descending: true)
        .limit(30)
        .get();

    return snapshot.docs
        .map((e) => DailyHistoryModel.fromMap(e.data()))
        .toList();
  }

  ///-------------------------------------------------------
  /// STREAM TODAY
  ///-------------------------------------------------------

  Stream<DailyHistoryModel?> todayStream() {
    return _firestore
        .collection("users")
        .doc(_uid)
        .collection("history")
        .doc(todayId)
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;

      return DailyHistoryModel.fromMap(doc.data()!);
    });
  }

  ///-------------------------------------------------------
  /// DELETE ONE
  ///-------------------------------------------------------

  Future<void> deleteHistory(String date) async {
    await _firestore
        .collection("users")
        .doc(_uid)
        .collection("history")
        .doc(date)
        .delete();
  }

  ///-------------------------------------------------------
  /// DELETE ALL
  ///-------------------------------------------------------

  Future<void> deleteAllHistory() async {
    final snapshot = await _firestore
        .collection("users")
        .doc(_uid)
        .collection("history")
        .get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  ///-------------------------------------------------------
  /// AVERAGES
  ///-------------------------------------------------------

  Future<double> getAverageLifeScore() async {
    final list = await getLast30Days();

    if (list.isEmpty) return 0;

    final total =
    list.fold<int>(0, (sum, e) => sum + e.lifeScore);

    return total / list.length;
  }

  Future<double> getAverageProductiveHours() async {
    final list = await getLast30Days();

    if (list.isEmpty) return 0;

    final total = list.fold<double>(
      0,
          (sum, e) => sum + e.productiveHours,
    );

    return total / list.length;
  }

  Future<double> getAverageScreenTime() async {
    final list = await getLast30Days();

    if (list.isEmpty) return 0;

    final total = list.fold<double>(
      0,
          (sum, e) => sum + e.totalScreenHours,
    );

    return total / list.length;
  }

  ///-------------------------------------------------------
  /// WEEKLY IMPROVEMENT
  ///-------------------------------------------------------

  Future<int> getWeeklyImprovement() async {
    final history = await getLast7Days();

    if (history.length < 2) return 0;

    return history.first.lifeScore -
        history.last.lifeScore;
  }
}