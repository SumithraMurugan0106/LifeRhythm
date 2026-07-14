import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/firestore_service.dart';

class UserProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  UserModel? _user;

  bool _loading = false;

  String? _error;

  UserModel? get user => _user;

  bool get isLoading => _loading;

  String? get error => _error;

  bool get hasUser => _user != null;

  Future<void> loadUser() async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      _user = await _firestoreService.getUser();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await loadUser();
  }
  Future<void> updateProfile({

    required String name,
    required String careerGoal,
    required int productiveHours,
    required double screenTime,
    required String bedtime,
    required String wakeup,

  }) async {

    await _firestoreService.updateProfile(

      name: name,

      careerGoal: careerGoal,

      productiveHours: productiveHours,

      screenTime: screenTime,

      bedtime: bedtime,

      wakeup: wakeup,

    );

    await loadUser();

  }
  void clear() {
    _user = null;
    _error = null;
    notifyListeners();
  }

  // Convenience getters

  String get name => _user?.name ?? "";

  String get email => _user?.email ?? "";

  String get bedtime => _user?.bedtime ?? "";

  String get wakeup => _user?.wakeup ?? "";

  double get screenTime => _user?.screenTime ?? 0;

  String get careerGoal => _user?.careerGoal ?? "";

  int get productiveHours => _user?.productiveHours ?? 0;

  List<String> get painPoints => _user?.painPoints ?? [];

  bool get onboardingComplete =>
      _user?.onboardingComplete ?? false;

  int get lifeScore => _user?.lifeScore ?? 0;

  int get sleepScore => _user?.sleepScore ?? 0;

  int get focusScore => _user?.focusScore ?? 0;

  int get healthScore => _user?.healthScore ?? 0;
}