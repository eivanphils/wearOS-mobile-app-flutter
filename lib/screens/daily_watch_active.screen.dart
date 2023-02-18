import 'package:flutter/material.dart';

import 'package:wear_os_mobile_app_flutter/controller/daily_forecast.controller.dart';
import 'package:wear_os_mobile_app_flutter/theme/gradients/time.gradient.dart';
import 'package:wear_os_mobile_app_flutter/widgets/weather_forecast.dart';

class DailyWatchActive extends StatelessWidget {
  final DailyForecastController state;

  const DailyWatchActive(this.state, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: TimeGradient(
        child: Center(
          child: WeatherForecast()
        )  
      ),
    );  
  }
}