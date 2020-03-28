import 'dart:convert';

import 'package:http/http.dart' as http;

class LocationHelper {
  static const GMAP_API_KEY = 'AIzaSyDpODFL500vZ4g19oJIpUtpEePvVUrokwU';

  static String generateLocationImageUrl({double latitude, double longtitude,}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longtitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longtitude&key=$GMAP_API_KEY'; 
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final response = await http.get('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GMAP_API_KEY');

    if(response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      print(jsonBody);
      final results = json.decode(response.body)['results'];
      return results[0] != null ? results[0]['formatted_address'] : '';
    }
  }
}