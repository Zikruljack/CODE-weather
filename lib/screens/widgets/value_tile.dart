import 'package:code_weather/screens/widgets/empty_widget.dart';
import 'package:code_weather/utils/app_state_container.dart';
import 'package:flutter/material.dart';

class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData? iconData;

  const ValueTile(this.label, this.value, {this.iconData});

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              color: AppStateContainer.of(context)
                  .theme
                  .colorScheme
                  .secondary
                  .withAlpha(80)),
        ),
        const SizedBox(
          height: 5,
        ),
        iconData != null
            ? Icon(
                iconData,
                color: appTheme.colorScheme.secondary,
                size: 20,
              )
            : EmptyWidget(),
        const SizedBox(
          height: 10,
        ),
        Text(
          value,
          style: TextStyle(color: appTheme.colorScheme.secondary),
        ),
      ],
    );
  }
}
