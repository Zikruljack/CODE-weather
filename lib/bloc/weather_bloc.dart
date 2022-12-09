import 'package:bloc/bloc.dart';
import 'package:code_weather/api/error_exception.dart';
import 'package:code_weather/model/weather.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  // final WeatherRepository weatherRepository;

  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
  @override
  WeatherState get initialState {
    return WeatherEmpty();
  }

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        // final Weather weather = await weatherRepository.getWeather(
        //     event.cityName!,
        //     latitude: event.latitude,
        //     longitude: event.longitude);
        // yield WeatherLoaded(weather: weather);
      } catch (exception) {
        print(exception);
        if (exception is HTTPException) {
          yield WeatherError(errorCode: exception.code);
        } else {
          yield const WeatherError(errorCode: 500);
        }
      }
    }
  }
}
