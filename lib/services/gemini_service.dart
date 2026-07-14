import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/config/api_keys.dart';
import '../models/user_model.dart';

class GeminiService {
  static const String _url =
      "https://openrouter.ai/api/v1/chat/completions";

  //-----------------------------------------
  // AI Coach Insight
  //-----------------------------------------

  Future<String> generateInsight({
    required String name,
    required double screenHours,
    required int productiveHours,
    required int lifeScore,
    required String careerGoal,
  }) async {
    final prompt = """
You are LifeRhythm AI.

User Details

Name: $name

Career Goal: $careerGoal

Life Score: $lifeScore

Today's Screen Time:
${screenHours.toStringAsFixed(1)} hours

Today's Productive Hours:
$productiveHours hours

Generate a friendly motivational insight.

Mention:
• Productivity
• Screen Time
• Life Balance
• One practical tip

Keep the answer below 120 words.
""";

    return _sendPrompt(prompt);
  }

  //-----------------------------------------
  // AI Chat
  //-----------------------------------------

  Future<String> askQuestion({
    required String question,
    required UserModel user,
  }) async {
    final prompt = """
You are LifeRhythm AI.

You are a productivity coach,
career mentor,
study planner,
and wellness advisor.

User Profile

Name: ${user.name}

Career Goal: ${user.careerGoal}

Life Score: ${user.lifeScore}

Sleep Score: ${user.sleepScore}

Focus Score: ${user.focusScore}

Health Score: ${user.healthScore}

Screen Time Goal:
${user.screenTime} hours

Productive Hours Goal:
${user.productiveHours} hours

User Question:

$question

Reply naturally.

Use bullet points whenever useful.

Keep the answer below 250 words.
""";

    return _sendPrompt(prompt);
  }

  //-----------------------------------------
  // AI Daily Plan
  //-----------------------------------------

  Future<String> generateDailyPlan({
    required UserModel user,
  }) async {
    final prompt = """
You are LifeRhythm AI.

Generate today's personalized productivity plan.

User Name:
${user.name}

Career Goal:
${user.careerGoal}

Life Score:
${user.lifeScore}

Sleep Score:
${user.sleepScore}

Focus Score:
${user.focusScore}

Health Score:
${user.healthScore}

Daily Productive Goal:
${user.productiveHours} hours

Screen Time Goal:
${user.screenTime} hours

Generate:

Morning Routine

Study Plan

Career Task

Exercise

Hydration

Screen Time Advice

Sleep Advice

Expected Life Score

Keep everything below 180 words.
""";

    return _sendPrompt(prompt);
  }

  //-----------------------------------------
  // Shared API Call
  //-----------------------------------------

  Future<String> _sendPrompt(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {
          "Authorization": "Bearer ${ApiKeys.openRouterApiKey}",
          "Content-Type": "application/json",
          "HTTP-Referer": "https://github.com/sumithra06/LifeRhythm",
          "X-Title": "LifeRhythm",
        },
        body: jsonEncode({
          "model": "openai/gpt-oss-20b:free",
          "messages": [
            {
              "role": "user",
              "content": prompt,
            }
          ],
          "temperature": 0.7,
          "max_tokens": 500,
        }),
      );

      print("================================");
      print("OpenRouter Status : ${response.statusCode}");
      print("OpenRouter Body : ${response.body}");
      print("================================");

      if (response.statusCode != 200) {
        print(response.body);
        return "AI Error ${response.statusCode}\n${response.body}";
      }

      final json = jsonDecode(response.body);

      if (json["choices"] == null || json["choices"].isEmpty) {
        return "No response generated.";
      }

      return json["choices"][0]["message"]["content"].toString().trim();
    } catch (e) {
      print("OpenRouter Exception: $e");
      return "Error: $e";
    }
  }
}