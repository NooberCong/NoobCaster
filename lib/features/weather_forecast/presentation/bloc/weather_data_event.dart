part of 'weather_data_bloc.dart';

abstract class WeatherDataEvent extends Equatable {
  const WeatherDataEvent();
}

class GetLocalWeatherEvent extends WeatherDataEvent {
  @override
  List<Object> get props => [];
}

class GetLocationWeatherEvent extends WeatherDataEvent {
  final String location;
  GetLocationWeatherEvent(this.location);
  @override
  List<Object> get props => [location];
}
