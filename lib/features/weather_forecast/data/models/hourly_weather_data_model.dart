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
        humidity: json["humidity"],
        icon: json["weather"][0]["icon"],
        temp: (json["temp"] as num).toDouble(),
        hour: handler.dateTimeFromUnixAndTimezone(timezone, json["dt"]).hour);
  }
  factory HourlyWeatherDataModel.fromCacheJson(Map<String, dynamic> json) {
    return HourlyWeatherDataModel(
        humidity: json["humidity"],
        icon: json["icon"],
        temp: (json["temp"] as num).toDouble(),
        hour: json["hour"]);
  }
  Map<String, dynamic> toJson() {
    return {"humidity": humidity, "icon": icon, "temp": temp, "hour": hour};
  }
}
