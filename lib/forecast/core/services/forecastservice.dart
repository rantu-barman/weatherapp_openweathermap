import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../../models/forecastmodel.dart';


class ForecastApiService {
  String apiKey = '53c530ea90c478a7522edbc4069d779d';

  Future<ForecastWeatherModel?> fetchWeather(double latitude, double longitude) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // final Map<String, dynamic> valuesMap = data['data']['values'];
       var a= ForecastWeatherModel.fromJson(data);
        return ForecastWeatherModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
