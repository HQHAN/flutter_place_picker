import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker/models/place.dart';

class GoogleMapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  GoogleMapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 32.0, longtitude: 127.0),
      this.isSelecting = false});

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  LatLng _tappedLocation;

  void onUserTap(LatLng location) {
    setState(() {
      _tappedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _tappedLocation == null
                  ? null
                  : () => Navigator.of(context).pop(_tappedLocation),
            )
        ],
      ),
      body: GoogleMap(
        markers: _tappedLocation == null
            ? null
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: _tappedLocation,
                ),
              },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longtitude,
          ),
          zoom: 10,
        ),
        onTap: widget.isSelecting ? onUserTap : null,
      ),
    );
  }
}
