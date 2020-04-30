import 'package:noobcaster/core/settings/app_settings.dart';
import 'package:noobcaster/injection_container.dart';

String tempFromUnit(double kelvinTemp) {
  final tempUnit = sl<AppSettings>().getTempUnit();
  if (tempUnit == "°C") {
    return toCelcius(kelvinTemp);
  } else {
    return toFahrenheit(kelvinTemp);
  }
}

String toCelcius(double kelvinTemp) {
  return "${(kelvinTemp - 273.15).round()}°C";
}

String toFahrenheit(double kelvinTemp) {
  return "${((kelvinTemp - 273.15) * 9 / 5).round() + 32}°F";
}
