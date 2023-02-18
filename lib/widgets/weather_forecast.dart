import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherForecast extends StatelessWidget {

  const WeatherForecast({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.jm().format(now);           //5:08 PM

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(4),
          child: FractionallySizedBox(
            widthFactor: 0.6,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text('Hoy en AI Forecast', style: TextStyle(color: Colors.white),),
            )
          )),
        Padding(
          padding: const EdgeInsets.all(2),
          child: Text(formattedTime, style: const TextStyle(color: Colors.white)),
        ),
        const Padding(
          padding: EdgeInsets.all(4),
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text('Sin clima hoy', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
            ),
          ),
        )
      ],
    );
  }
}