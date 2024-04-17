import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../../../core/dependencyinjection.dart';
import '../../models/forecastmodel.dart';
import 'weather_local_service.dart';

class ForecastApiService {
  String apiKey = '53c530ea90c478a7522edbc4069d779d';
  final LocalWeatherService localWeatherService = AppDependencyInjector.getIt.get();

  Future<ForecastWeatherModel?> fetchWeather(double latitude, double longitude) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // final Map<String, dynamic> valuesMap = data['data']['values'];
        var forecastdata = ForecastWeatherModel.fromJson(data);
        localWeatherService.updateCurrentWeather(forecastdata.cod, forecastdata.message, forecastdata.cnt, forecastdata.weatherDataList);
        return forecastdata;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
