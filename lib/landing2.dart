import 'dart:async';
import 'package:flutter/material.dart';
import './dashboard.dart';
import 'login.dart';

class LandingPage2 extends StatefulWidget {
  @override
  _LandingPageState2 createState() => new _LandingPageState2();
}

class _LandingPageState2 extends State<LandingPage2> {
  @override
  void initState() {
    super.initState();
    // startLaunching();
  }
  startLaunching() async {
    var duration = const Duration(seconds: 5);
    return new Timer(duration, () {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_) {
        return new Dashboard() ;
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/image1.png",
              width: 200,
              height: 70,
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: const Text(
                'Isi survey dan dapatkan hadiahnya',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: const Text(
                'Kumpulkan poin dengan cara gabung ke aplikasi dan mengisi survey sesuai minat anda.',
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text("Gabung Sekarang"),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}