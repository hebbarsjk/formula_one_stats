import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class LocateCircuit extends StatefulWidget {
  double lat, long;
  LocateCircuit(this.lat, this.long);

  @override
  _LocateCircuitState createState() => _LocateCircuitState();
}

class _LocateCircuitState extends State<LocateCircuit> {
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Circuit Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat, widget.long),
          zoom: 16.0,
        ),
        onMapCreated: _onMapCreated,
        mapType: MapType.satellite,
        buildingsEnabled: true,
      ),
    );
  }
}
