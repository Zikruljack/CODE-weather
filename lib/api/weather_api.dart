import 'package:dio/dio.dart';

class WeatherApi {
  static const String baseUrl = 'http://api.openweathermap.org';
  static const String apiPath = "/data/2.5/";
  late Dio dio;
  String? apiKey;

  Uri weather(String city) => _buildUri(
        endpoint: "weather",
        parametersBuilder: () => cityQueryParameters(city),
      );

  Uri forecast(String city) => _buildUri(
        endpoint: "forecast",
        parametersBuilder: () => cityQueryParameters(city),
      );

  Uri _buildUri({
    required String endpoint,
    required Map<String, dynamic> Function() parametersBuilder,
  }) {
    return Uri(
      scheme: "https",
      host: baseUrl,
      path: "$apiPath$endpoint",
      queryParameters: parametersBuilder(),
    );
  }

  Map<String, dynamic> cityQueryParameters(String city) => {
        "q": city,
        "appid": apiKey,
        "units": "metric",
      };
}
