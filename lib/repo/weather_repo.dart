import 'package:code_weather/api/weather_api.dart';
import 'package:code_weather/model/weather.dart';

class WeatherRepository {
  final WeatherApi weatherApi;
  WeatherRepository({required this.weatherApi});

  Future<Weather> getWeather(String cityName,
      {double? latitude, double? longitude}) async {
    cityName ??= await weatherApi.getCityNameFromLocation(
        latitude: latitude, longitude: longitude);
    var weather = await weatherApi.getWeatherData(cityName);
    var weathers = await weatherApi.getForecast(cityName);
    weather.forecast = weathers;
    return weather;
  }
}
