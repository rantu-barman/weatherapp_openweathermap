import 'package:hive_flutter/hive_flutter.dart';

import 'forecastmodel.dart';
part 'weather_hive.g.dart';

@HiveType(typeId: 0)
class ForecastWeatherModelHive extends HiveObject {
  @HiveField(0)
   String? cod;

  @HiveField(1)
   int? message;

  @HiveField(2)
   int? cnt;

  @HiveField(3)
   List<WeatherData>? weatherDataList;

  ForecastWeatherModel toForecastWeatherModel() {
    return ForecastWeatherModel(
      cod: cod ?? "",
      message: message ?? 0,
      cnt: cnt ?? 0,
      weatherDataList: weatherDataList ?? [],
    );
  }
}
