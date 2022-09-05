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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            //Image
            Image.asset(
              "images/image1.png",
              width: 200,
              height: 70,
            ),

            //Text
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

            //Text
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

            //FieldEmail
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  RegExp regex = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                    if (value!.isEmpty) {
                        return "Email Tidak Boleh Kosong";
                      } else if (!regex.hasMatch(value!)) {
                        return "Tolong Isi Email Yang Valid";
                      }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan Email Anda',
                ),
              ),
            ),

            //FieldPassword
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
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password Tidak Boleh Kosong";
                    }else if (value!.length < 6) {
                      return "Password Tidak Boleh Kurang Dari 6";
                    }
                    return null;
                  },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan Kata Sandi Anda',
                ),
              ),
            ),

            //ButtonMasuk
            Container(
              margin: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text("Masuk"),
                    onPressed: () {
                      // Aksi ketika button diklik
                      checkValidation(_formKey);
                      login();
                    },
                  ),
                ],
              ),
            ),

            //Text
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
            
            //ThirdPartySign
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

            //ButtonRegister
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
          ]
        ),
      ),
    );
  }

  Future<void> login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var email = emailController.text;
      var password = passwordController.text;

      RegExp regex = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
      
      //ValidateSnackBar
      if(password.isEmpty) {
        ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Password Tidak Boleh Kosong")));
        return;
      }else if(password.length <6) {
        ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Password Tidak Boleh Kurang Dari 6")));
        return;
      }else if (email.isEmpty) {
        ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Email Tidak Boleh Kosong")));
        return;
      }else if (!regex.hasMatch(email)) {
        ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Isi Email Dengan Valid")));
        return;
      }else if (password.isEmpty) {
        ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Nama Tidak Boleh Kosong")));
        return;
      }

      print("{ email : $email \n password : $password}");

      //ApiService
      APIService.login(email, password).then((response) => {
        print(response),
        if (response){
          //valid credential
          Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
          (route) => false
          )
        }else{
          //invalid credential
          ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email / Password Salah")))
        }});
    }else {
      // field blank      
      ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text("Isi Form Dengan Benar")));
    }
  }

  //CekValidasi
  checkValidation(GlobalKey<FormState> _formKey){
    if (_formKey.currentState!.validate()){
      print('Validated');
      int aaaaaa = 1;
    }else{
      print('Not Validated');
    }
  }
}
