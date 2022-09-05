import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:survei_asia/register.dart';
import 'package:survei_asia/res/custom_colors.dart';
import 'package:survei_asia/services/api_service.dart';
import 'package:survei_asia/utils/authentication.dart';
import 'package:survei_asia/widgets/facebook_sign_in_button.dart';
import 'package:survei_asia/widgets/google_sign_in_button.dart';

import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(children: [
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextField(
            controller: emailController,
            decoration: const InputDecoration(
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextField(
            obscureText: true,
            controller: passwordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Masukkan Kata Sandi Anda',
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
                  login();
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FutureBuilder(
              future: Authentication.initializeFirebase(context: context),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Error initializing Firebase');
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
            const FacebookSignInButton()
          ],
        ),
        SizedBox(height: 20.0),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Belum punya akun?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()));
                },
                child: Text(
                  " Daftar",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        )
      ]),
    ));
  }

  Future<void> login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var email = emailController.text;
      var password = passwordController.text;

      print("{ email : $email \n password : $password}");

      APIService.login(email, password).then((response) => {
            print(response),
            if (response)
              {
                //valid credential
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                    (route) => false)
              }
            else
              {
                //invalid credential
                CoolAlert.show(
                  context: context,
                  title: "Login Error",
                  type: CoolAlertType.error,
                  text: "Invalid Credentials",
                )
              }
          });
    } else {
      // field blank
      CoolAlert.show(
        context: context,
        title: "Field Blank",
        type: CoolAlertType.error,
        text: "Please enter your email & password!",
      );
    }
  }
}
