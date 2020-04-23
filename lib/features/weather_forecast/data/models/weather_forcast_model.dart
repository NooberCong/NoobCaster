import 'package:meta/meta.dart';
import 'package:noobcaster/features/weather_forecast/data/models/daily_weather_data_model.dart';
import 'package:noobcaster/features/weather_forecast/data/models/hourly_weather_data_model.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';

class WeatherDataModel extends WeatherData {
  WeatherDataModel(
      {@required double currentTemp,
      @required double uvi,
      @required int sunrise,
      @required int sunset,
      @required String displayName,
      @required int humidity,
      @required String description,
      @required String icon,
      @required List<HourlyWeatherData> hourly,
      @required List<DailyWeatherData> daily})
      : super(
            currentTemp: currentTemp,
            uvi: uvi,
            sunrise: sunrise,
            displayName: displayName,
            sunset: sunset,
            humidity: humidity,
            description: description,
            icon: icon,
            hourly: hourly,
            daily: daily);
  factory WeatherDataModel.fromJson(Map<String, dynamic> json, {String displayName}) {
    return WeatherDataModel(
        currentTemp: json["current"]["temp"],
        uvi: json["current"]["uvi"],
        sunset: json["current"]["sunset"],
        sunrise: json["current"]["sunrise"],
        icon: json["current"]["weather"][0]["icon"],
        humidity: json["current"]["humidity"],
        displayName: displayName?? json["displayName"],
        description: json["current"]["weather"][0]["description"],
        hourly: (json["hourly"] as List<dynamic>)
            .map((hour) => HourlyWeatherDataModel.fromJson(hour))
            .toList(),
        daily: (json["daily"] as List<dynamic>)
            .map((day) => DailyWeatherDataModel.fromJson(day))
            .toList());
  }
  Map<String, dynamic> toJson() {
    return {
      "current": {
        "temp": currentTemp,
        "uvi": uvi,
        "sunset": sunset,
        "sunrise": sunrise,
        "humidity": humidity,
        "weather": [
          {"icon": icon, "description": description},
        ]
      },
      "hourly": hourly.map((hour) => (hour as HourlyWeatherDataModel).toJson()).toList(),
      "daily": daily.map((day) => (day as DailyWeatherDataModel).toJson()).toList()
    };
  }
}
