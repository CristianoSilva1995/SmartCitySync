import 'package:firebase_auth/firebase_auth.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../login/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 30),
                      child: Text(
                        'Your Profile',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyText1Family,
                              fontSize: 16,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyText1Family),
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 30),
                      child: Text(
                        'All available tickets',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyText1Family,
                              fontSize: 16,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyText1Family),
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: ListTile(
                        title: Text(
                          'Ticket Title',
                          style: FlutterFlowTheme.of(context).title3,
                        ),
                        subtitle: Text(
                          'Current status: ',
                          style: FlutterFlowTheme.of(context).subtitle2,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF303030),
                          size: 20,
                        ),
                        tileColor: Color(0xFFF5F5F5),
                        dense: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: ListTile(
                        title: Text(
                          'Ticket Title',
                          style: FlutterFlowTheme.of(context).title3,
                        ),
                        subtitle: Text(
                          'Current status: ',
                          style: FlutterFlowTheme.of(context).subtitle2,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF303030),
                          size: 20,
                        ),
                        tileColor: Color(0xFFF5F5F5),
                        dense: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: ListTile(
                        title: Text(
                          'Ticket Title',
                          style: FlutterFlowTheme.of(context).title3,
                        ),
                        subtitle: Text(
                          'Current status: ',
                          style: FlutterFlowTheme.of(context).subtitle2,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF303030),
                          size: 20,
                        ),
                        tileColor: Color(0xFFF5F5F5),
                        dense: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: ListTile(
                        title: Text(
                          'Ticket Title',
                          style: FlutterFlowTheme.of(context).title3,
                        ),
                        subtitle: Text(
                          'Current status: ',
                          style: FlutterFlowTheme.of(context).subtitle2,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF303030),
                          size: 20,
                        ),
                        tileColor: Color(0xFFF5F5F5),
                        dense: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: ListTile(
                        title: Text(
                          'Ticket Title',
                          style: FlutterFlowTheme.of(context).title3,
                        ),
                        subtitle: Text(
                          'Current status: ',
                          style: FlutterFlowTheme.of(context).subtitle2,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF303030),
                          size: 20,
                        ),
                        tileColor: Color(0xFFF5F5F5),
                        dense: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: ListTile(
                        title: Text(
                          'Ticket Title',
                          style: FlutterFlowTheme.of(context).title3,
                        ),
                        subtitle: Text(
                          'Current status: ',
                          style: FlutterFlowTheme.of(context).subtitle2,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF303030),
                          size: 20,
                        ),
                        tileColor: Color(0xFFF5F5F5),
                        dense: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: ListTile(
                        title: Text(
                          'Ticket Title',
                          style: FlutterFlowTheme.of(context).title3,
                        ),
                        subtitle: Text(
                          'Current status: ',
                          style: FlutterFlowTheme.of(context).subtitle2,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF303030),
                          size: 20,
                        ),
                        tileColor: Color(0xFFF5F5F5),
                        dense: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
