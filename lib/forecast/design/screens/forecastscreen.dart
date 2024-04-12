import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/bloc/weather_bloc_bloc.dart';
import '../../core/services/forecastservice.dart';
import '../../models/forecastmodel.dart';
import '../widgets/weathercard.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, this.position});
  final Position? position;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late ForecastApiService _apiService;
  Future<ForecastWeatherModel?>? _weatherFuture;

  @override
  void initState() {
    super.initState();
    _apiService = ForecastApiService();
    _weatherFuture = _fetchWeatherData();
  }

  Future<ForecastWeatherModel?> _fetchWeatherData() async {
    return _apiService.fetchWeather(widget.position?.latitude ?? 19.0760, widget.position?.longitude ?? 72.8777);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
      ),
      body: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
        builder: (context, state) {
          if (state is WeatherBlocSuccess) {
              Map<String, List<WeatherData>> groupedData = {};
            for (var weatherData in state.forecastWeatherModel.weatherDataList) {
              String date = weatherData.dtTxt.toString().split(' ')[0];
              if (!groupedData.containsKey(date)) {
                groupedData[date] = [];
              }
              groupedData[date]!.add(weatherData);
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    '📍 ${state.location}',
                    style: const TextStyle(fontSize: 24,color: Colors.black, fontWeight: FontWeight.w300),
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                      itemCount: groupedData.length,
                      itemBuilder: (context, index) {
                        String date = groupedData.keys.elementAt(index);
                        List<WeatherData> weatherDataList = groupedData[date]!;
                        return WeatherCard(date: date, weatherDataList: weatherDataList);
                      }),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
