import 'package:code_weather/model/weather.dart';
import 'package:code_weather/screens/widgets/forecast_horizontal_widget.dart';
import 'package:code_weather/screens/widgets/value_tile.dart';
import 'package:code_weather/screens/widgets/weather_swipe_pager.dart';
import 'package:code_weather/utils/app_state_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;
  const WeatherWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            weather.cityName!.toUpperCase(),
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 5,
              color: appTheme.colorScheme.secondary,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            weather.description!.toUpperCase(),
            style: TextStyle(
              fontSize: 15,
              letterSpacing: 5,
              fontWeight: FontWeight.w100,
              color: appTheme.colorScheme.secondary,
            ),
          ),
          WeatherSwipePager(weather: weather),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Divider(
              color: appTheme.colorScheme.secondary.withAlpha(50),
            ),
          ),
          ForecastHorizontal(weathers: weather.forecast!),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Divider(
              color: appTheme.colorScheme.secondary.withAlpha(50),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ValueTile("wind speed", '${weather.windSpeed} m/s'),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(
                width: 1,
                height: 30,
                color: AppStateContainer.of(context)
                    .theme
                    .colorScheme
                    .secondary
                    .withAlpha(50),
              )),
            ),
            ValueTile(
                "sunrise",
                DateFormat('h:m a').format(DateTime.fromMillisecondsSinceEpoch(
                    weather.sunrise! * 1000))),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(
                width: 1,
                height: 30,
                color: AppStateContainer.of(context)
                    .theme
                    .colorScheme
                    .secondary
                    .withAlpha(50),
              )),
            ),
            ValueTile(
                "sunset",
                DateFormat('h:m a').format(DateTime.fromMillisecondsSinceEpoch(
                    weather.sunset! * 1000))),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(
                width: 1,
                height: 30,
                color: AppStateContainer.of(context)
                    .theme
                    .colorScheme
                    .secondary
                    .withAlpha(50),
              )),
            ),
            ValueTile("humidity", '${weather.humidity}%'),
          ]),
        ],
      ),
    );
  }
}
