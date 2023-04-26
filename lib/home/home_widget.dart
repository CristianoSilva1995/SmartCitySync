import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tutorial/location_service.dart';
import '../storage_service.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  TextEditingController _searchController = TextEditingController();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(51.509865, -0.118092),
    zoom: 14.4746,
  );
  static final Marker _kGooglePlexMarker = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Test test'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(51.509865, -0.118092),
  );

  static final Marker _kLakeMarker = Marker(
    markerId: MarkerId('_kGooglePlex1'),
    infoWindow: InfoWindow(title: 'Test test test'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(51.509865, -0.128092),
    onTap: () {
      print('tap');
    },
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('SmartCitySync'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _searchController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(hintText: 'Search by address'),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    print(_searchController.text);
                    var place = await LocationService()
                        .getPlace(_searchController.text);
                    _goToPlace(place);
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: {_kGooglePlexMarker, _kLakeMarker},
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 14),
      ),
    );
  }
}
