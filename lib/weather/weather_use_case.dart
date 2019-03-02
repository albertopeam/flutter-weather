import 'weather.dart';
import 'forecast.dart';
import 'weather_result.dart';
import 'package:location/location.dart';

abstract class WeatherService {
  Future<Weather> get(double lat, double lon);
}

abstract class ForecastService {
  Future<Forecast> get(double lat, double lon);
}

class WeatherUseCase {

  Location _location;
  WeatherService _weatherService;
  ForecastService _forecastService;

  WeatherUseCase(this._location, this._weatherService, this._forecastService);

  Future<WeatherResult> get() async {    
    LocationData data = await _location.getLocation();    
    Weather weather = await _weatherService.get(data.latitude, data.longitude);
    Forecast forecast = await _forecastService.get(data.latitude, data.longitude);
    return Future.value(WeatherResult(weather: weather, forecast: forecast));
  }

}