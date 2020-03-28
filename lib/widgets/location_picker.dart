import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:place_picker/helper/location_helper.dart';
import 'package:place_picker/models/place.dart';
import 'package:place_picker/screen/map_screen.dart';

class LocationPickerWidget extends StatefulWidget {
  final Function onSelectLocation;

  LocationPickerWidget(this.onSelectLocation);
  @override
  _LocationPickerWidgetState createState() => _LocationPickerWidgetState();
}

class _LocationPickerWidgetState extends State<LocationPickerWidget> {
  String _previewImageUrl;
  PlaceLocation _currentLocation;

  void _showPreivewImage(double lat, double lng) {
    setState(() {
      _previewImageUrl = LocationHelper.generateLocationImageUrl(
        latitude: lat,
        longtitude: lng,
      );
    });

    widget.onSelectLocation(PlaceLocation(latitude: lat, longtitude: lng));
  }

  Future<void> _getCurrentUserLocation({bool shouldShowPreview = true}) async {
    final locationData = await Location().getLocation();
    print(locationData.latitude);
    print(locationData.longitude);
    _currentLocation = PlaceLocation(
        latitude: locationData.latitude, longtitude: locationData.longitude);

    if (shouldShowPreview) {
      _showPreivewImage(locationData.latitude, locationData.longitude);
    }
  }

  Future<void> _openGoogleMap() async {
    if (_currentLocation == null) {
      await _getCurrentUserLocation(shouldShowPreview: false);
    }
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => GoogleMapScreen(
          initialLocation: PlaceLocation(
            latitude: _currentLocation.latitude,
            longtitude: _currentLocation.longtitude,
          ),
          isSelecting: true,
        ),
      ),
    );

    if (selectedLocation == null) {
      return;
    }

    widget.onSelectLocation(PlaceLocation(
      latitude: selectedLocation.latitude,
      longtitude: selectedLocation.longitude,
    ));

    _showPreivewImage(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: _previewImageUrl == null
              ? Text('No location chosen', textAlign: TextAlign.center)
              : Image.network(
                  _previewImageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentUserLocation,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text('Pick a location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _openGoogleMap,
            ),
          ],
        )
      ],
    );
  }
}
