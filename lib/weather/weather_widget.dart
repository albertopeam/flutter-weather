import 'package:flutter/material.dart';
import 'package:weatherapp/weather/weather.dart';
import 'package:weatherapp/weather/weather_use_case.dart';

class WeatherPage extends StatefulWidget {

  final String title;
  final WeatherUseCase weatherUseCase;

  WeatherPage({Key key, this.title, this.weatherUseCase}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _WeatherPageState createState() => _WeatherPageState();

}

class _WeatherPageState extends State<WeatherPage> {

  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: FutureBuilder<Weather>(
            future: widget.weatherUseCase.get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Weather weather = snapshot.data;
                return Text(weather.name);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
      )
    );
  }
}