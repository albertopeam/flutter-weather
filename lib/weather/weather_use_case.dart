import 'weather.dart';

abstract class WeatherService {
  Future<Weather> get();
}

class WeatherUseCase {

  WeatherService _weatherService;

  WeatherUseCase(this._weatherService);

  Future<Weather> get() async {    
    //TODO: location
    return _weatherService.get();
    //TODO: forecast
  }

}