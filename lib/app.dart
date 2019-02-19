import 'package:flutter/material.dart';
import 'package:weatherapp/weather/weather_builder.dart';

class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    
    return MaterialApp(
      title: 'Current weather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherBuilder().build()
    );
  }
}