import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../providers/daily_plan_provider.dart';

class AIDailyPlanCard extends StatelessWidget {
  const AIDailyPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DailyPlanProvider>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(.85),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Row(
            children: [

              Icon(
                Icons.auto_awesome,
                color: Colors.white,
              ),

              SizedBox(width: 8),

              Text(
                "Today's AI Plan",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          if (provider.loading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          else
            Text(
              provider.plan.isEmpty
                  ? "Tap Generate Plan to receive today's personalized routine."
                  : provider.plan,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.6,
              ),
            ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.smart_toy),
              label: const Text("Generate Plan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
              ),
              onPressed: () {

                final userProvider = context.read<UserProvider>();

                final user = userProvider.user;

                if (user != null) {

                  context.read<DailyPlanProvider>().load(user);

                }

              },
            ),
          ),
        ],
      ),
    );
  }
}