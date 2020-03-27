import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:place_picker/models/place.dart';

class GreatPlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void savePlace(String title, File imageFile) {
    _items.add(
      Place(
        id: DateTime.now().toString(),
        image: imageFile,
        title: title,
        location: null,
      ),
    );
  }
}
