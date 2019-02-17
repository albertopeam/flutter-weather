import 'package:flutter/material.dart';
import 'forecast_widget.dart';
import 'package:weatherapp/common/date_formatter.dart';
import 'package:weatherapp/weather/weather_result.dart';
import 'package:weatherapp/weather/weather_use_case.dart';

class WeatherPage extends StatefulWidget {

  final String title;
  final WeatherUseCase weatherUseCase;

  WeatherPage({Key key, this.title, this.weatherUseCase}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();

}

class _WeatherPageState extends State<WeatherPage> {

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Reload',
              onPressed: () {
                setState(() {
                  //TODO: 
                });    
              },
            )
        ]
      ),
      body: Center(
        child: FutureBuilder<WeatherResult>(
            future: widget.weatherUseCase.get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                WeatherResult weatherResult = snapshot.data;
                return _drawWeather(weatherResult);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
      )
    );
  }

  Container _drawWeather(WeatherResult weatherResult) {
    Row city = Row(mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Text(
                        weatherResult.weather.name,
                        style: TextStyle(
                          fontSize: 34,
                          color: Colors.black,
                        ),
                      ),
                    ]),
                  ],
                );
    Row date = Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(DateFormatter.date(weatherResult.weather.dateTime),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                    )),
              ],
            ),
          ],
        );
    Row temperature = Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(height: 40),                            
                            Text(weatherResult.weather.temperature.toString() + "°C",
                                style: TextStyle(
                                  fontSize: 72,
                                  color: Colors.black87,
                                ))
                          ],
                        ),
                      ],
                    );
    Row description = Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Hero(tag: 'hero', child: Image.asset('assets/${weatherResult.weather.icon}.png', scale: 0.7)),
                        SizedBox(width: 9),
                        Text(weatherResult.weather.description,
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.black87,
                            )),
                      ],
                    );                  
    double maxWindSpeed = 25.0; 
    final wind = LinearProgressIndicator(
      backgroundColor: Colors.white24,
      value: weatherResult.weather.windSpeed / maxWindSpeed,
    );
    double maxPressure = 1058.0;
    final pressurec = LinearProgressIndicator(
      backgroundColor: Colors.white24,
      value: weatherResult.weather.pressure / maxPressure,
    );
    final humidityc = LinearProgressIndicator(
      backgroundColor: Colors.white24,
      value: weatherResult.weather.humidity / 100.0,
    );
    Row other = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(height: 20),
            Row(children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text("Wind",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          )),
                      SizedBox(height: 12),
                      Text(weatherResult.weather.windSpeed.toString(),
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black87,
                          )),
                      SizedBox(height: 10),
                      Text("m/s",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          )),
                      SizedBox(height: 7),
                      SizedBox(
                        height: 2,
                        width: 80,
                        child: wind,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text("Pressure",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          )),
                      SizedBox(height: 12),
                      Text(weatherResult.weather.pressure.toString(),
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black87,
                          )),
                      SizedBox(height: 10),
                      Text("hPa",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          )),
                      SizedBox(height: 7),
                      SizedBox(
                        height: 2,
                        width: 80,
                        child: pressurec,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text("Humidity",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          )),
                      SizedBox(height: 12),
                      Text(weatherResult.weather.humidity.toString(),
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black87,
                          )),
                      SizedBox(height: 10),
                      Text("%",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          )),
                      SizedBox(height: 7),
                      SizedBox(
                        height: 2,
                        width: 80,
                        child: humidityc,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
    Container container = Container(
              margin: EdgeInsets.all(0),
              child: Padding(padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: <Widget>[
                    city,
                    date ,
                    temperature,
                    description,
                    other,
                    ForecastPage(forecast: weatherResult.forecast)
                ],
               ),
              ),
            );
    return container;
  }

}