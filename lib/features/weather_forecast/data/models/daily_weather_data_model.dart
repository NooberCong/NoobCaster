import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';
import 'package:meta/meta.dart';

class DailyWeatherDataModel extends DailyWeatherData {
  DailyWeatherDataModel({
    @required double minTemp,
    @required double maxTemp,
    @required int humidity,
    @required int unixtime,
    @required String icon,
  }) : super(
            humidity: humidity,
            icon: icon,
            maxTemp: maxTemp,
            minTemp: minTemp,
            unixtime: unixtime);
  factory DailyWeatherDataModel.fromJson(Map<String, dynamic> json) {
    return DailyWeatherDataModel(
        humidity: json["humidity"],
        icon: json["weather"][0]["icon"],
        unixtime: json["dt"],
        maxTemp: (json["temp"]["max"] as num).toDouble(),
        minTemp: (json["temp"]["min"] as num).toDouble());
  }
  Map<String, dynamic> toJson() {
    return {
      "humidity": humidity,
      "weather": [
        {"icon": icon}
      ],
      "dt": unixtime,
      "temp": {"max": maxTemp, "min": minTemp}
    };
  }
}
