import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:survei_asia/login.dart';
import 'package:survei_asia/services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var namaController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

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
            'Silakan mendaftarkan akun anda untuk melanjutkan',
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16.0),
          child: const Text(
            'Nama',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextField(
            controller: namaController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Masukkan Nama Anda',
            ),
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
                child: const Text("Daftar"),
                onPressed: () {
                  // Aksi ketika button diklik
                  daftar();
                },
              ),
            ],
          ),
        ),
      ]),
    ));
  }

  Future<void> daftar() async {
    if (namaController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {

      var email = emailController.text;
      var password = passwordController.text;
      var name = namaController.text;

      if(password.length < 6) {
        CoolAlert.show(
          context: context,
          title: "Password Invalid",
          type: CoolAlertType.error,
          text: "Password tidak bisa kurang dari 6 karakter!",
        );
        return;
      }

      print("{nama : $name, \n email : $email, \n password : $password}");

      APIService.register(name, email, password).then((response) => {
            print(response),
            if (response)
              {
                //valid credential
                CoolAlert.show(
                    context: context,
                    title: "Register Berhasil",
                    type: CoolAlertType.success,
                    text:
                        "Akun anda berhasil dibuat, silakan masuk melalui halaman login",
                    onConfirmBtnTap: () => {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (route) => false)
                        }),
                namaController.clear(),
                emailController.clear(),
                passwordController.clear()
              }
            else
              {
                //invalid credential
                CoolAlert.show(
                  context: context,
                  title: "Register Error",
                  type: CoolAlertType.error,
                  text:
                      "Email yang anda masukan sudah terdaftar, silakan gunakan email lain",
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
