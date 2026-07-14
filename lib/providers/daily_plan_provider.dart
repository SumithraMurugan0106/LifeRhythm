import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/gemini_service.dart';

class DailyPlanProvider extends ChangeNotifier {

  final GeminiService _gemini = GeminiService();

  bool loading = false;

  String plan = "";

  Future<void> load(UserModel user) async {

    loading = true;

    notifyListeners();

    plan = await _gemini.generateDailyPlan(
      user: user,
    );

    loading = false;

    notifyListeners();

  }

}