import 'package:code_weather/api/logging_inteceptor.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

class WeatherApi {
  static const String baseUrl = 'http://api.openweathermap.org';
  static const String apiPath = "/data/2.5/";
  static const String apiKey = '4ac953db948d51270d50f49489030ae4';

  final Dio _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      validateStatus: (status) {
        return status! < 500;
      },
      headers: {
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Connection": "keep-alive",
      },
      connectTimeout: 60 * 1000,
      receiveTimeout: 60 * 1000))
    ..interceptors.add(LoggingInterceptor());

  Future<Response> requestData(String url,
      {dynamic body, String? method}) async {
    var res = _dio.request(url,
        data: body,
        options: Options(
          method: method,
        ));
    return res;
  }

  Future<Response> getWeather() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      double longitude = position.longitude;
      double latitude = position.latitude;
      Response response = await requestData(
          "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric",
          method: "Get");
      print("_++++++++++++++++++${response.statusCode}");
      return response;
    } on DioError catch (e) {
      throw handleError(e);
    }
  }
}

handleError(DioError error) {
  print(error.response.toString());
  if (error.message.contains('SocketException')) {
    return 'Cannot connect. Check that you have internet connection';
  }

  if (error.type == DioErrorType.connectTimeout) {
    return 'Connection timed out. Please retry.';
  }

  if (error.response == null || error.response!.data is String) {
    return 'Something went wrong. Please try again later';
  }
  return 'Something went wrong. Please try again later';
}
