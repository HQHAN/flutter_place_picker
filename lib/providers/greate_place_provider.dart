import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:place_picker/helper/db_helper.dart';
import 'package:place_picker/models/place.dart';

class GreatPlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void savePlace(String title, File imageFile) async {
    final itemToAdd = Place(
      id: DateTime.now().toString(),
      image: imageFile,
      title: title,
      location: null,
    );
    _items.add(itemToAdd);
    notifyListeners();

    DBHelper.insert(DBHelper.USER_PLACE_TABLE_NAME, itemToAdd.toMap());
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData(DBHelper.USER_PLACE_TABLE_NAME);
    _items = dataList.map(
      (item) => Place(
          id: item['id'],
          title: item['title'],
          image: File(item['image']),
          location: null),
    ).toList();
    notifyListeners();
  }
}
