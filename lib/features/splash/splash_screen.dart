import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'background_circles.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_style.dart';
import '../../shared/animations/animated_logo.dart';
import '../../shared/animations/glowing_ring.dart';
import '../../shared/animations/heartbeat_widget.dart';
import '../welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        ),
      );

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,

            colors: [

              Color(0xffEDF9FF),

              Color(0xffDDF5FF),

              Color(0xffCDEEFF),

            ],

          ),

        ),

        child: Stack(

          children: [

            const BackgroundCircles(),

            Center(

              child: Column(

                mainAxisSize: MainAxisSize.min,

                children: [

                  Stack(

                    alignment: Alignment.center,

                    children: [

                      const GlowingRing(),

                      const AnimatedLogo(),

                    ],

                  ),

                  const SizedBox(height: 30),

                  const HeartBeatWidget(),

                  const SizedBox(height: 35),

                  Text(

                    AppConstants.appName,

                    style: AppTextStyle.heading,

                  )

                      .animate(delay: 2200.ms)

                      .fade(duration: 700.ms)

                      .slideY(begin: .5),

                  const SizedBox(height: 12),

                  Text(

                    AppConstants.tagline,

                    textAlign: TextAlign.center,

                    style: AppTextStyle.subtitle,

                  )

                      .animate(delay: 2600.ms)

                      .fade(duration: 700.ms),

                ],

              ),

            ),

          ],

        ),

      ),

    );

  }

}