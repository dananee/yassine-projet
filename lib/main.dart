import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:admosttest/home.dart';
import 'package:flutter/material.dart';

void main() async {
  String number = "0657504857";
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  if (Platform.isIOS) {
    await Admob.requestTrackingAuthorization();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
