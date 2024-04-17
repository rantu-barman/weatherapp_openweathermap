
// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';

import '../../models/forecastmodel.dart';
import '../../models/weather_hive.dart';

class LocalWeatherService{
  late Box box;
  late int? count;
  late int? selectedKey;

  Future<void> init() async {
    Hive.registerAdapter(ForecastWeatherModelHiveAdapter());
    box = await Hive.openBox('localweather');
    selectedKey = box.get('selectedKey', defaultValue: 0);
  }

  ForecastWeatherModelHive updateCurrentWeather(String cod, int message, int cnt, List<WeatherData> weatherDataList) {
    final ForecastWeatherModelHive u = box.get(selectedKey);
    u.cod = cod;
    u.message = message;
    u.cnt = cnt;
    u.weatherDataList = weatherDataList;
    box.putAt(selectedKey!, u);
    return box.get(selectedKey);
  }

  ForecastWeatherModelHive? fetchCurrentWeather() {
    try {
      final ForecastWeatherModelHive forecastWeatherModelHive = box.get(selectedKey);
      return forecastWeatherModelHive;
    } catch (e) {
      return null;
    }
  }
}
