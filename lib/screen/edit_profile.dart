import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:read_novel/models/user_model.dart';
import 'package:read_novel/service/database.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// หน้าแก้โปรไฟล์
class EditedProfileWidget extends StatefulWidget {
  var images;
  var username;
  var contact;
  EditedProfileWidget({Key? key, this.images, this.username, this.contact})
      : super(key: key);

  @override
  _EditedProfileWidgetState createState() => _EditedProfileWidgetState();
}

class _EditedProfileWidgetState extends State<EditedProfileWidget> {
  // เก็บนามปากา
  late TextEditingController textController1;

  // เก็บที่ติดต่อ
  late TextEditingController myBioController;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  // ตัดต่อกับ firebase
  Database db = Database.instance;

  //url รูปที่อัพโหลด
  String imageUrl = '';
  List aa = [''];
  File? image;
  var image1;
  var image2;

  //เลือกรูปภาพใน gallery
  Future pickImage() async {
    try {
      //นำภาพที่เลือกมาเก็บไว้ใน image
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      //เช็คว่าถ้าไม่ได้เลือกก็ออก
      if (image == null) return;
      // นำ path image ที่เราเลือกไปเก็บไว้ใน image1 เพื่อเอาไปใช้ในส่วนของการบันทึก
      this.image1 = image.path;
      // เอาภาพที่เลือกไว้มาเก็บไว้ใน image2 เพื่อเอาไปใช้ในส่วนของการบันทึก
      this.image2 = image;
      //แปลงเป็น File
      final imageTemporary = File(image.path);
      // เอาไปเก็บไว้ใน image เเล้วอัพเดดน่าเเล้วภาพจะขึ้น
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    textController1 = TextEditingController(text: "${widget.username}");
    myBioController = TextEditingController(text: "${widget.contact}");
    print("widget.username = ${widget.username}");
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        // ปุ่มกดย้อนกลับ
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: Text(
          'Edit Profile',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF14181B),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                      child: Container(
                        width: 90,
                        height: 90,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        // ภาพเปลียนตามที่เลือก
                        child: (image != null)
                            ? Image.file(image!)
                            : CircleAvatar(
                                radius: 45,
                                child: Image.network(
                                  '${widget.images}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //ปุ่มเปลียนภาพ
                    FFButtonWidget(
                      onPressed: () => pickImage(),
                      text: 'Change Photo',
                      options: FFButtonOptions(
                        width: 130,
                        height: 40,
                        color: Colors.white,
                        textStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF39D2C0),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        elevation: 2,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 8,
                      ),
                    )
                  ],
                ),
              ),
              // นามปากกา
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                child: TextFormField(
                  controller: textController1,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'นามปากกา',
                    labelStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFF95A1AC),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    hintStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFF95A1AC),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFDBE2E7),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFDBE2E7),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                  ),
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF14181B),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              // ติดต่อ
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                child: TextFormField(
                  controller: myBioController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'ติดต่อ',
                    labelStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFF95A1AC),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    hintStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFF95A1AC),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFDBE2E7),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFDBE2E7),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                  ),
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF14181B),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 8,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0.05),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                  // ปุ่มบันทึการเปลียนเเปลง
                  child: FFButtonWidget(
                    onPressed: () async {
                      print('image ${image}');
                      // เช็คว่ารูปเลือกหรือยัง
                      if (image != null) {
                        uploadImage(
                          gallery: image1,
                          image: image2,
                        );
                      }
                      print('textController1.text ${textController1.text}');
                      // เช็คว่าค่า ว่างไหม
                      if (textController1.text != null) {
                        // เช็คว่ากรณีที่ค่าไม่ได้ว่าง เเต่ไม่ได้พิมพ์
                        if (textController1.text.length > 0) {
                          // ทำการอัพเดดชื่อ
                          db.updateNameUser(
                              users: UserModel(userName: textController1.text));
                        }
                      }

                      print(
                          'myBioController.text.length ${myBioController.text.length}');
                      print('myBioController.text ${myBioController.text}');
                      // เช็คว่าค่า ว่างไหม
                      if (myBioController.text != null) {
                        // เช็คว่ากรณีที่ค่าไม่ได้ว่าง เเต่ไม่ได้พิมพ์
                        if (myBioController.text.length > 0) {
                          // ทำการอัพเดดที่ ติดต่อ
                          db.updateContactUser(
                              users: UserModel(contact: myBioController.text));
                        }
                      }
                      //ย้อนกลับหลังจากบันทึกเเล้ว
                      Navigator.pop(context);
                    },
                    text: 'บันทึกการเปลี่ยนเเปลง',
                    options: FFButtonOptions(
                      width: 340,
                      height: 60,
                      color: Color(0xFF39D2C0),
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      elevation: 2,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 8,
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

  // อัพโหลด ภาพลงใน Storage ใน firebase
  uploadImage({gallery, image, name, contact}) async {
    // กำหนด _storage ให้เก็บ FirebaseStorage (สโตเลท)
    final _storage = FirebaseStorage.instance;
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;

    // //Check Permissions
    // await Permission.photos.request();

    // var permissionStatus = await Permission.photos.status;

    // if (permissionStatus.isGranted) {
    //   //Select Image
    //   image = await _picker.getImage(source: ImageSource.gallery);
    // เอาpath ที่เราเลือกจากเครื่องมาเเปลงเป็น File เพื่อเอาไปอัพโหลดลงใน Storage ใน Firebase
    var file = File(gallery);
    // เช็คว่ามีภาพที่เลือกไหม
    if (image != null) {
      //Upload to Firebase
      var snapshot =
          await _storage.ref().child('${_user?.uid}/Myimage').putFile(file);
      // เอาลิ้ง url จากภาพที่เราเก็บไว้โดยโคตบันทัด 344 ออกมากเก็บไว้ใน downloadUrl
      var downloadUrl = await snapshot.ref.getDownloadURL();
      print("dfdffdf ${downloadUrl}");
      // if (mounted) {
      //   setState(() {
      //     imageUrl = downloadUrl;
      //   });
      // }
      // if (name == null && contact == null) {
      //   db.updateStateUser(users: UserModel(images: downloadUrl));
      // }
      // เเล้วเอา url ภาพไปใส่ที่ image ของ firestore ของ user

      db.updateStateUser(users: UserModel(images: downloadUrl));
    } else {
      print('ไม่มีรูปภาพ');
    }
  }
}
