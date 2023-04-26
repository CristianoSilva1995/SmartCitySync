import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class LocationService {
  final String key = 'AIzaSyCIvkiPzeUfOvJNg7H1us8-rKld2e5Saas';

  Future<http.Response> getLocationData(String text) async {
    http.Response response;

    response = await http.get(
      Uri.parse(
          "http://mvs.bslmeiyu.com/api/v1/config/places-api-autocomplete?search_text=$text"),
      headers: {"Context-Type": "application/json"},
    );

    print(convert.jsonDecode(response.body));
    return response;
  }

  Future<String> getPlaceID(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var placeId = json['candidates'][0]['place_id'] as String;
    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    final placeId = await getPlaceID(input);
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;
    print(results);
    return results;
  }
}
