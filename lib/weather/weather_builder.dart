import 'package:http/http.dart' show Client;
import 'package:weatherapp/weather/widget/current_weather_widget.dart';
import 'package:weatherapp/weather/current_weather_service.dart';
import 'package:weatherapp/weather/forecast_weather_service.dart';
import 'package:weatherapp/weather/weather_use_case.dart';
import 'package:location/location.dart';


class WeatherBuilder {
  
  CurrentWeatherPage build() {
    Location location = Location();

    String appId = "d6e481919bcce169184f16536bb64bd8";
    String endpoint = "http://api.openweathermap.org/data/2.5/";
    Client client = Client();

    OpenWeatherCurrentService weatherService = OpenWeatherCurrentService(client, endpoint, appId);
    OpenWeatherForecastService forecastService = OpenWeatherForecastService(client, endpoint, appId);
    WeatherUseCase useCase = WeatherUseCase(location, weatherService, forecastService);
    
    return CurrentWeatherPage(weatherUseCase: useCase);
  }

}
