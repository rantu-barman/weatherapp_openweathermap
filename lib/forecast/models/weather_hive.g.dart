// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForecastWeatherModelHiveAdapter
    extends TypeAdapter<ForecastWeatherModelHive> {
  @override
  final int typeId = 0;

  @override
  ForecastWeatherModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ForecastWeatherModelHive()
      ..cod = fields[0] as String?
      ..message = fields[1] as int?
      ..cnt = fields[2] as int?
      ..weatherDataList = (fields[3] as List?)?.cast<WeatherData>();
  }

  @override
  void write(BinaryWriter writer, ForecastWeatherModelHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.cod)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.cnt)
      ..writeByte(3)
      ..write(obj.weatherDataList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForecastWeatherModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
