import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';
import 'package:meta/meta.dart';

class HourlyWeatherDataModel extends HourlyWeatherData {
  HourlyWeatherDataModel({
    @required double temp,
    @required int humidity,
    @required int unixtime,
    @required String icon,
  }) : super(humidity: humidity, icon: icon, temp: temp, unixtime: unixtime);

  factory HourlyWeatherDataModel.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherDataModel(
        humidity: json["humidity"],
        icon: json["weather"][0]["icon"],
        temp: json["temp"],
        unixtime: json["dt"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "humidity": humidity,
      "weather": [{"icon": icon}],
      "temp": temp,
      "dt": unixtime
    };
  }
}
