import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Weather extends Equatable {
  List<Object> get props;
}

class WeatherData extends Weather {
  final double currentTemp;
  final double uvi;
  final int sunrise;
  final int sunset;
  final int humidity;
  final String displayName;
  final String description;
  final String icon;
  final List<HourlyWeatherData> hourly;
  final List<DailyWeatherData> daily;

  WeatherData(
      {@required this.currentTemp,
      @required this.uvi,
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
  final int unixtime;
  final String icon;
  HourlyWeatherData(
      {@required this.temp,
      @required this.humidity,
      @required this.icon,
      @required this.unixtime});

  @override
  List<Object> get props => [temp, humidity, icon];
}

class DailyWeatherData extends Weather {
  final double minTemp;
  final double maxTemp;
  final int humidity;
  final int unixtime;
  final String icon;

  DailyWeatherData(
      {@required this.minTemp,
      @required this.maxTemp,
      @required this.humidity,
      @required this.icon,
      @required this.unixtime});
  @override
  List<Object> get props => [minTemp, maxTemp, humidity, icon, unixtime];
}
