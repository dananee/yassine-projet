import 'package:admosttest/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  String number = "0657504857";

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
