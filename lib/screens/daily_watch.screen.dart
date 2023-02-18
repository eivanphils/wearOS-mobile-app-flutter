import 'package:flutter/material.dart';

import 'package:wear/wear.dart';

import 'package:wear_os_mobile_app_flutter/controller/daily_forecast.controller.dart';
import 'package:wear_os_mobile_app_flutter/screens/screens.dart';

class DailyWatchScreen extends StatelessWidget {
  final DailyForecastController state;

  const DailyWatchScreen(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(
          builder: ((context, mode, child) {
            return mode == WearMode.active
                ? DailyWatchActive(state)
                : DailyWatchAmbient(state);
          }),
        );
      },
    );
  }
}
