import 'package:code_weather/model/weather.dart';
import 'package:code_weather/screens/widgets/value_tile.dart';
import 'package:code_weather/utils/converter.dart';
import 'package:flutter/material.dart';

import '../../utils/app_state_container.dart';

class CurrentConditions extends StatelessWidget {
  final Weather weather;
  const CurrentConditions({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;
    TemperatureUnit unit = AppStateContainer.of(context).temperatureUnit;

    int currentTemp = weather.temperature!.as(unit).round();
    int maxTemp = weather.maxTemperature!.as(unit).round();
    int minTemp = weather.minTemperature!.as(unit).round();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          weather.getIconData(),
          color: appTheme.colorScheme.secondary,
          size: 70,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          '$currentTemp°',
          style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.w100,
              color: appTheme.colorScheme.secondary),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ValueTile("max", '$maxTemp'),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Center(
                child: Container(
              width: 1,
              height: 30,
              color: appTheme.colorScheme.secondary.withAlpha(50),
            )),
          ),
          ValueTile("min", '$minTemp°'),
        ]),
      ],
    );
  }
}
