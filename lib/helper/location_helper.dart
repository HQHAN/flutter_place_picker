class LocationHelper {
  static const GMAP_API_KEY = 'AIzaSyDpODFL500vZ4g19oJIpUtpEePvVUrokwU';

  static String generateLocationImageUrl({double latitude, double longtitude,}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longtitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longtitude&key=$GMAP_API_KEY'; 
  }
}