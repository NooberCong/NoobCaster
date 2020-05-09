import 'package:meta/meta.dart';
import 'package:noobcaster/core/util/time_zone_handler.dart';
import 'package:noobcaster/features/weather_forecast/data/models/daily_weather_data_model.dart';
import 'package:noobcaster/features/weather_forecast/data/models/hourly_weather_data_model.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';

class WeatherDataModel extends WeatherData {
  WeatherDataModel(
      {@required bool isLocal,
      @required bool isCached,
      @required DateTime dateTime,
      @required DateTime sunrise,
      @required DateTime sunset,
      @required double currentTemp,
      @required double uvi,
      @required double windspeed,
      @required String displayName,
      @required int humidity,
      @required String description,
      @required String icon,
      @required List<HourlyWeatherData> hourly,
      @required List<DailyWeatherData> daily})
      : super(
            isCached: isCached,
            isLocal: isLocal,
            dateTime: dateTime,
            currentTemp: currentTemp,
            uvi: uvi,
            windspeed: windspeed,
            sunrise: sunrise,
            displayName: displayName,
            sunset: sunset,
            humidity: humidity,
            description: description,
            icon: icon,
            hourly: hourly,
            daily: daily);
  factory WeatherDataModel.fromServerJsonWithTimezone(Map<String, dynamic> json,
      {String displayName, TimezoneHandler handler, bool isLocal}) {
    return WeatherDataModel(
        isLocal: isLocal,
        isCached: false,
        currentTemp: (json["current"]["temp"] as num).toDouble(),
        uvi: (json["current"]["uvi"] as num).toDouble(),
        windspeed: (json["current"]["wind_speed"] as num).toDouble(),
        dateTime: handler.dateTimeFromUnixAndTimezone(
            json["timezone"], json["current"]["dt"]),
        sunset: handler.dateTimeFromUnixAndTimezone(
            json["timezone"], json["current"]["sunset"]),
        sunrise: handler.dateTimeFromUnixAndTimezone(
            json["timezone"], json["current"]["sunrise"]),
        icon: json["current"]["weather"][0]["icon"],
        humidity: json["current"]["humidity"],
        displayName: displayName,
        description: json["current"]["weather"][0]["description"],
        hourly: (json["hourly"] as List<dynamic>)
            .map(
              (hour) => HourlyWeatherDataModel.fromServerJsonWithTimezone(
                hour,
                handler,
                json["timezone"],
              ),
            )
            .toList(),
        daily: (json["daily"] as List<dynamic>)
            .map(
              (day) => DailyWeatherDataModel.fromServerJsonWithTimezone(
                day,
                handler,
                json["timezone"],
              ),
            )
            .toList());
  }
  factory WeatherDataModel.fromCacheJson(Map<String, dynamic> json) {
    return WeatherDataModel(
        isCached: json["isCached"],
        isLocal: json["isLocal"],
        currentTemp: json["temp"],
        uvi: json["uvi"],
        windspeed: json["wind_speed"],
        dateTime: DateTime.parse(json["datetime"]),
        sunset: DateTime.parse(json["sunset"]),
        sunrise: DateTime.parse(json["sunrise"]),
        icon: json["icon"],
        humidity: json["humidity"],
        displayName: json["displayName"],
        description: json["description"],
        hourly: (json["hourly"] as List<dynamic>)
            .map((hour) => HourlyWeatherDataModel.fromCacheJson(hour))
            .toList(),
        daily: (json["daily"] as List<dynamic>)
            .map((day) => DailyWeatherDataModel.fromCacheJson(day))
            .toList());
  }
  Map<String, dynamic> toJson() {
    return {
      "isCached": true,
      "isLocal": isLocal,
      "datetime": dateTime.toString().substring(0, 19),
      "displayName": displayName,
      "temp": currentTemp,
      "uvi": uvi,
      "wind_speed": windspeed,
      "sunset": sunset.toString().substring(0, 19),
      "sunrise": sunrise.toString().substring(0, 19),
      "humidity": humidity,
      "icon": icon,
      "description": description,
      "hourly": hourly
          .map((hour) => (hour as HourlyWeatherDataModel).toJson())
          .toList(),
      "daily":
          daily.map((day) => (day as DailyWeatherDataModel).toJson()).toList()
    };
  }
}
