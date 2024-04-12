import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/dependencyinjection.dart';
import '../../models/forecastmodel.dart';
import '../services/forecastservice.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  final ForecastApiService _forecastApiService  = AppDependencyInjector.getIt.get();

  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  FutureOr<void> _onFetchWeather(
    FetchWeather event,
    Emitter<WeatherBlocState> emit,
  ) async {
    emit(WeatherBlocLoading());
    try {
      final coordinates = event.position;
      final weather = await _forecastApiService.fetchWeather(coordinates.latitude, coordinates.longitude);
      if (weather != null) {
        final location = await _getAddress(coordinates.latitude, coordinates.longitude);
        emit(WeatherBlocSuccess(weather, location ?? ""));
      } else {
        emit(WeatherBlocFailure());
      }
    } catch (_) {
      emit(WeatherBlocFailure());
    }
  }

  Future<String?> _getAddress(double latitude, double longitude) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        return '${placemark.subLocality}, ${placemark.locality}';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting address: $e');
      }
    }
    return null;
  }
}
