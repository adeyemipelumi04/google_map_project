import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_project/models/auto_complete_result.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapServices {
  final String key = "AIzaSyBkAD765nBD-Mm_wfzM1W5mUGQ58z5bEW0";
  final String types = "geocode";

  Future<List<AutoCompleteResult>> searchPlaces(String searchInput) async{
    final url = 
    "https://maps.googleapis.com/maps/api/place/autocomplete/output?json?input=$searchInput&types=$types&key=$key";

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var results = json['predictions'] as List;

    return results.map((e) => AutoCompleteResult.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> getPlace(String? input) async {
    final String url = "https://maps.googleapis.com/maps/api/place/detials/json?place_id=$input&key=$key";

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var results = json['results'] as Map<String, dynamic>;

    return results;
  }
  Future<Map<String, dynamic>> getDirection(String origin, String destination) async {
    String url = "https://maps.googleapis.com/maps/api/place/autocomplete/output?json?origin=$origin&destination=$destination&key=$key";

    var response = await http.get(Uri.parse(url));

    var json =  convert.jsonDecode(response.body);

    var results = {
      "bounds_ne": json['routes'][0]['bounds']['northeast'],
      "bounds_sw": json['routes'][0]['bounds']['southwest'],
      "start_location": json['routes'][0]['legs']['0']['start_location'],
      "end_location": json['routes'][0]['legs']['0']['end_location'],
      "polyline": json['routes'][0]['overview_polyline']['points'],
      "polyline_decoded": PolylinePoints().decodePolyline(json['routes'][0]['overview_polyline']['points']),      
    };

    return results;
  }

  Future<dynamic>getPlaceDetails(LatLng coords, int radius) async{
    var lat = coords.latitude;
    var lng = coords.longitude;

    final String url ='https://maps.googleapis.com/maps/api/place/nearbysearch/json?&location=$lat.$lng&radius=$radius&key=$key';

   var response = await http.get(Uri.parse(url));

   var json = convert.jsonDecode(response.body);

   return json;
  }
  Future<dynamic> getMorePlaceDetails(String token) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?&pagetoken=$token&key=$key';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    return json;
  }
}