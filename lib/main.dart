import 'package:code_weather/bloc/weather_bloc.dart';
import 'package:code_weather/routes.dart';
import 'package:code_weather/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/weather_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final WeatherRepository weatherRepository;
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: BlocProvider(
        create: ((context) => WeatherBloc()),
        child: const Homepage(),
      ),
      routes: Routes.mainRoute,
    );
  }
}
