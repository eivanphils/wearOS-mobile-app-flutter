import 'package:flutter/material.dart';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wear_os_mobile_app_flutter/openai/api_key.dart';
import 'package:wear_os_mobile_app_flutter/openai/completions_request.dart';
import 'package:wear_os_mobile_app_flutter/openai/openai_models.dart';
import 'package:wear_os_mobile_app_flutter/openai/completions_response.dart';
import 'package:wear_os_mobile_app_flutter/openai/completion_prompts.dart';

class CompletionsApi {
  // The completions endpoint
  static final Uri completionsEndpoint =
      Uri.parse('https://api.openai.com/v1/completions');

  // The headers for the completions endpoint, which are the same for
  // all requests
  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $openAIApiKey',
  };

  // Get the shared_preferences key from the current date under which
  // today's forecast will be stored
  static final String key = DateFormat.yMMMd().format(DateTime.now());

  /// Returns a String with the AI-generated forecast either from
  /// shared_preferences or by getting a new one from the OpenAI API
  static Future<String?> getForecast(int maxTokens) async {
    //  First check if there is already a forecast saved for today
    // Obtain a shared_preferences instance.
    final prefs = await SharedPreferences.getInstance();

    String? storedForecast = prefs.getString(key);

    // We found a stored forecast
    if (storedForecast != null) {
      debugPrint('Retrieved a weather forecast from storage');

      return storedForecast.trim();
    }
    // We need a new forecast
    else {
      CompletionsResponse newForecast = await getNewForecast(maxTokens);
      return newForecast.firstCompletion?.trim();
    }
  }

  /// Gets a "weather forecast" from the OpenAI completions endpoint
  static Future<CompletionsResponse> getNewForecast(int maxTokens) async {
    debugPrint('Getting a new weather forecast');

    // Generate a random number for picking a random prompt
    Random rng = Random();
    int promptIndex = rng.nextInt(completionsPrompts.length);

    // Get a random temperature for this request between 0.6 and 0.8
    double temp = rng.nextInt(3) / 10 + 0.6;

    CompletionsRequest request = CompletionsRequest(
      model: OpenAIModel.model(OpenAIModels.textCurie001).identifier,
      prompt: completionsPrompts[promptIndex],
      maxTokens: maxTokens,
      temperature: temp,
    );

    debugPrint(
        'Sending OpenAI API request with prompt, "${completionsPrompts[promptIndex]}", and temperature, $temp.');

    http.Response response = await http.post(completionsEndpoint,
        headers: headers, body: request.toJson());

    debugPrint('Received OpenAI API response: ${response.body}');

    // Check to see if there was an error
    if (response.statusCode != 200) {
      // TODO handle errors
      debugPrint(
          'Failed to get a forecast with status code, ${response.statusCode}');
    }

    CompletionsResponse completionsResponse =
        CompletionsResponse.fromResponse(response);

    // Save the forecast
    saveForecast(completionsResponse);

    return completionsResponse;
  }

  /// Saves the "forecast" for the current day using shared_preferences.
  ///
  /// In order to enable a historical view of the forecasts and reduce the cost
  /// of making repeated calls to the OpenAI completions API, the forecast for
  /// each day will be saved using shared_preferences. The key under which each
  /// forecast is saved is the the current date, in a format like "Jul 2, 2022"
  /// as a String. The app will look up the forecast by this key and only call
  /// the OpenAI API if there is no forecast saved for the current day.
  static Future<void> saveForecast(CompletionsResponse response) async {
    // Obtain a shared_preferences instance.
    final prefs = await SharedPreferences.getInstance();

    debugPrint('Saving today\'s forecast under key, $key');

    await prefs.setString(key, response.firstCompletion ?? 'No hay datos del clima');
  }
}
