import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPolygon extends StatefulWidget {
  const GoogleMapPolygon({super.key});

  @override
  State<GoogleMapPolygon> createState() => _GoogleMapPolygonState();
}

class _GoogleMapPolygonState extends State<GoogleMapPolygon> {
  LatLng myCurrentLocation = const LatLng(39.9334, 32.8597);
  final Completer<GoogleMapController> _completer = Completer();

  Set<Marker> markers = {};

  Set<Polygon> polygone = HashSet<Polygon>();
  List<LatLng> points = [
    const LatLng(39.9334, 32.8597), // Example coordinates within Turkey (Ankara)
    const LatLng(41.0082, 28.9784), // Istanbul
    const LatLng(38.4237, 27.1428), // Izmir
    const LatLng(36.8969, 30.7133), // Antalya
    const LatLng(39.9334, 32.8597), // Ankara again to close the polygon
  ];
  void addPolygon() {
    polygone.add(
      Polygon(
        polygonId: const PolygonId("Id"),
        points: points,
        strokeColor: Colors.blueAccent,
        strokeWidth: 5,
        fillColor: Colors.green.withOpacity(0.1),
        geodesic: true,
      ),
    );
  }

  @override
  void initState() {
    addPolygon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      polygons: polygone,
      myLocationButtonEnabled: false,
      markers: markers,
      initialCameraPosition: CameraPosition(
        target: myCurrentLocation,
        zoom: 14,
      ),
      onMapCreated: (GoogleMapController controller) {
        _completer.complete(controller);
      },
    );
  }
}
