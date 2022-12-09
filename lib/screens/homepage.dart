import 'package:code_weather/bloc/weather_bloc.dart';
import 'package:code_weather/screens/widgets/weather.dart';
import 'package:code_weather/utils/app_state_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

enum OptionsMenu { changeCity, settings }

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late WeatherBloc _weatherBloc;
  String cityName = 'jakarta barat';
  late Animation<double> _fadeAnimation;
  late AnimationController _fadeAnimationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    _fetchWeatherWithLocation().catchError((error) {
      _fetchWeatherWithCity();
    });

    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeAnimationController,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: appTheme.primaryColor,
          elevation: 0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
                style: TextStyle(
                  color: appTheme.colorScheme.secondary.withAlpha(80),
                  fontSize: 14,
                ),
              )
            ],
          ),
          actions: <Widget>[
            PopupMenuButton<OptionsMenu>(
                onSelected: _onOptionMenuItemSelected,
                itemBuilder: (context) => <PopupMenuEntry<OptionsMenu>>[
                      const PopupMenuItem<OptionsMenu>(
                        value: OptionsMenu.changeCity,
                        child: Text("change city"),
                      ),
                      const PopupMenuItem<OptionsMenu>(
                        value: OptionsMenu.settings,
                        child: Text("settings"),
                      ),
                    ],
                child: Icon(
                  Icons.more_vert,
                  color: appTheme.colorScheme.secondary,
                ))
          ],
        ),
        backgroundColor: Colors.white,
        body: Material(
          child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(color: appTheme.primaryColor),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (_, WeatherState weatherState) {
                _fadeAnimationController.reset();
                _fadeAnimationController.forward();

                if (weatherState is WeatherLoaded) {
                  cityName = weatherState.weather.cityName!;
                  //TODO screens should add here
                  return WeatherWidget(weather: weatherState.weather);
                } else if (weatherState is WeatherError ||
                    weatherState is WeatherEmpty) {
                  String errorText = 'There was an error fetching weather data';
                  if (weatherState is WeatherError) {
                    if (weatherState.errorCode == 404) {
                      errorText =
                          'We have trouble fetching weather for $cityName';
                    }
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.error_outline,
                        color: Colors.redAccent,
                        size: 24,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        errorText,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: appTheme.colorScheme.secondary,
                          elevation: 1,
                        ),
                        onPressed: _fetchWeatherWithCity,
                        child: const Text("Try Again"),
                      )
                    ],
                  );
                } else if (weatherState is WeatherLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: appTheme.primaryColor,
                    ),
                  );
                }
                return Container(
                  child: const Text('No city set'),
                );
              }),
            ),
          ),
        ));
  }

  void _showCityChangeDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          ThemeData appTheme = AppStateContainer.of(context).theme;

          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Change city',
                style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: appTheme.colorScheme.secondary,
                  elevation: 1,
                ),
                onPressed: () {
                  _fetchWeatherWithCity();
                  Navigator.of(context).pop();
                },
                child: const Text('ok'),
              ),
            ],
            content: TextField(
              autofocus: true,
              onChanged: (text) {
                cityName = text;
              },
              decoration: InputDecoration(
                  hintText: 'Name of your city',
                  hintStyle: const TextStyle(color: Colors.black),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _fetchWeatherWithLocation().catchError((error) {
                        _fetchWeatherWithCity();
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.black,
                      size: 16,
                    ),
                  )),
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.black,
            ),
          );
        });
  }

  _onOptionMenuItemSelected(OptionsMenu item) {
    switch (item) {
      case OptionsMenu.changeCity:
        _showCityChangeDialog();
        break;
      case OptionsMenu.settings:
        Navigator.of(context).pushNamed("/settings");
        break;
    }
  }

  _fetchWeatherWithCity() {
    _weatherBloc.add(FetchWeather(cityName: cityName));
  }

  _fetchWeatherWithLocation() async {
    var permissionResult = await Permission.locationWhenInUse.status;

    switch (permissionResult) {
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        print('location permission denied');
        _showLocationDeniedDialog();
        break;

      case PermissionStatus.denied:
        await Permission.locationWhenInUse.request();
        _fetchWeatherWithLocation();
        break;

      case PermissionStatus.limited:
      case PermissionStatus.granted:
        print('getting location');
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low,
            timeLimit: const Duration(seconds: 2));

        print(position.toString());

        _weatherBloc.add(FetchWeather(
          longitude: position.longitude,
          latitude: position.latitude,
        ));
        break;
    }
  }

  void _showLocationDeniedDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          ThemeData appTheme = AppStateContainer.of(context).theme;

          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Location is disabled :(',
                style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: appTheme.colorScheme.secondary,
                  elevation: 1,
                ),
                onPressed: () {
                  openAppSettings();
                  Navigator.of(context).pop();
                },
                child: const Text('Enable!'),
              ),
            ],
          );
        });
  }
}
