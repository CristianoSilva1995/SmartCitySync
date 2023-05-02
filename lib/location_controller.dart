import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
// ignore: implementation_imports

class LocationController extends GetxController {
  Placemark _pickPlaceMark = Placemark();
  Placemark get pickPlaceMark => _pickPlaceMark;

  // Future<List<Prediction>> searchLocation(
  //     BuildContext context, String text) async {
  //   if (text != null && text.isNotEmpty) {
  //     http.Response response = await getLocationData(text);
  //     var data = jsonDecode(response.body.toString());
  //     print("my status is " + data["status"]);
  //     if (data['status'] == 'OK') {
  //       _predictionList = [];
  //       data['predictions'].forEach((prediction) =>
  //           _predictionList.add(Prediction.fromJson(prediction)));
  //     } else {
  //       // ApiChecker.checkApi(response);
  //     }
  //   }
  //   return _predictionList;
  // }
}
