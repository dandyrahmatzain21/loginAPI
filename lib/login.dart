import 'package:flutter/material.dart';
import 'package:survei_asia/res/custom_colors.dart';
import 'package:survei_asia/utils/authentication.dart';
import 'package:survei_asia/widgets/google_sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      height: 4,
                      thickness: 1,
                      indent: 2,
                      endIndent: 2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    child: Text(
                      'Atau masuk menggunakan',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      height: 4,
                      thickness: 1,
                      indent: 2,
                      endIndent: 2,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: Authentication.initializeFirebase(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error initializing Firebase');
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      return GoogleSignInButton();
                    }
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        CustomColors.diamondOrange,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
