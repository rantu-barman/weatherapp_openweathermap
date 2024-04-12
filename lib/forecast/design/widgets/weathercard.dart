import 'package:flutter/material.dart';

import '../../models/forecastmodel.dart';

class WeatherCard extends StatelessWidget {
  final String date;
  final List<WeatherData> weatherDataList;

  const WeatherCard({super.key, required this.date, required this.weatherDataList});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              date,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: weatherDataList.length,
            itemBuilder: (context, index) {
              WeatherData weatherData = weatherDataList[index];
              return ListTile(
                title: Text(
                  '${weatherData.dtTxt.hour<12?weatherData.dtTxt.hour:weatherData.dtTxt.hour==12?'12': weatherData.dtTxt.hour-12}${weatherData.dtTxt.minute == 0 ?weatherData.dtTxt.hour<12? 'AM':'PM' : ':'}${weatherData.dtTxt.minute == 0 ? '' : weatherData.dtTxt.minute}',
                  style: const TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                  '${(weatherData.mainData.temp- 273.15).toInt()} °C, ${weatherData.weatherList.first.description}',
                  style: const TextStyle(fontSize: 14),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
