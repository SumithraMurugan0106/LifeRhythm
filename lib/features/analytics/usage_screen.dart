import 'package:flutter/material.dart';

import '../../models/usage_app_model.dart';
import '../../services/usage_stats_service.dart';

class UsageScreen extends StatefulWidget {
  const UsageScreen({super.key});

  @override
  State<UsageScreen> createState() =>
      _UsageScreenState();
}

class _UsageScreenState
    extends State<UsageScreen> {

  final UsageStatsService service =
  UsageStatsService();

  late Future<List<UsageAppModel>> apps;

  @override
  void initState() {
    super.initState();

    apps = service.getUsageStats();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Today's Usage"),
      ),

      body: FutureBuilder<List<UsageAppModel>>(

        future: apps,

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );

          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {

            return const Center(
              child: Text(
                "No usage data",
              ),
            );

          }

          final list = snapshot.data!;

          return ListView.builder(

            itemCount: list.length,

            itemBuilder: (_, index) {

              final app = list[index];

              return ListTile(

                leading: const CircleAvatar(
                  child: Icon(Icons.apps),
                ),

                title: Text(app.appName),

                subtitle:
                Text(app.packageName),

                trailing:
                Text(app.formattedTime),

              );

            },

          );

        },

      ),

    );

  }

}