import 'package:admosttest/ads/src/widgets/custom_banner.dart';
import 'package:admosttest/const.dart';
import 'package:admosttest/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dattailes.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text("App Name"),
        centerTitle: true,
      ),
      body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: data.length,
          separatorBuilder: (context, index) => const Divider(
                thickness: 0.5,
                color: Color.fromARGB(255, 197, 197, 197),
              ),
          itemBuilder: (context, index) {
            final item = data[index];
            return Column(
              children: [
                ListTile(
                  leading: item.icon,
                  title: Text(
                    item.title,
                    style: const TextStyle(color: Colors.blue),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16.0,
                    color: Color.fromARGB(255, 197, 197, 197),
                  ),
                  onTap: () {
                    g_ads.interInstance.showInterstitialAd();
                    Get.to(() => Dettailes(),
                        arguments: {
                          "title": item.title,
                          "desc": item.dec,
                        },
                        transition: Transition.rightToLeftWithFade);
                  },
                ),
              ],
            );
          }),
      bottomNavigationBar: SizedBox(
        height: 70,
        // child: CustomBanner(key: UniqueKey(), ads: g_ads.bannerInstance),
      ),
    );
  }
}
