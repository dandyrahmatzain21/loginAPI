import 'package:flutter/material.dart';
import 'package:survei_asia/models/login_response.dart';
import 'package:survei_asia/services/shared_service.dart';
import 'dashboard.dart';
import 'login.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    // checkLogin();
  }

  checkLogin() async {
    WidgetsFlutterBinding.ensureInitialized();
    bool _isLoggedIn = await SharedService.isLoggedIn();
    LoginResponse? data = await SharedService.loginDetails();
    if (_isLoggedIn) {
      print("Token LoggedIn : ${data?.data?.Token}");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
              (route) => false);
    }
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
                'SurveyAsia platform survey terpercaya',
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