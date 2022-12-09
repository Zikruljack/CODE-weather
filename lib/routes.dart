import 'package:code_weather/screens/homepage.dart';
import 'package:code_weather/screens/settings.dart';
import 'package:flutter/material.dart';

class Routes {
  static final mainRoute = <String, WidgetBuilder>{
    '/home': (context) => const Homepage(),
    '/settings': (context) => SettingsPage(),
  };
}
