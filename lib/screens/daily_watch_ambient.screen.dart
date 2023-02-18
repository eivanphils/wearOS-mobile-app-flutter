import 'package:flutter/material.dart';

import 'package:wear_os_mobile_app_flutter/controller/daily_forecast.controller.dart';
import 'package:wear_os_mobile_app_flutter/widgets/weather_forecast.dart';

class DailyWatchAmbient extends StatelessWidget {
  final DailyForecastController state;

  const DailyWatchAmbient(this.state, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: WeatherForecast()),
    );
  }
}