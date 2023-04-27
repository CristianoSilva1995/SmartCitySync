import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tutorial/location_service.dart';
import 'package:tutorial/model/ticket.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../login/login_widget.dart';
import '../storage_service.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _ticketRead = _firestore.collection('ticket');

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
  }

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

  static Stream<QuerySnapshot> readItems() {
    CollectionReference notesItemCollection =
        _ticketRead.doc().collection('ticket');

    return notesItemCollection.snapshots();
  }

  static final Marker _kLakeMarker = Marker(
    markerId: MarkerId('_kGooglePlex1'),
    infoWindow: InfoWindow(title: 'Test test test'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(51.509865, -0.128092),
    onTap: () {
      print('tap');
    },
  );
  Set<Marker> markers = Set();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF07397B),
        automaticallyImplyLeading: true,
        title: Text(
          'SmartCitySync',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: FlutterFlowTheme.of(context).title2Family,
                color: Colors.white,
                fontSize: 22,
                useGoogleFonts: GoogleFonts.asMap()
                    .containsKey(FlutterFlowTheme.of(context).title2Family),
              ),
        ),
        actions: [
          FFButtonWidget(
            onPressed: () async {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginWidget(),
                  ),
                );
              });
            },
            text: '',
            icon: Icon(
              Icons.logout,
              size: 15,
            ),
            options: FFButtonOptions(
              width: 50,
              height: 40,
              color: Color(0xFF07397B),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Container(),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: StreamBuilder(
          stream: _ticketRead.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              for (int i = 0; i < streamSnapshot.data!.docs.length; i++) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[i];
                Marker resMarker = new Marker(
                  markerId: MarkerId('marker' + i.toString()),
                  infoWindow: InfoWindow(
                      title: documentSnapshot['title'],
                      snippet: documentSnapshot['description']),
                  icon: BitmapDescriptor.defaultMarker,
                  position:
                      LatLng(documentSnapshot['lat'], documentSnapshot['lng']),
                  onTap: () {},
                );
                markers.add(resMarker);
              }
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _searchController,
                          textCapitalization: TextCapitalization.words,
                          decoration:
                              InputDecoration(hintText: 'Search by address'),
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
                    markers: markers,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }

  Stream<List<Ticket>> getTickets() => FirebaseFirestore.instance
      .collection('ticket')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Ticket.fromJson(doc.data())).toList());

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
