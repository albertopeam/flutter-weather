import 'weather.dart';
import 'package:location/location.dart';

abstract class WeatherService {
  Future<Weather> get(double lat, double lon);
}

class WeatherUseCase {

  WeatherService _weatherService;
  Location _location;

  WeatherUseCase(this._location, this._weatherService);

  Future<Weather> get() async {    
    LocationData data = await _location.getLocation();
    return _weatherService.get(data.latitude, data.longitude);
  }

}