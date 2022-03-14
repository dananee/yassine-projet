import 'package:admosttest/ads/src/multi_ads_factory.dart';
import 'package:admosttest/const.dart';
import 'package:admosttest/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    fetchAdsData();
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 1],
            colors: [
              Colors.teal,
              Color.fromARGB(255, 255, 214, 153),
            ],
          ),
        ),
        child: const Center(
          child: Text(
            "Welcome",
            style: TextStyle(
                fontSize: 80, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future<void> fetchAdsData() async {
    try {
      var url = Uri.parse(
          "https://drive.google.com/uc?export=download&id=1jmkulsq2jQj32a6CfBDycRATujmVdj8T");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data2 = json.decode(response.body);
        g_ads = MultiAds(response.body);
        await g_ads.init();
        await g_ads.loadAds();
        setState(() {
          Get.offAll(Home());
        });
      } else {
        await Future.delayed(const Duration(seconds: 2), () {
          debugPrint("YOU ARE NOT CONNECTED");
          setState(() {
            isLoading = false;
          });
        });
      }
    } catch (e) {
      await Future.delayed(const Duration(seconds: 2), () {
        debugPrint("YOU ARE NOT CONNECTED $e");
        setState(() {
          isLoading = false;
        });
      });
    }
  }
}
