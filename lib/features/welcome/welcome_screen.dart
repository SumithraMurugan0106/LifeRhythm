import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../auth/auth_choice_screen.dart';
import '../auth/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffEAF8FF),
              Colors.white,
            ],
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),

            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height - MediaQuery.of(context).padding.top,
              ),

              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

                child: IntrinsicHeight(
                  child: Column(
                    children: [

                      const SizedBox(height: 20),

                      Hero(
                        tag: "logo",
                        child: Container(
                          height: 150,
                          width: 150,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(.10),
                                blurRadius: 30,
                                spreadRadius: 8,
                              ),
                            ],
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(22),
                            child: Image.asset(
                              "assets/images/logo.png",
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 35),

                      Text(
                        "Welcome to",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.grey.shade700,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        "LifeRhythm",
                        style: GoogleFonts.poppins(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        "Your Personal Life Operating System",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "Sleep Better • Focus Smarter\nImprove Health • Achieve Goals",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade600,
                          height: 1.6,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 30),

                      _featureCard(
                        Icons.bedtime,
                        "Better Sleep",
                        "Track and improve your sleep quality.",
                      ),

                      const SizedBox(height: 12),

                      _featureCard(
                        Icons.psychology,
                        "Increase Focus",
                        "Reduce distractions and stay productive.",
                      ),

                      const SizedBox(height: 12),

                      _featureCard(
                        Icons.favorite,
                        "Healthy Lifestyle",
                        "Monitor habits and build consistency.",
                      ),

                      const SizedBox(height: 12),

                      _featureCard(
                        Icons.workspace_premium,
                        "Career Growth",
                        "Align your daily actions with your goals.",
                      ),

                      const Spacer(),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 60,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),

                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const AuthChoiceScreen(),
                              ),
                            );
                          },

                          child: Text(
                            "Get Started",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(
                            "Already have an account?",
                            style: GoogleFonts.poppins(),
                          ),

                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                  const LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Login",
                              style: GoogleFonts.poppins(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _featureCard(
      IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),

      child: Row(
        children: [

          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary.withOpacity(.15),

            child: Icon(
              icon,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}



























