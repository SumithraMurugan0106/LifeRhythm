import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../navigation/bottom_nav_screen.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final PageController _pageController = PageController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  int currentPage = 0;

  TimeOfDay bedtime = const TimeOfDay(hour: 22, minute: 30);
  TimeOfDay wakeup = const TimeOfDay(hour: 6, minute: 0);
  double screenTime = 3;
  String careerGoal = "App Development";
  int productivityHours = 4;
  List<String> painPoints = [];

  final List<String> careerOptions = [
    "App Development",
    "DSA / Coding",
    "AI / ML",
    "College Exams",
    "Upskilling",
    "Unwinding"
  ];

  final List<String> painOptions = [
    "Late-night scrolling",
    "Procrastination",
    "Constant fatigue",
    "Poor sleep",
    "Lack of direction"
  ];

  Future<void> nextPage() async {
    if (currentPage < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      await saveOnboarding();
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const BottomNavScreen(),
        ),
      );
    }
  }

  Future<void> pickBedtime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: bedtime,
    );
    if (picked != null) {
      setState(() => bedtime = picked);
    }
  }

  Future<void> pickWakeup() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: wakeup,
    );
    if (picked != null) {
      setState(() => wakeup = picked);
    }
  }

  String format(TimeOfDay t) {
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final minute = t.minute.toString().padLeft(2, '0');
    final ampm = t.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:$minute $ampm";
  }

  Future<void> saveOnboarding() async {
    try {
      final user = auth.currentUser;
      if (user == null) return;

      // Preserving the existing name entered during signup if it exists
      final existingDoc = await firestore.collection("users").doc(user.uid).get();
      final String profileName = existingDoc.data()?["profile"]?["name"] ?? user.displayName ?? "";

      // Basic baseline scores calculated from onboarding responses
      final int sleepScore = bedtime.hour <= 22 && wakeup.hour <= 7 ? 90 : 70;
      final int focusScore = (productivityHours * 10).clamp(0, 100);
      final int healthScore = 80;
      final int lifeScore = ((sleepScore + focusScore + healthScore) / 3).round();

      await firestore.collection("users").doc(user.uid).set({
        "profile": {
          "name": profileName,
          "email": user.email ?? "",
        },
        "onboarding": {
          "bedtime": format(bedtime),
          "wakeup": format(wakeup),
          "screenTime": screenTime,
          "careerGoal": careerGoal,
          "productiveHours": productivityHours,
          "painPoints": painPoints,
          "onboardingComplete": true,
        },
        "scores": {
          "lifeScore": lifeScore,
          "sleepScore": sleepScore,
          "focusScore": focusScore,
          "healthScore": healthScore,
        },
        "health": {
          "sleepHours": 8.0,
          "waterIntake": 0,
          "exerciseMinutes": 0,
        },
        "usage": {
          "totalScreenHours": screenTime,
          "entertainmentHours": screenTime,
        },
        "updatedAt": FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error saving data: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Let's Know You"),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (currentPage + 1) / 5,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Step ${currentPage + 1} of 5",
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              children: [
                /// QUESTION 1
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        "What is your target bedtime?",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: pickBedtime,
                        child: Text(format(bedtime)),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "What is your wake-up time?",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: pickWakeup,
                        child: Text(format(wakeup)),
                      ),
                    ],
                  ),
                ),

                /// QUESTION 2
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        "How many hours do you spend\non entertainment daily?",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 50),
                      Text(
                        "${screenTime.toStringAsFixed(1)} Hours",
                        style: const TextStyle(fontSize: 26),
                      ),
                      Slider(
                        value: screenTime,
                        min: 0,
                        max: 8,
                        divisions: 16,
                        label: screenTime.toString(),
                        onChanged: (v) {
                          setState(() {
                            screenTime = v;
                          });
                        },
                      )
                    ],
                  ),
                ),

                /// QUESTION 3
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "What is your current focus?",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 10,
                        children: careerOptions.map((e) {
                          return ChoiceChip(
                            label: Text(e),
                            selected: careerGoal == e,
                            onSelected: (_) {
                              setState(() {
                                careerGoal = e;
                              });
                            },
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),

                /// QUESTION 4
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        "How many productive hours\nper day?",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "$productivityHours Hours",
                        style: const TextStyle(fontSize: 28),
                      ),
                      Slider(
                        value: productivityHours.toDouble(),
                        min: 1,
                        max: 12,
                        divisions: 11,
                        onChanged: (v) {
                          setState(() {
                            productivityHours = v.toInt();
                          });
                        },
                      )
                    ],
                  ),
                ),

                /// QUESTION 5
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "What's your biggest roadblock?",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView(
                          children: painOptions.map((e) {
                            return CheckboxListTile(
                              title: Text(e),
                              value: painPoints.contains(e),
                              onChanged: (value) {
                                setState(() {
                                  if (value!) {
                                    painPoints.add(e);
                                  } else {
                                    painPoints.remove(e);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: nextPage,
                child: Text(
                  currentPage == 4 ? "Submit" : "Next",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// TEMPORARY SCREEN
/// Replace with your Permission Screen later
class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Permissions")),
      body: const Center(
        child: Text(
          "Permission Screen",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}