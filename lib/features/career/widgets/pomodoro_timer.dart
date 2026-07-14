import 'dart:async';
import 'package:flutter/material.dart';

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  State<PomodoroTimer> createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {

  static const int workMinutes = 25;

  int remainingSeconds = workMinutes * 60;

  Timer? timer;

  bool isRunning = false;

  String formatTime() {

    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');

    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');

    return "$minutes:$seconds";

  }

  void startTimer() {

    if (isRunning) return;

    isRunning = true;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {

      if (remainingSeconds == 0) {

        timer.cancel();

        setState(() {

          isRunning = false;

        });

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Session Completed 🎉"),
            content: const Text(
                "Great Job!\nTake a 5 minute break."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          ),
        );

      } else {

        setState(() {

          remainingSeconds--;

        });

      }

    });

    setState(() {});
  }

  void pauseTimer() {

    timer?.cancel();

    setState(() {

      isRunning = false;

    });

  }

  void resetTimer() {

    timer?.cancel();

    setState(() {

      remainingSeconds = workMinutes * 60;

      isRunning = false;

    });

  }

  @override
  void dispose() {

    timer?.cancel();

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(25),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(22),

      ),

      child: Column(

        children: [

          const Icon(

            Icons.timer,

            color: Colors.red,

            size: 65,

          ),

          const SizedBox(height: 20),

          Text(

            formatTime(),

            style: const TextStyle(

              fontSize: 48,

              fontWeight: FontWeight.bold,

            ),

          ),

          const SizedBox(height: 25),

          Row(

            children: [

              Expanded(

                child: ElevatedButton.icon(

                  onPressed: startTimer,

                  icon: const Icon(Icons.play_arrow),

                  label: const Text("Start"),

                ),

              ),

              const SizedBox(width: 10),

              Expanded(

                child: ElevatedButton.icon(

                  onPressed: pauseTimer,

                  icon: const Icon(Icons.pause),

                  label: const Text("Pause"),

                ),

              ),

            ],

          ),

          const SizedBox(height: 12),

          SizedBox(

            width: double.infinity,

            child: OutlinedButton.icon(

              onPressed: resetTimer,

              icon: const Icon(Icons.restart_alt),

              label: const Text("Reset"),

            ),

          )

        ],

      ),

    );

  }

}