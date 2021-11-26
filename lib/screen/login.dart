import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:read_novel/models/user_model.dart';
import 'package:read_novel/service/database.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

final kFirebaseAnalytics = FirebaseAnalytics();

//หน้า login
class LoginWidget extends StatefulWidget {
  LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  // ใช้เพื่อจะเรียกดู  uid ของ email ของคนที่สมัคร
  final _auth = firebase_auth.FirebaseAuth.instance;
  // เรียกใช้ตัวติดต่อกับ firebase database เป็น class ที่เราสร้างไว้
  Database db = Database.instance;
  // ใช้เพื่อจะเรียกดู  uid ของ email ของคนที่สมัคร
  firebase_auth.User? _user;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //เก็บ state ของปุ่มเมื่อเรากดเเล้วมันจะเป็นสีเท่าเมื่อเราโหลดเสร็จเเล้วถึงจะกลับมากดได้ใหม่
  // เพื่อป้องกันการกดหลายครั้ง
  bool _busy = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF00DCA7),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/menu_book_black_24dp_green.svg',
              width: 130,
              height: 130,
              fit: BoxFit.cover,
            ),
            Text(
              'Read Novel',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
                color: FlutterFlowTheme.tertiaryColor,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 120, 0, 0),
              child: InkWell(
                onTap: () async {
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         NavBarPage(initialPage: 'main_page'),
                  //   ),
                  // );
                },
                child: Container(
                  width: 362,
                  height: 54,
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Login with Facebook',
                            options: FFButtonOptions(
                              width: 362,
                              height: 54,
                              color: Color(0xFF1877F2),
                              textStyle: GoogleFonts.getFont(
                                'Roboto',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                              elevation: 4,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                              borderRadius: 30,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.98, -0.33),
                        child: Container(
                          width: 50,
                          height: 50,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/facebook.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
              child: InkWell(
                // _busy คือตัวที่เอาไว้ป้องกันการกดซ้ำ
                // มีปุ่ม 2 อันเพื่อ กันการกดพลาด
                onTap: _busy
                    ? null
                    : () async {
                        //กำ _busy เพื่อไม่ให้กดซ้ำเมื่อกดเเล้ว
                        setState(() => _busy = true);
                        // login หรือ สมัคร โดย google
                        await _googleSignIn();

                        // setState(() => _busy = false);
                        //ตั้งเงื่อนไข่เพื่อป้องกัน error เกียวกับ dispose
                        if (mounted) {
                          // กำหนด _busy มาเพื่อให้กลับมากดได้
                          setState(() => _busy = false);
                          print('กำลังทำงาน = $mounted');
                        }
                        print('_busy = $mounted');
                      },
                child: SizedBox(
                  width: 362,
                  height: 54,
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: SizedBox(
                          width: 362,
                          height: 54,
                          // ปุ่มกด Login with Google
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              elevation: 4,
                              side: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            // _busy คือตัวที่เอาไว้ป้องกันการกดซ้ำ
                            onPressed: _busy
                                ? null
                                : () async {
                                    //กำ _busy เพื่อไม่ให้กดซ้ำเมื่อกดเเล้ว
                                    setState(() => _busy = true);
                                    // login หรือ สมัคร โดย google

                                    await _googleSignIn();

                                    //ตั้งเงื่อนไข่เพื่อป้องกัน error เกียวกับ dispose
                                    if (mounted) {
                                      // กำหนด _busy มาเพื่อให้กลับมากดได้
                                      setState(() => _busy = false);
                                      print('กำลังทำงาน = $mounted');
                                    }
                                    print('_busy = $mounted');
                                  },
                            child: Text(
                              'Login with Google',
                              style: GoogleFonts.getFont(
                                'Roboto',
                                color: Color(0xFF606060),
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.97, -0.44),
                        child: Container(
                          width: 50,
                          height: 50,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          // ภาพ google
                          child: Image.asset(
                            'assets/images/google.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Sign in with Google.
  Future<firebase_auth.User?> _googleSignIn() async {
    // final curUser = _user ?? _auth.currentUser;
    // if (curUser != null && !curUser.isAnonymous) {
    //   return curUser;
    // }
    // ใช้ try เพื่อดัก error เมื่อกดกลับเเต่ก็ต้องเข้าเเก้ใน file platform_channel.dart เพื่อดัก error
    try {
      print('dffdfdfdfdfdfdfdfdfdfdfdfdf');
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser!.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Note: user.providerData[0].photoUrl == googleUser.photoUrl.
      final user = (await _auth.signInWithCredential(credential)).user;
      print('กำลังเข้า store');
      // นำข้อมูลใน firestore มาเเสดง
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      FirebaseAuth.instance.userChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      });

      // เช็คว่าผู้ใช้งานมีอยู่ในระบบหรือไม่ เพื่อไม่ให้เขียนข้อมูลทับ profile ที่มีอยู่แล้ว
      if (userData.data() == null) {
        await db.setUser(
          //ใช้ setUser เพื่อเพิ่มหรือแก้ไขเอกสารไปยังฐานข้อมูล Cloud Firestore
          // ทำการ ใส่ข้อมูลเเละ ฟิวทั้ง 5 ตัวลงไปยัง cloud firestore
          users: UserModel(
            id: user.uid,
            userName: '${user.displayName}',
            state: false,
            images: user.photoURL!,
            contact: '',
          ),
        );
      }
      return user;
    } catch (e) {
      print(e);
    }

    // kFirebaseAnalytics.logLogin();
    // if (mounted) {
    //   setState(() => _user = user);
    //   print('mouted user = $mounted');
    // }
  }
}
