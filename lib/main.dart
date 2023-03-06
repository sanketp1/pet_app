import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:pet_app/app/constants/appTheme.dart';
import 'package:pet_app/app/constants/colors.dart';
import 'package:pet_app/app/constants/fonts.dart';
import 'package:pet_app/app/modules/home/views/home_view.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Pet App",
      theme: AppTheme.lightTheme,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.splashScreenColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/paw-icon.png"),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "MyPets",
                  style: AppFonts.primaryFont.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.white),
                )
              ],
            ),
          ),
          Positioned(
              top: 20, left: 0, child: Image.asset("assets/Ellipse1.png")),
          Positioned(
              bottom: 50, left: 0, child: Image.asset("assets/Ellipse2.png")),
          Positioned(
              bottom: 0, right: 0, child: Image.asset("assets/Ellipse3.png")),
        ],
      ),
    );
  }
}
