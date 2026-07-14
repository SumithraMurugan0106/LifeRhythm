import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'providers/daily_plan_provider.dart';
import 'providers/user_provider.dart';
import 'providers/usage_provider.dart';
import 'providers/history_provider.dart';
import 'providers/gemini_provider.dart';
import 'providers/daily_plan_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DailyPlanProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UsageProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => HistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DailyPlanProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => GeminiProvider(),
        ),

      ],

      child: const LifeRhythmApp(),   // ✅ FIXED
    ),
  );
}