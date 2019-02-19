import 'package:flutter/material.dart';
import 'package:weatherapp/weather/forecast.dart';
import 'package:weatherapp/weather/weather.dart';
import 'package:weatherapp/common/date_formatter.dart';
import 'package:weatherapp/weather/widget/prediction_widget.dart';

class ForecastPage extends StatelessWidget {
  
  final Forecast forecast;

  ForecastPage({this.forecast});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = forecast.predictions.map((prediction) => _prediction(context, prediction)).toList();
    return Container(
          margin: EdgeInsets.symmetric(vertical: 25.0),
          height: 110.0,
          child: ListView(
             scrollDirection: Axis.horizontal,
             children: items,
           ),
      );
  }

    Widget _prediction(BuildContext context, Weather prediction) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PredictionPage(prediction: prediction)));
      },
      child: Container(width: 110, child: Column(children: <Widget>[
        Text(prediction.temperature.toString() + "°C", style: TextStyle(fontSize: 20, color: Colors.black87)),
        Image.asset('assets/${prediction.icon}.png', scale: 1),
        Text(DateFormatter.dateTime(prediction.dateTime), style: TextStyle(fontSize: 11, color: Colors.black87))
        ]
      )
    )
    );
  }

}
