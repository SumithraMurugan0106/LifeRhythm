import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/splash/splash_screen.dart';

class LifeRhythmApp extends StatelessWidget {
  const LifeRhythmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeRhythm',

      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      home: const SplashScreen(),
    );
  }
}