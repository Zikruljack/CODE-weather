import 'package:code_weather/utils/app_state_container.dart';
import 'package:code_weather/utils/converter.dart';
import 'package:code_weather/utils/theme.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTheme.primaryColor,
        title: const Text("Settings"),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
        color: appTheme.primaryColor,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Theme",
                style: TextStyle(
                  color: appTheme.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                color: AppStateContainer.of(context)
                    .theme
                    .colorScheme
                    .secondary
                    .withOpacity(0.1),
              ),
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Dark",
                    style: TextStyle(color: appTheme.colorScheme.secondary),
                  ),
                  Radio(
                    value: Themes.DARK_THEME_CODE,
                    groupValue: AppStateContainer.of(context).themeCode,
                    onChanged: (value) {
                      AppStateContainer.of(context).updateTheme(value!);
                    },
                    activeColor: appTheme.colorScheme.secondary,
                  )
                ],
              ),
            ),
            Divider(
              color: appTheme.primaryColor,
              height: 1,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                color: AppStateContainer.of(context)
                    .theme
                    .colorScheme
                    .secondary
                    .withOpacity(0.1),
              ),
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Light",
                    style: TextStyle(color: appTheme.colorScheme.secondary),
                  ),
                  Radio(
                    value: Themes.LIGHT_THEME_CODE,
                    groupValue: AppStateContainer.of(context).themeCode,
                    onChanged: (value) {
                      AppStateContainer.of(context).updateTheme(value!);
                    },
                    activeColor: appTheme.colorScheme.secondary,
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 8),
              child: Text(
                "Unit",
                style: TextStyle(
                  color: appTheme.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                color: AppStateContainer.of(context)
                    .theme
                    .colorScheme
                    .secondary
                    .withOpacity(0.1),
              ),
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Celsius",
                    style: TextStyle(color: appTheme.colorScheme.secondary),
                  ),
                  Radio(
                    value: TemperatureUnit.celsius.index,
                    groupValue:
                        AppStateContainer.of(context).temperatureUnit.index,
                    onChanged: (value) {
                      AppStateContainer.of(context).updateTemperatureUnit(
                          TemperatureUnit.values[value!]);
                    },
                    activeColor: appTheme.colorScheme.secondary,
                  )
                ],
              ),
            ),
            Divider(
              color: appTheme.primaryColor,
              height: 1,
            ),
            Container(
              color: AppStateContainer.of(context)
                  .theme
                  .colorScheme
                  .secondary
                  .withOpacity(0.1),
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Fahrenheit",
                    style: TextStyle(color: appTheme.colorScheme.secondary),
                  ),
                  Radio(
                    value: TemperatureUnit.fahrenheit.index,
                    groupValue:
                        AppStateContainer.of(context).temperatureUnit.index,
                    onChanged: (value) {
                      AppStateContainer.of(context).updateTemperatureUnit(
                          TemperatureUnit.values[value!]);
                    },
                    activeColor: appTheme.colorScheme.secondary,
                  )
                ],
              ),
            ),
            Divider(
              color: appTheme.primaryColor,
              height: 1,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                color: AppStateContainer.of(context)
                    .theme
                    .colorScheme
                    .secondary
                    .withOpacity(0.1),
              ),
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Kelvin",
                    style: TextStyle(color: appTheme.colorScheme.secondary),
                  ),
                  Radio(
                    value: TemperatureUnit.kelvin.index,
                    groupValue:
                        AppStateContainer.of(context).temperatureUnit.index,
                    onChanged: (value) {
                      AppStateContainer.of(context).updateTemperatureUnit(
                          TemperatureUnit.values[value!]);
                    },
                    activeColor: appTheme.colorScheme.secondary,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
