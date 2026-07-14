import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../providers/usage_provider.dart';

import 'widgets/sleep_chart.dart';
import 'widgets/usage_chart.dart';
import 'widgets/usage_tile.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<UsageProvider>().loadUsage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final usageProvider = context.watch<UsageProvider>();

    if (usageProvider.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (usageProvider.error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Analytics Hub")),
        body: Center(
          child: Text(usageProvider.error!),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Analytics Hub",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: RefreshIndicator(
        onRefresh: usageProvider.refresh,

        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              /// HEADER
              Container(
                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(22),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Today's Insights",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Track your sleep quality, screen time, digital wellness and productivity trends.",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [

                        Expanded(
                          child: _infoCard(
                            "Screen Time",
                            usageProvider.formatDuration(
                              usageProvider.totalUsageMillis,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: _infoCard(
                            "Productive",
                            "${usageProvider.productiveHours.toStringAsFixed(1)} hrs",
                          ),
                        ),

                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [

                        Expanded(
                          child: _infoCard(
                            "Entertainment",
                            "${usageProvider.entertainmentHours.toStringAsFixed(1)} hrs",
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: _infoCard(
                            "Top App",
                            usageProvider.mostUsedApp?.appName ?? "-",
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Sleep Analysis",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              const SleepChart(),

              const SizedBox(height: 30),

              const Text(
                "Today's Screen Time",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              UsageChart(
                apps: usageProvider.topApps,
              ),

              const SizedBox(height: 30),

              const Text(
                "Top Used Apps",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              if (usageProvider.topApps.isEmpty)

                Container(
                  padding: const EdgeInsets.all(25),
                  alignment: Alignment.center,

                  child: const Text(
                    "No app usage data available.\nGrant Usage Access permission.",
                    textAlign: TextAlign.center,
                  ),
                )

              else

                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,

                  itemCount: usageProvider.topApps.length,

                  itemBuilder: (context, index) {

                    final app = usageProvider.topApps[index];

                    return UsageTile(
                      app: app,
                      maxUsage:
                      usageProvider.topApps.first.usageTimeMillis,
                    );
                  },
                ),

              const SizedBox(height: 30),

            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.18),
        borderRadius: BorderRadius.circular(15),
      ),

      child: Column(
        children: [

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),

        ],
      ),
    );
  }
}