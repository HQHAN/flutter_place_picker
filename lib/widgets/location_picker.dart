import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:place_picker/helper/location_helper.dart';

class LocationPickerWidget extends StatefulWidget {
  @override
  _LocationPickerWidgetState createState() => _LocationPickerWidgetState();
}

class _LocationPickerWidgetState extends State<LocationPickerWidget> {
  String _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locationData = await Location().getLocation();
    print(locationData.latitude);
    print(locationData.longitude);
    setState(() {
      _previewImageUrl = LocationHelper.generateLocationImageUrl(
        latitude: locationData.latitude,
        longtitude: locationData.longitude,
      );
    });
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
                onPressed: () {}),
          ],
        )
      ],
    );
  }
}
