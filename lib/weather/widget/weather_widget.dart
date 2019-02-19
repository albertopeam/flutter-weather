import 'package:flutter/material.dart';
import 'package:weatherapp/weather/weather.dart';
import 'package:weatherapp/common/date_formatter.dart';

class WeatherPage extends StatelessWidget {

  final Weather weather;

  WeatherPage(this.weather);

  @override
  Widget build(BuildContext context) {
    Row city = Row(mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Text(
                        weather.name,
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
                Text(DateFormatter.date(weather.dateTime),
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
                            Text(weather.temperature.toString() + "°C",
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
                        Hero(tag: 'hero', child: Image.asset('assets/${weather.icon}.png', scale: 0.7)),
                        SizedBox(width: 9),
                        Text(weather.description,
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.black87,
                            )),
                      ],
                    );                  
    double maxWindSpeed = 25.0; 
    final wind = LinearProgressIndicator(
      backgroundColor: Colors.white24,
      value: weather.windSpeed / maxWindSpeed,
    );
    double maxPressure = 1058.0;
    final pressurec = LinearProgressIndicator(
      backgroundColor: Colors.white24,
      value: weather.pressure / maxPressure,
    );
    final humidityc = LinearProgressIndicator(
      backgroundColor: Colors.white24,
      value: weather.humidity / 100.0,
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
                      Text(weather.windSpeed.toString(),
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
                      Text(weather.pressure.toString(),
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
                      Text(weather.humidity.toString(),
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
                    other
                ],
               ),
              ),
            );
    return container;
  }

}