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
String displayMarker = "";

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

  String downloadUrl = "";
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  TextEditingController _searchController = TextEditingController();

  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

  static const CameraPosition initialCamera = CameraPosition(
    target: LatLng(51.509865, -0.118092),
    zoom: 14.4746,
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
      body: Stack(
        children: [
          StreamBuilder(
            stream: _ticketRead.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                for (int i = 0; i < streamSnapshot.data!.docs.length; i++) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[i];
                  var newIcon = BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueAzure);

                  newIcon = updateMarkerIcon(documentSnapshot['status']);
                  displayMarker = documentSnapshot['status'];
                  Marker resMarker = new Marker(
                    markerId: MarkerId('marker' + i.toString()),
                    icon: newIcon,
                    position: LatLng(
                        documentSnapshot['lat'], documentSnapshot['lng']),
                    onTap: () async {
                      downloadUrl = await Storage()
                          .downloadURL(documentSnapshot['fileName']);
                      customInfoWindowController.addInfoWindow!(
                        SingleChildScrollView(
                          child: Container(
                            height: 300,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 300,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(downloadUrl),
                                      fit: BoxFit.fitWidth,
                                      filterQuality: FilterQuality.high,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 5),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 290,
                                        child: Text(
                                          documentSnapshot['title'],
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                          softWrap: true,
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 5),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 290,
                                        child: Text(
                                          documentSnapshot['description'],
                                          maxLines: 3,
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 5),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 290,
                                        child: Text(
                                          documentSnapshot['address'],
                                          maxLines: 3,
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 5),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 290,
                                        child: Text(
                                          "Status: " +
                                              documentSnapshot['status'],
                                          maxLines: 3,
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 5),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 290,
                                        child: Text(
                                          "Date: " + documentSnapshot['date'],
                                          maxLines: 3,
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        LatLng(
                          documentSnapshot['lat'],
                          documentSnapshot['lng'],
                        ),
                      );
                    },
                  );
                  if (displayMarker != 'Archive') {
                    markers.add(resMarker);
                  }
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
                    child: Stack(
                      children: [
                        GoogleMap(
                          onTap: (position) {
                            customInfoWindowController.hideInfoWindow!();
                          },
                          mapType: MapType.normal,
                          markers: markers,
                          initialCameraPosition: initialCamera,
                          onCameraMove: (position) {
                            customInfoWindowController.onCameraMove!();
                          },
                          onMapCreated: (GoogleMapController controller) async {
                            customInfoWindowController.googleMapController =
                                controller;
                            _controller.complete(controller);
                          },
                        ),
                        CustomInfoWindow(
                            controller: customInfoWindowController,
                            height: 200,
                            width: 300,
                            offset: 50)
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
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

  static BitmapDescriptor updateMarkerIcon(String status) {
    var icon;
    if (status == 'In Process') {
      icon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    } else if (status == 'In Progress') {
      icon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
    } else if (status == 'Urgent') {
      icon = BitmapDescriptor.defaultMarker;
    } else if (status == 'Completed') {
      icon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    }
    return icon;
  }
}
