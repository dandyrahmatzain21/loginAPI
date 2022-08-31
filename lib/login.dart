import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => new _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              "images/image1.png",
              width: 200,
              height: 70,
            ),
            Container(
              margin: const EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
              child: const Text(
                'Selamat Datang',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: const Text(
                'Masukkan email dan kata sandi Anda yang telah terdaftar',
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: const Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan Email Anda',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: const Text(
                'Kata Sandi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan Email Anda',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text("Masuk"),
                    onPressed: () {
                      // Aksi ketika button diklik
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