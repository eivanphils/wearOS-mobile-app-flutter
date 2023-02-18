import 'package:flutter/material.dart';

import 'package:wear_os_mobile_app_flutter/controller/daily_forecast.controller.dart';

class DailyForecastRoute extends StatefulWidget {
  const DailyForecastRoute({ Key? key }) : super(key: key);

  @override
  State<DailyForecastRoute> createState() => DailyForecastController();
}