import 'package:http/http.dart' show Client;
import 'package:weatherapp/weather/widget/current_weather_widget.dart';
import 'package:weatherapp/weather/current_weather_service.dart';
import 'package:weatherapp/weather/forecast_weather_service.dart';
import 'package:weatherapp/weather/weather_use_case.dart';
import 'package:location/location.dart';
import 'package:weatherapp/common/constants.dart';


class WeatherBuilder {
  
  CurrentWeatherPage build() {
    Location location = Location();
    Client client = Client();

    OpenWeatherCurrentService weatherService = OpenWeatherCurrentService(client, Constants.endpoint, Constants.appId);
    OpenWeatherForecastService forecastService = OpenWeatherForecastService(client, Constants.endpoint, Constants.appId);
    WeatherUseCase useCase = WeatherUseCase(location, weatherService, forecastService);
    
    return CurrentWeatherPage(weatherUseCase: useCase);
  }

}
