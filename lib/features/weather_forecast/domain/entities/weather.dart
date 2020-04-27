import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Weather extends Equatable {
  List<Object> get props;
}

class WeatherData extends Weather {
  final bool isLocal;
  final bool isCached;
  final DateTime dateTime;
  final DateTime sunrise;
  final DateTime sunset;
  final double currentTemp;
  final double uvi;
  final double windspeed;
  final int humidity;
  final String displayName;
  final String description;
  final String icon;
  final List<HourlyWeatherData> hourly;
  final List<DailyWeatherData> daily;

  WeatherData(
      {@required this.isCached,
      @required this.isLocal,
      @required this.dateTime,
      @required this.currentTemp,
      @required this.uvi,
      @required this.windspeed,
      @required this.sunrise,
      @required this.sunset,
      @required this.humidity,
      @required this.displayName,
      @required this.description,
      @required this.icon,
      @required this.hourly,
      @required this.daily});
  @override
  List<Object> get props => [
        currentTemp,
        uvi,
        windspeed,
        sunrise,
        sunset,
        humidity,
        description,
        displayName,
        icon,
        hourly,
        daily
      ];
}

class HourlyWeatherData extends Weather {
  final double temp;
  final int humidity;
  final int hour;
  final String icon;
  HourlyWeatherData(
      {@required this.temp,
      @required this.humidity,
      @required this.icon,
      @required this.hour});

  @override
  List<Object> get props => [temp, humidity, icon, hour];
}

class DailyWeatherData extends Weather {
  final double minTemp;
  final double maxTemp;
  final int humidity;
  final int weekday;
  final String icon;

  DailyWeatherData(
      {@required this.minTemp,
      @required this.maxTemp,
      @required this.humidity,
      @required this.icon,
      @required this.weekday});
  @override
  List<Object> get props => [minTemp, maxTemp, humidity, icon, weekday];
}
