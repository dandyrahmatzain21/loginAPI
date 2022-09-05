import 'package:flutter/material.dart';
import 'package:survei_asia/models/login_response.dart';
import 'package:survei_asia/services/shared_service.dart';

import 'login.dart';

class Dashboard extends StatefulWidget {
  @override
  _Dashboard createState() => new _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  LoginResponse? data;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    LoginResponse? dataModel = await SharedService.loginDetails();
    setState( () {
      data = dataModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(16.0),
              child: Text(
                'ini dashboard data : ${data?.data?.Name}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              child: Center(
                child: OutlinedButton(
                  onPressed: () {
                    logout(context);
                  },
                  child: Text("Logout"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static void logout(BuildContext context) {
    SharedService.logout();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
  }
}
