import 'package:code_weather/model/weather.dart';
import 'package:code_weather/screens/widgets/current_conditions.dart';
import 'package:code_weather/screens/widgets/empty_widget.dart';
import 'package:code_weather/utils/app_state_container.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';

class WeatherSwipePager extends StatelessWidget {
  const WeatherSwipePager({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = AppStateContainer.of(context).theme;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: Swiper(
        itemCount: 2,
        index: 0,
        itemBuilder: (context, index) {
          if (index == 0) {
            return CurrentConditions(
              weather: weather,
            );
          } else if (index == 1) {
            return EmptyWidget();
          }
          return EmptyWidget();
        },
        pagination: SwiperPagination(
          margin: const EdgeInsets.all(5.0),
          builder: DotSwiperPaginationBuilder(
              size: 5,
              activeSize: 5,
              color: AppStateContainer.of(context)
                  .theme
                  .colorScheme
                  .secondary
                  .withOpacity(0.4),
              activeColor: appTheme.colorScheme.secondary),
        ),
      ),
    );
  }
}
