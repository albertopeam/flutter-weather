import 'package:weatherapp/weather/forecast.dart';
import 'package:weatherapp/weather/weather.dart';
import 'weather_builder.dart';

class ForecastBuilder {
  Forecast build() {
    Weather weather = WeatherBuilder().build();
    List<Weather> predictions = List();
    predictions.add(weather);
    return Forecast(name: "", predictions: predictions);
  }
}