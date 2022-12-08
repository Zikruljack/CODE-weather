part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final String? cityName;
  final String? longitude;
  final String? latitude;

  FetchWeather({this.cityName, this.longitude, this.latitude})
      : assert(cityName != null || longitude != null || latitude != null);

  @override
  List<Object?> get props => [cityName, longitude, latitude];
}
