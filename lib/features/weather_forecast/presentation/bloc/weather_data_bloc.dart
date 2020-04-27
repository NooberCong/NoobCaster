import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:noobcaster/core/error/failure.dart';
import 'package:noobcaster/core/usecases/usecase.dart';
import 'package:noobcaster/core/util/input_validator.dart';
import 'package:noobcaster/features/weather_forecast/domain/usecases/get_local_weather_data.dart';
import 'package:noobcaster/features/weather_forecast/domain/usecases/get_location_weather_data.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';
part 'weather_data_event.dart';
part 'weather_data_state.dart';

const String SERVER_FAILURE_MESSAGE =
    "Server error: Please check your internet connection";
const String CACHE_FAILURE_MESSAGE = "Cache error: No previous data found";
const String PERMISSION_FAILURE_MESSAGE =
    "Permission error: NooberCaster was not permitted to locate device location";
const String INPUT_FAILURE_MESSAGE = "Invalid city name, please try again";

class WeatherDataBloc extends Bloc<WeatherDataEvent, WeatherDataState> {
  final GetLocalWeatherData getLocalWeatherData;
  final GetLocationWeatherData getLocationWeatherData;
  final InputValidator validator;

  WeatherDataBloc(
      {@required InputValidator inputValidator,
      @required GetLocalWeatherData local,
      @required GetLocationWeatherData location})
      : assert(inputValidator != null),
        assert(local != null),
        assert(location != null),
        validator = inputValidator,
        getLocalWeatherData = local,
        getLocationWeatherData = location;
  @override
  WeatherDataState get initialState => WeatherDataInitial();

  @override
  Stream<WeatherDataState> mapEventToState(
    WeatherDataEvent event,
  ) async* {
    if (event is GetLocationWeatherEvent) {
      yield WeatherDataLoading();
      yield* getLocationWeatherResult(event.location);
    } else if (event is GetLocalWeatherEvent) {
      yield WeatherDataLoading();
      yield* getLocalWeatherResult();
    } else if (event is RefreshWeatherDataEvent) {
      final state = event.currentState;
      if (state is WeatherDataLoaded) {
        yield WeatherDataLoading();
        if (state.data.isLocal) {
          yield* getLocalWeatherResult();
        } else {
          yield* getLocationWeatherResult(state.data.displayName);
        }
      }
    }
  }

  Stream<WeatherDataState> getLocationWeatherResult(String location) async* {
    final isValid = validator.validate(location);
    if (!isValid) {
      yield WeatherDataError(message: INPUT_FAILURE_MESSAGE);
    } else {
      final failureOrData =
          await getLocationWeatherData(Params(location: location));
      yield failureOrData.fold(
          (failure) => WeatherDataError(message: _mapFailureToMessage(failure)),
          (data) => WeatherDataLoaded(data: data));
    }
  }

  Stream<WeatherDataState> getLocalWeatherResult() async* {
    final failureOrData = await getLocalWeatherData(NoParams());
    yield failureOrData.fold(
        (failure) => WeatherDataError(message: _mapFailureToMessage(failure)),
        (data) => WeatherDataLoaded(data: data));
  }

  String _mapFailureToMessage(Failure failure) {
    return failure is ServerFailure
        ? SERVER_FAILURE_MESSAGE
        : failure is CacheFailure
            ? CACHE_FAILURE_MESSAGE
            : failure is PermissionFailure
                ? PERMISSION_FAILURE_MESSAGE
                : INPUT_FAILURE_MESSAGE;
  }
}
