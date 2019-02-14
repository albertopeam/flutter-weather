import 'package:flutter/material.dart';
import 'package:weatherapp/weather/forecast.dart';
import 'package:weatherapp/common/date_formatter.dart';

class ForecastPage extends StatefulWidget {
  
  final Forecast forecast;

  ForecastPage({this.forecast});

  @override
  _ForecastPageState createState() => _ForecastPageState();

}

class _ForecastPageState extends State<ForecastPage> {
  
  Container _prediction(Prediction prediction) {
    return Container(width: 110, child: 
      Column(children: <Widget>[
        Text(prediction.temperature.toString() + "°C", style: TextStyle(fontSize: 20, color: Colors.black87)),
        Hero(tag: 'prediction_icon', child: Image.asset('assets/${prediction.icon}.png', scale: 1)),
        Text(DateFormatter.dateTime(prediction.dateTime), style: TextStyle(fontSize: 11, color: Colors.black87))
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Forecast forecast = widget.forecast;
    List<Widget> items = forecast.predictions.map((prediction) => _prediction(prediction)).toList();
    return Container(
          margin: EdgeInsets.symmetric(vertical: 25.0),
          height: 110.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: items,
          ),
      );  
  }

}
