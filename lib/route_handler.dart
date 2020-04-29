import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobcaster/features/weather_forecast/presentation/bloc/weather_data_bloc.dart';
import 'package:noobcaster/features/weather_forecast/presentation/routes/SearchRoute.dart';
import 'package:noobcaster/features/weather_forecast/presentation/routes/SettingsRoute.dart';

const LOCATION_SEARCH_ROUTE = '/search';
const SETTINGS_ROUTE = '/settings';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LOCATION_SEARCH_ROUTE:
      return MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: BlocProvider.of<WeatherDataBloc>(context),
          child: SearchRoute(),
        ),
      );
    case SETTINGS_ROUTE:
      return MaterialPageRoute(
        builder: (context) => SettingsRoute(),
      );
    default:
      return MaterialPageRoute(builder: (context) => null);
  }
}
