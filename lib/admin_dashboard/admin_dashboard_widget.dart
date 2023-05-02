import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../login/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/Ticket.dart';
import '../storage_service.dart';

class AdminDashboardWidget extends StatefulWidget {
  const AdminDashboardWidget({Key? key}) : super(key: key);

  @override
  _AdminDashboardWidgetState createState() => _AdminDashboardWidgetState();
}

class _AdminDashboardWidgetState extends State<AdminDashboardWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String downloadUrl = "";
  String selectedStatus = "";
  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  List _ticketStatus = [
    "In Process",
    "In Progress",
    "Urgent",
    "Completed",
    "Archive"
  ];
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _ticketRead = _firestore.collection('ticket');

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
            text: 'Button',
            icon: Icon(
              Icons.login,
              size: 15,
            ),
            options: FFButtonOptions(
              width: 50,
              height: 40,
              color: Color(0x000849A0),
              textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: FlutterFlowTheme.of(context).subtitle2Family,
                    color: Colors.white,
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                        FlutterFlowTheme.of(context).subtitle2Family),
                  ),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
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
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0, -0.97),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(15, 20, 0, 30),
                          child: Text(
                            'Admin Dashboard',
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyText1Family,
                                  fontSize: 16,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyText1Family),
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 0),
                          child: Text(
                            'Pending tickets',
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyText1Family,
                                  fontSize: 16,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyText1Family),
                                ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: SizedBox(
                            width: 300,
                            height: 550,
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 15, 15, 0),
                              child: StreamBuilder(
                                stream: _ticketRead.snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot>
                                        streamSnapshot) {
                                  if (streamSnapshot.hasError) {
                                    return Text('Something went wrong');
                                  }
                                  if (streamSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  }

                                  return ListView.builder(
                                    itemCount: streamSnapshot.data!.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final DocumentSnapshot documentSnapshot =
                                          streamSnapshot.data!.docs[index];

                                      selectedStatus =
                                          documentSnapshot['status'];
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          children: [
                                            Image.network(
                                              documentSnapshot['filePath'],
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 160,
                                                    child: Text(
                                                      documentSnapshot['title'],
                                                      softWrap: true,
                                                      maxLines: 3,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: SizedBox(
                                                      width: 160,
                                                      child: Text(
                                                        documentSnapshot[
                                                            'description'],
                                                        softWrap: true,
                                                        maxLines: 3,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: SizedBox(
                                                      width: 160,
                                                      child: Text(
                                                        documentSnapshot[
                                                            'address'],
                                                        softWrap: true,
                                                        maxLines: 3,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: SizedBox(
                                                      width: 160,
                                                      child: Text(
                                                        documentSnapshot[
                                                            'date'],
                                                        softWrap: true,
                                                        maxLines: 3,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: SizedBox(
                                                      width: 160,
                                                      child: DropdownButton(
                                                        value: selectedStatus,
                                                        items: _ticketStatus
                                                            .map((e) =>
                                                                DropdownMenuItem(
                                                                  value: e,
                                                                  child:
                                                                      Text(e),
                                                                  key:
                                                                      UniqueKey(), // add a unique identifier to each item
                                                                ))
                                                            .toList(),
                                                        onChanged: (val) {
                                                          setState(() {
                                                            selectedStatus =
                                                                val as String;
                                                            final docTicket =
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'ticket')
                                                                    .doc(documentSnapshot[
                                                                        'uid']);
                                                            docTicket.update({
                                                              'status':
                                                                  selectedStatus
                                                            });
                                                            print(
                                                                selectedStatus);
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stream<List<Ticket>> getTickets() => FirebaseFirestore.instance
      .collection('ticket')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Ticket.fromJson(doc.data())).toList());
}
