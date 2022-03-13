import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'constente.dart';

// ignore: must_be_immutable
class Dettailes extends StatefulWidget {
  String decs;
  String title;
  Dettailes({Key? key, required this.decs, required this.title})
      : super(key: key);

  @override
  _DettailesState createState() => _DettailesState();
}

class _DettailesState extends State<Dettailes>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  void initState() {
    Constente.banner = AdmobBanner(
        adUnitId: Constente.bannerarticlepage(),
        adSize: AdmobBannerSize.BANNER);
    Constente.admobInterstitial = AdmobInterstitial(
        nonPersonalizedAds: true,
        adUnitId: Constente.getInterstitialAdUnitId(),
        listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
          if (event == AdmobAdEvent.loaded) {
            Constente.admobInterstitial.show();
          }
        });
    Constente.admobInterstitial.load();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
            )),
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView(physics: const BouncingScrollPhysics(), children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Html(data: widget.decs),
        ),
      ]),
      bottomNavigationBar: Container(
        height: 70,
        child: Constente.banner,
      ),
    );
  }
}
