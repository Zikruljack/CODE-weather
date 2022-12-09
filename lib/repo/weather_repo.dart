import 'package:code_weather/api/weather_api.dart';

class WeatherRepository {
  final WeatherApi weatherApi;
  WeatherRepository({required this.weatherApi});

  // Future<Response> getWeather() async {
  //   // var weather = await weatherApi.getWeatherData(queryParameters: cityName);
  //   return weather;
  // }

  // Future<Weather> getWeather(String cityName,
  //     {double? latitude, double? longitude}) async {
  //   cityName ??= await weatherApi.getCityNameFromLocation(
  //       latitude: latitude, longitude: longitude);
  //   var weather = await weatherApi.getWeatherData(cityName);
  //   var weathers = await weatherApi.getForecast(cityName);
  //   weather.forecast = weathers;
  //   return weather;
  // }
}
