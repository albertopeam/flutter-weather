import 'package:http/http.dart' show Client;
import 'package:weatherapp/weather/weather_widget.dart';
import 'package:weatherapp/weather/open_weather_service.dart';
import 'package:weatherapp/weather/weather_use_case.dart';
import 'package:location/location.dart';

class WeatherBuilder {
  
  WeatherPage build() {
    String appId = "d6e481919bcce169184f16536bb64bd8";
    String endpoint = "http://api.openweathermap.org/data/2.5/";
    Client client = Client();
    OpenWeatherService service = OpenWeatherService(client, endpoint, appId);
    Location location = Location();
    WeatherUseCase useCase = WeatherUseCase(location, service);
    return WeatherPage(title: 'Weather', weatherUseCase: useCase);
  }

}
