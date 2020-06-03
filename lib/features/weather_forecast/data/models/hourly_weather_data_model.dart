import 'package:noobcaster/core/util/time_zone_handler.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';
import 'package:meta/meta.dart';

class HourlyWeatherDataModel extends HourlyWeatherData {
  HourlyWeatherDataModel({
    @required double temp,
    @required int humidity,
    @required int hour,
    @required String icon,
  }) : super(humidity: humidity, icon: icon, temp: temp, hour: hour);

  factory HourlyWeatherDataModel.fromServerJsonWithTimezone(
      Map<String, dynamic> json, TimezoneHandler handler, String timezone) {
    return HourlyWeatherDataModel(
        humidity: (json["humidity"] as num).toInt(),
        icon: json["weather"][0]["icon"] as String,
        temp: (json["temp"] as num).toDouble(),
        hour: handler
            .dateTimeFromUnixAndTimezone(timezone, json["dt"] as int)
            .hour);
  }
  factory HourlyWeatherDataModel.fromCacheJson(Map<String, dynamic> json) {
    return HourlyWeatherDataModel(
        humidity: (json["humidity"] as num).toInt(),
        icon: json["icon"] as String,
        temp: (json["temp"] as num).toDouble(),
        hour: json["hour"] as int);
  }
  Map<String, dynamic> toJson() {
    return {"humidity": humidity, "icon": icon, "temp": temp, "hour": hour};
  }
}
