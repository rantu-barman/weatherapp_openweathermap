import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ForecastTileProvider implements TileProvider {
  final String mapType;
  final DateTime dateTime;
  int tileSize = 256;
  final double opacity;

  ForecastTileProvider({
    required this.mapType,
    required this.dateTime,
    required this.opacity,
  });

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    String apiKey = '53c530ea90c478a7522edbc4069d779d';
    Uint8List tileBytes = Uint8List(0);
    try {
      final date = dateTime.millisecondsSinceEpoch ~/ 1000;
      late String url;
      if (mapType == 'temperature_new') {
        url = "http://tile.openweathermap.org/map/temp_new/$zoom/$x/$y.png?appid=$apiKey";
      } else if (mapType == 'precipitation_new') {
        url = "http://tile.openweathermap.org/map/precipitation_new/$zoom/$x/$y.png?appid=$apiKey";
      }
      final ByteData imageData = await NetworkAssetBundle(Uri.parse(url)).load("");
      tileBytes = imageData.buffer.asUint8List();
    } catch (e) {
      print(e.toString());
    }
    return Tile(tileSize, tileSize, tileBytes);
  }
}
