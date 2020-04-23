import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:noobcaster/core/util/input_validator.dart';
import 'package:noobcaster/features/weather_forecast/domain/usecases/get_local_weather_data.dart';
import 'package:noobcaster/features/weather_forecast/domain/usecases/get_location_weather_data.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';
part 'weather_data_event.dart';
part 'weather_data_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server error: Please check your internet connection";
const String CACHE_FAILURE_MESSAGE = "Cache error: No previous data found";
const String PERMISSION_FAILURE_MESSAGE = "Permission error: NooberCast has no permission to access device location";
const String INPUT_FAILURE_MESSAGE = ""

class WeatherDataBloc extends Bloc<WeatherDataEvent, WeatherDataState> {
  final GetLocalWeatherData getLocalWeatherData;
  final GetLocationWeatherData getLocationWeatherData;
  final InputValidator validator;

  WeatherDataBloc(
      {@required InputValidator validator,
      @required GetLocalWeatherData local,
      @required GetLocationWeatherData location})
      : assert(validator != null),
        assert(local != null),
        assert(location != null),
        validator = validator,
        getLocalWeatherData = local,
        getLocationWeatherData = location;
  @override
  WeatherDataState get initialState => WeatherDataLoading();

  @override
  Stream<WeatherDataState> mapEventToState(
    WeatherDataEvent event,
  ) async* {}
}
