import 'package:code_weather/api/weather_api.dart';
import 'package:dio/src/response.dart';

class WeatherRepository {
  final WeatherApi weatherApi;
  WeatherRepository({required this.weatherApi});

  Future<Response> getWeather(String cityName,
      {double? latitude, double? longitude}) async {
    var weather = await weatherApi.getWeather();
    // var weathers = await weatherApi.getForecast(cityName);
    // weather.forecast = weathers;
    return weather;
  }
}
