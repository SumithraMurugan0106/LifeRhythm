import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_profile_screen.dart';
import '../../providers/user_provider.dart';
import '../../core/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/login_screen.dart'; // Change the path if needed
import 'package:firebase_auth/firebase_auth.dart';
class ProfileScreen extends StatelessWidget {
const ProfileScreen({super.key});

@override
Widget build(BuildContext context) {

final provider = context.watch<UserProvider>();
final user = provider.user;

if (user == null) {
return const Scaffold(
body: Center(
child: CircularProgressIndicator(),
),
);
}

return Scaffold(

backgroundColor: AppColors.background,

appBar: AppBar(
elevation: 0,
backgroundColor: Colors.transparent,
title: const Text(
"My Profile",
style: TextStyle(
color: Colors.black,
fontWeight: FontWeight.bold,
),
),
),

body: SingleChildScrollView(

padding: const EdgeInsets.all(20),

child: Column(

children: [

const SizedBox(height: 10),

CircleAvatar(
radius: 55,
backgroundColor: AppColors.primary,
child: Text(
user.name.isEmpty
? "U"
: user.name[0].toUpperCase(),
style: const TextStyle(
color: Colors.white,
fontSize: 34,
fontWeight: FontWeight.bold,
),
),
),

const SizedBox(height: 20),

Text(
user.name,
style: const TextStyle(
fontSize: 28,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 6),

Text(
user.email,
style: TextStyle(
color: Colors.grey.shade700,
fontSize: 16,
),
),

const SizedBox(height: 30),
  _ProfileTile(
    icon: Icons.workspace_premium,
    title: "Career Goal",
    value: user.careerGoal,
    color: Colors.blue,
  ),

  _ProfileTile(
    icon: Icons.bedtime,
    title: "Bed Time",
    value: user.bedtime,
    color: Colors.indigo,
  ),

  _ProfileTile(
    icon: Icons.wb_sunny,
    title: "Wake Up",
    value: user.wakeup,
    color: Colors.orange,
  ),

  _ProfileTile(
    icon: Icons.phone_android,
    title: "Screen Time Goal",
    value: "${user.screenTime.toStringAsFixed(1)} hrs",
    color: Colors.red,
  ),

  _ProfileTile(
    icon: Icons.psychology,
    title: "Productive Goal",
    value: "${user.productiveHours} hrs",
    color: Colors.green,
  ),

  const SizedBox(height: 30),

  const Align(
    alignment: Alignment.centerLeft,
    child: Text(
      "Performance",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  const SizedBox(height: 18),

  Row(
    children: [

      Expanded(
        child: _ScoreCard(
          title: "Life",
          score: user.lifeScore,
          color: Colors.blue,
        ),
      ),

      const SizedBox(width: 15),

      Expanded(
        child: _ScoreCard(
          title: "Sleep",
          score: user.sleepScore,
          color: Colors.indigo,
        ),
      ),

    ],
  ),

  const SizedBox(height: 15),

  Row(
    children: [

      Expanded(
        child: _ScoreCard(
          title: "Focus",
          score: user.focusScore,
          color: Colors.green,
        ),
      ),

      const SizedBox(width: 15),

      Expanded(
        child: _ScoreCard(
          title: "Health",
          score: user.healthScore,
          color: Colors.red,
        ),
      ),

    ],
  ),

  const SizedBox(height: 35),

  SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const EditProfileScreen(),
          ),
        );

      },
      icon: const Icon(Icons.edit),
      label: const Text("Edit Profile"),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding:
        const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(18),
        ),
      ),
    ),
  ),

  const SizedBox(height: 15),

  SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () async {

        await FirebaseAuth.instance.signOut();

        if (!context.mounted) return;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
              (route) => false,
        );

      },
      icon: const Icon(Icons.logout),
      label: const Text("Logout"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        padding:
        const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(18),
        ),
      ),
    ),
  ),

  const SizedBox(height: 30),

],
),
),
);
}
}
class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.08),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [

          CircleAvatar(
            backgroundColor: color.withOpacity(.15),
            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final String title;
  final int score;
  final Color color;

  const _ScoreCard({
    required this.title,
    required this.score,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.08),
            blurRadius: 8,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [

            Text(
              "$score",
              style: TextStyle(
                color: color,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

          ],
        ),
      ),
    );
  }
}