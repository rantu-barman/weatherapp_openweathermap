import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../core/forecasttileprovider.dart';

class MapClass extends StatefulWidget {
  const MapClass({super.key, required this.position});
  final Position? position;
  @override
  State<MapClass> createState() => _MapClassState();
}

class _MapClassState extends State<MapClass> {
  GoogleMapController? _controller;
  TileOverlay? _overlay;
  String _selectedMapType = 'temperature_new';

  @override
  void initState() {
    super.initState();
    _initTiles();
  }

  void _initTiles() async {
    final DateTime now = DateTime.now();
    _updateMapType();
  }

  void _updateMapType() {
    final DateTime now = DateTime.now();
    setState(() {
      _overlay = null;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _overlay = TileOverlay(
          tileOverlayId: const TileOverlayId('overlay'),
          tileProvider: ForecastTileProvider(
            mapType: _selectedMapType,
            dateTime: now,
            opacity: 0.4,
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition:  CameraPosition(
              target: LatLng(widget.position?.latitude??19.0760, widget.position?.longitude??72.8777),
              zoom: 6,
            ),
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                _controller = controller;
              });
            },
            tileOverlays: {
              if (_overlay != null) _overlay!,
            },
          ),
          Positioned(
            top: 40.h,
            left: 20.w,
            child: SizedBox(
              width: 400.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile<String>(
                    title: Text(
                      'Temperature',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                    ),
                    value: 'temperature_new',
                    groupValue: _selectedMapType,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedMapType = value!;
                        _updateMapType();
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Precipitation', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700)),
                    value: 'precipitation_new',
                    groupValue: _selectedMapType,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedMapType = value!;
                        _updateMapType();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
