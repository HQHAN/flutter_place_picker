import 'dart:io';

import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double latitude;
  final double longtitude;
  final String address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longtitude,
    this.address,
  });

  PlaceLocation copyWith({
    double lat,
    double lng,
    String addr,
  }) {
    return PlaceLocation(
        longtitude: lng ?? longtitude,
        latitude: lat ?? latitude,
        address: addr ?? address);
  }
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place(
      {@required this.id,
      @required this.title,
      @required this.location,
      @required this.image});

  Map<String, Object> toDataBaseMap() {
    return {
      'id': id,
      'title': title,
      'image': image.path,
      'lat': location.latitude,
      'lnt': location.longtitude,
      'address': location.address,
    };
  }
}
