import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:wear_os_mobile_app_flutter/controller/daily_forecast.controller.dart';

import 'package:wear_os_mobile_app_flutter/theme/gradients/time.gradient.dart';
import 'package:wear_os_mobile_app_flutter/widgets/weather_forecast.dart';

class DailyMobileScreen extends StatelessWidget {

  const DailyMobileScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: TimeGradient(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: WeatherForecast()),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(DateFormat.yMMMd().format(DateTime.now()), style: TextStyle(color: Colors.white),),
              )
            ],
          ),

        )
      ),
    );
  }
}