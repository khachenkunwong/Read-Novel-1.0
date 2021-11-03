import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:read_novel/models/user_model.dart';
import 'package:read_novel/screen/mainpage.dart';
import 'package:read_novel/service/database.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'register.dart';

final kFirebaseAnalytics = FirebaseAnalytics();
//หน้า login
class LoginWidget extends StatefulWidget {
  LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  // เก็บ email ที่พิมพ์ไป
  TextEditingController? textController1;
  // เก็บ password ที่พิมพ์ไป
  TextEditingController? textController2;
  // เก็บ state ของการเเสดง password และซ้อน password
  // ใช้ late เพื่อบอก dart ว่าตัวนี้ไม่ใช่ค่า null นะเพราะจะมีค่าให้เก็บในอนาคต
  late bool passwordVisibility;
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
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF00DCA7),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: SvgPicture.asset(
                    'assets/images/menu_book_black_24dp_green.svg',
                    width: 130,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Text(
                    'Writer Novel',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: FlutterFlowTheme.tertiaryColor,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 30, 0, 0),
                  child: Text(
                    'Email',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: FlutterFlowTheme.tertiaryColor,
                      fontSize: 18,
                    ),
                  ),
                ),
                // ที่พิมพ์ email
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: TextFormField(
                    controller: textController1,
                    obscureText: false,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFBFFFF7),
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                    ),
                    style: FlutterFlowTheme.bodyText1,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Text(
                    'Password',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: FlutterFlowTheme.tertiaryColor,
                      fontSize: 18,
                    ),
                  ),
                ),
                // ที่พิมพ์ password
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: TextFormField(
                    controller: textController2,
                    // ซ้อนpassword หรือไหม input เป็น true false
                    obscureText: !passwordVisibility,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFBFFFF7),
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                      ),
                      //กำให้มี icon รุปตาให้สามารถกดได้โดยใช้ InkWell
                      suffixIcon: InkWell(
                        //เมื่อกดเเล้วจะสามารถเปลียนเป็นค่า passwordVisibility ได้เพื่อเปิดปิดตตัวซ่อน
                        //ดัพเดดหน้าจอ ด้วย setState เปลียน icon ตา
                        onTap: () => setState(
                          () => passwordVisibility = !passwordVisibility,
                        ),
                        child: Icon(
                          // กำหนดให้ icon เปลียนเมื่อ passwordVisibility เปลียน
                          passwordVisibility
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Color(0xFF00DCA7),
                          size: 22,
                        ),
                      ),
                    ),
                    style: FlutterFlowTheme.bodyText1,
                    textAlign: TextAlign.start,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Field is required';
                      }

                      return null;
                    },
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    // ปุ่ม login  class FFButtonWidget
                    // class FFButtonWidget สร้างขึ้นมาเองเพื่อใช้กับ code ที่เอามาจาก flutter flow
                    child: FFButtonWidget(
                      onPressed: () {
                        // //
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => MainPageWidget(),
                        //   ),
                        // );

                        // setState(() => _loadingButton1 = true);
                        // try {
                        //   await Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) =>
                        //           NavBarPage(initialPage: 'main_page'),
                        //     ),
                        //   );
                        // } finally {
                        //   setState(() => _loadingButton1 = false);
                        // }
                      },
                      text: 'Login',
                      options: FFButtonOptions(
                        width: 362,
                        height: 45,
                        color: Colors.white,
                        textStyle: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF00DCA7),
                          fontSize: 18,
                        ),
                        elevation: 2,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 12,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.9, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Text(
                      'Forget password?',
                      textAlign: TextAlign.end,
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.tertiaryColor,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Text(
                      '----------------------or----------------------',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
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
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
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
                                child: Image.network(
                                  'https://i0.wp.com/nanophorm.com/wp-content/uploads/2018/04/google-logo-icon-PNG-Transparent-Background.png?w=1000&ssl=1',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.tertiaryColor,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          // หน้า login
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterWidget(),
                            ),
                          );
                        },
                        child: Text(
                          ' Register',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

// Sign in with Google.
  Future<firebase_auth.User?> _googleSignIn() async {
    final curUser = _user ?? _auth.currentUser;
    if (curUser != null && !curUser.isAnonymous) {
      return curUser;
    }
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser!.authentication;
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Note: user.providerData[0].photoUrl == googleUser.photoUrl.
    final user = (await _auth.signInWithCredential(credential)).user;
    print('user = 1111111 $user');
    print('กำลังเข้า store');
    try {
      await db.setUser(
        //ใช้ setUser เพื่อเพิ่มหรือแก้ไขเอกสารไปยังฐานข้อมูล Cloud Firestore
        // ทำการ ใส่ข้อมูลเเละ ฟิวทั้ง 5 ตัวลงไปยัง cloud firestore
        users: UserModel(
          id: user!.uid,
          userName: '${user.displayName}',
          state: false,
          images: user.photoURL!,
          contact: '',
        ),
      );
    } catch (err) {
      print(err);
    }
    // kFirebaseAnalytics.logLogin();
    // if (mounted) {
    //   setState(() => _user = user);
    //   print('mouted user = $mounted');
    // }

    return user;
  }
}
