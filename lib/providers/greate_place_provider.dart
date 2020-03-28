import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:place_picker/helper/db_helper.dart';
import 'package:place_picker/helper/location_helper.dart';
import 'package:place_picker/models/place.dart';

class GreatPlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void savePlace(String title, File imageFile, PlaceLocation selected) async {
    final address = await LocationHelper.getPlaceAddress(
      selected.latitude,
      selected.longtitude,
    );

    final updatedPlaceLocation = selected.copyWith(addr: address);

    final itemToAdd = Place(
      id: DateTime.now().toString(),
      image: imageFile,
      title: title,
      location: updatedPlaceLocation,
    );
    _items.add(itemToAdd);
    notifyListeners();

    DBHelper.insert(DBHelper.USER_PLACE_TABLE_NAME, itemToAdd.toDataBaseMap());
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData(DBHelper.USER_PLACE_TABLE_NAME);
    _items = dataList
        .map(
          (item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              location: PlaceLocation(
                  latitude: item['lat'],
                  longtitude: item['lnt'],
                  address: item['address'])),
        )
        .toList();
    notifyListeners();
  }
}
