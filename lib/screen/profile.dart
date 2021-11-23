import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:read_novel/models/user_model.dart';
import 'package:read_novel/service/database.dart';

import '../flutter_flow/flutter_flow_theme.dart';

import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'edit_profile.dart';

//หน้า Profile
class ProfileWidget extends StatefulWidget {
  ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  bool _loadingButton = false;
  bool? switchListTileValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Database db = Database.instance;
  var images;
  var username;
  var contact;

  @override
  Widget build(BuildContext context) {
    Stream<List<UserModel>> status = db.getStateUser();
    CollectionReference status2 =
        FirebaseFirestore.instance.collection('users');
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
              child: Text(
                'บัญชีผู้ใช้',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                ),
              ),
            ),
            // Container(
            //   height: 100.0,
            //   width: 100.0,
            //   child: FutureBuilder<DocumentSnapshot>(
            //     future: status2.doc('${_user!.uid}').get(),
            //     builder: (context, snapshot5) {
            //       if (snapshot5.hasError) {
            //         return Text("Something went wrong");
            //       }
            //       if (snapshot5.hasData) {
            //         print("snapshot5.hasData = ${snapshot5.hasData}");
            //         if (snapshot5.connectionState == ConnectionState.done) {
            //           Map<String, dynamic> data =
            //               snapshot5.data!.data() as Map<String, dynamic>;
            //           if (data['images'] != null) {
            //             return Text(
            //                 "Full Name: ${data['images']} ${data['id']}");
            //           }
            //         }
            //       }

            //       return Text("loading");
            //     },
            //   ),
            // ),

            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 40, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  StreamBuilder<List<UserModel>>(
                      stream: status,
                      builder: (context, snapshot) {
                        return FutureBuilder<DocumentSnapshot>(
                          future: status2.doc('${_user?.uid}').get(),
                          builder: (context, snapshot5) {
                            if (snapshot5.hasError) {
                              return Text("Something went wrong");
                            }
                            if (snapshot5.hasData) {
                              print("snapshot5.hasData = ${snapshot5.hasData}");
                              print(
                                  "snapshot5.connectionState == ConnectionState.done");
                              if (snapshot5.connectionState ==
                                  ConnectionState.done) {
                                Map<String, dynamic> data = snapshot5.data!
                                    .data() as Map<String, dynamic>;
                                this.images = data['images'];
                                this.username = data['userName'];
                                this.contact = data['contact'];
                                if (data['images'] != null) {
                                  print("data['images'] =  ${data['images']}");
                                  
                                  return CircleAvatar(
                                    radius: 45,
                                    backgroundImage: NetworkImage(
                                      "${data['images']}",
                                    ),
                                  );
                                } else {
                                  if (data['userName'] != null) {
                                    return CircleAvatar(
                                      radius: 45,
                                      child: Text(
                                        "${data['userName']}",
                                        style: TextStyle(fontSize: 45),
                                      ),
                                    );
                                  }
                                }
                                // return Text(
                                //     "Full Name: ${data['images']} ${data['id']}");

                              }
                            }

                            return CircularProgressIndicator();
                          },
                        );
                      }),
                  // แสดง ภาพของเรา

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'นามปากกา',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Color(0xFFD3D3D3),
                          ),
                        ),
                        StreamBuilder<List<UserModel>>(
                            stream: status,
                            builder: (context, snapshot) {
                              return FutureBuilder<DocumentSnapshot>(
                                  future: status2.doc('${_user?.uid}').get(),
                                  builder: (context, snapshot5) {
                                    if (snapshot5.hasError) {
                                      return Text("Something went wrong");
                                    }
                                    if (snapshot5.hasData) {
                                      print(
                                          "snapshot5.hasData = ${snapshot5.hasData}");
                                      print(
                                          "snapshot5.connectionState == ConnectionState.done");
                                      if (snapshot5.connectionState ==
                                          ConnectionState.done) {
                                        Map<String, dynamic> data =
                                            snapshot5.data!.data()
                                                as Map<String, dynamic>;
                                        if (data['userName'] != null) {
                                          return Text(
                                            "${data['userName']}",
                                            style: FlutterFlowTheme.bodyText1,
                                          );
                                        }
                                      }
                                    }
                                    return Text('กำลังโหลด');
                                  });
                              // // แสดง แสดงชื่อ
                              // return Text(
                              //   //เช็คว่าชื่อว null ไม่ เพื่อไม่ให้เเสดงค่า null เลยดักไว้
                              //   '',
                              //   style: FlutterFlowTheme.bodyText1,
                              // );
                              return Text('กำลังโหลด');
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Padding(
            //   padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
            //   child: SwitchListTile.adaptive(
            //     value: switchListTileValue ??= true,
            //     onChanged: (newValue) =>
            //         setState(() => switchListTileValue = newValue),
            //     title: Text(
            //       'เปิดโหมดกลางคืน',
            //       textAlign: TextAlign.start,
            //       style: FlutterFlowTheme.title3.override(
            //         fontFamily: 'Lexend Deca',
            //         color: Color(0xFF15212B),
            //         fontSize: 18,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //     activeColor: Color(0xFF80FFEE),
            //     activeTrackColor: Color(0xFF3B2DB6),
            //     dense: false,
            //     controlAffinity: ListTileControlAffinity.trailing,
            //     contentPadding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
            //   ),
            // ),
            InkWell(
              onTap: () async {
                // ไปยังหน้าแก้ไขโปรไฟล์
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditedProfileWidget(images: images,username: username,contact: contact,),
                  ),
                );
              },
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15, 1, 0, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'เเก้ไขโปรไฟล์',
                                                  style: FlutterFlowTheme
                                                      .subtitle1
                                                      .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF15212B),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 8, 0),
                                            child: Icon(
                                              Icons.chevron_right_outlined,
                                              color: Color(0xFF95A1AC),
                                              size: 24,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: FFButtonWidget(
                  onPressed: () {
                    //logout
                    FirebaseAuth.instance.signOut();
                  },
                  text: 'Logout',
                  options: FFButtonOptions(
                    width: 348,
                    height: 52,
                    color: Color(0xFF00DCA7),
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 12,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
