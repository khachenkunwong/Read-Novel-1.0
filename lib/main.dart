import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:read_novel/screen/login.dart';
import 'package:read_novel/screen/mainpage.dart';
import 'package:provider/provider.dart';
import 'service/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Last_Login(),
      ),
    );
  }
}

class Last_Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        // กำหนดเวลาให้แสดงหน้านี้
        duration: 2000,
        //ใส่ภาพ svg ตรงกลาง
        splash: SvgPicture.asset(
          // ภาพที่ ลิ้งตำแหน่ง
          'assets/images/menu_book_black_24dp_green.svg',
          //กำหนดขนาดภาพ
          width: 130,
          height: 130,
          fit: BoxFit.cover,
        ),
        //เมื่อเล่นหน้าที่เสร็จเเล้วไปหน้า login
        nextScreen: Login(),
        // กำหนดขนาดภาพ
        splashIconSize: 130.0,
        // animation ที่เล่นตนอเปิด app ตอนเเรก
        splashTransition: SplashTransition.fadeTransition,
        //กำหนดพื้นหลัง
        backgroundColor: Color(0xFF00DCA7));
  }
}


class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ประการตัวเเปล user เพื่อใช้เก็บค่าสถานะว่า login หรือยัง
    final user = context.watch<User?>();
    print(user);
    // ตังเงื่อนไขว่าถ้ายังไม่ login ก็ไม่สามารถไปหน้าอ่านนิยายได้
    if (user != null) {
      // ไปหน้าอ่านนิยาย
      return MainPageWidget();
    }
    // ไปหน้า login
    return LoginWidget();
  }
}
