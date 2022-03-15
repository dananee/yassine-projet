import 'package:admosttest/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Dettailes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
            )),
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Text(Get.arguments['title']),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            g_ads.nativeInstance.getNativeAdWidget(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Html(data: Get.arguments['desc']),
            ),
          ],
        ),
      ),
    );
  }
}
