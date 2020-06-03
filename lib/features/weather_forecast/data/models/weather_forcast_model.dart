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
      @required double feelsLike,
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
            feelsLike: feelsLike,
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
        feelsLike: (json["current"]["feels_like"] as num).toDouble(),
        uvi: (json["current"]["uvi"] as num).toDouble(),
        windspeed: (json["current"]["wind_speed"] as num).toDouble(),
        dateTime: handler.dateTimeFromUnixAndTimezone(
            json["timezone"] as String, json["current"]["dt"] as int),
        sunset: handler.dateTimeFromUnixAndTimezone(
            json["timezone"] as String, json["current"]["sunset"] as int),
        sunrise: handler.dateTimeFromUnixAndTimezone(
            json["timezone"] as String, json["current"]["sunrise"] as int),
        icon: json["current"]["weather"][0]["icon"] as String,
        humidity: (json["current"]["humidity"] as num).toInt(),
        displayName: displayName,
        description: json["current"]["weather"][0]["description"] as String,
        hourly: (json["hourly"] as List<dynamic>)
            .map(
              (hour) => HourlyWeatherDataModel.fromServerJsonWithTimezone(
                hour as Map<String, dynamic>,
                handler,
                json["timezone"] as String,
              ),
            )
            .toList(),
        daily: (json["daily"] as List<dynamic>)
            .map(
              (day) => DailyWeatherDataModel.fromServerJsonWithTimezone(
                day as Map<String, dynamic>,
                handler,
                json["timezone"] as String,
              ),
            )
            .toList());
  }
  factory WeatherDataModel.fromCacheJson(Map<String, dynamic> json) {
    return WeatherDataModel(
        isCached: json["isCached"] as bool,
        isLocal: json["isLocal"] as bool,
        currentTemp: json["temp"] as double,
        feelsLike: json["feelsLike"] as double,
        uvi: json["uvi"] as double,
        windspeed: json["wind_speed"] as double,
        dateTime: DateTime.parse(json["datetime"] as String),
        sunset: DateTime.parse(json["sunset"] as String),
        sunrise: DateTime.parse(json["sunrise"] as String),
        icon: json["icon"] as String,
        humidity: json["humidity"] as int,
        displayName: json["displayName"] as String,
        description: json["description"] as String,
        hourly: (json["hourly"] as List<dynamic>)
            .map((hour) => HourlyWeatherDataModel.fromCacheJson(
                hour as Map<String, dynamic>))
            .toList(),
        daily: (json["daily"] as List<dynamic>)
            .map((day) => DailyWeatherDataModel.fromCacheJson(
                day as Map<String, dynamic>))
            .toList());
  }
  Map<String, dynamic> toJson() {
    return {
      "isCached": true,
      "isLocal": isLocal,
      "datetime": dateTime.toString().substring(0, 19),
      "displayName": displayName,
      "temp": currentTemp,
      "feelsLike": feelsLike,
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
