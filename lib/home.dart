import 'package:admob_flutter/admob_flutter.dart';
import 'package:admosttest/data.dart';
import 'package:flutter/material.dart';

import 'constente.dart';
import 'dattailes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  void initState() {
    Constente.banner = AdmobBanner(
      adSize: AdmobBannerSize.BANNER,
      adUnitId: Constente.bannerhomepage(),
    );
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text("App Name"),
        centerTitle: true,
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    leading: item.icon,
                    title: Text(
                      item.title,
                      style: const TextStyle(color: Colors.blue),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {
                      Navigator.push(context, PageRouteBuilder<Offset>(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        final tween = Tween(begin: begin, end: end);
                        final offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                            position: offsetAnimation,
                            child: Dettailes(
                              decs: item.dec,
                              title: item.title,
                            ));
                      }));
                    },
                  ),
                  const Divider()
                ],
              ),
            );
          }),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Constente.banner,
      ),
    );
  }
}
