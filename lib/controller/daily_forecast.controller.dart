import 'package:flutter/material.dart';

import 'package:wear_os_mobile_app_flutter/openai/completions_api.dart';

import 'package:wear_os_mobile_app_flutter/screens/daily_forecast_route.dart';
import 'package:wear_os_mobile_app_flutter/screens/screens.dart';

class DailyForecastController extends State<DailyForecastRoute> {
  String? dailyForecast;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      print('host device screen width: ${constraints.maxWidth}');

      return FutureBuilder(
          future:
              CompletionsApi.getForecast(constraints.maxWidth < 300 ? 6 : 9),
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (!snapshot.hasData) {
              dailyForecast = snapshot.data;
              if (constraints.maxWidth < 300) {
                print('load watchScreen');
                return DailyWatchScreen(this);
              } else {
                print('load mobileScreen');
                return DailyMobileScreen();
              }
            } else {
              return const DailyMobileScreen();
            }
          });
    });
  }
}
