import 'package:flutter/material.dart';
import 'package:weatherapp/weather/weather.dart';
import 'package:weatherapp/weather/widget/weather_widget.dart';

class PredictionPage extends StatefulWidget {

  final Weather prediction;

  PredictionPage({this.prediction});

  @override
  _PredictionPageState createState() => _PredictionPageState();
  
}

class _PredictionPageState extends State<PredictionPage> {

@override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        title: new Text("Prediction"),
      ),
      body: new Padding(
        padding: new EdgeInsets.all(16.0),
        child: WeatherPage(widget.prediction)
      )
    );
  }

}
