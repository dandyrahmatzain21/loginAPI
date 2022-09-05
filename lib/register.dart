import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:survei_asia/login.dart';
import 'package:survei_asia/services/api_service.dart';
import 'package:survei_asia/widgets/validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var namaController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

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

            //Selamat Datang
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
                'Silakan mendaftarkan akun anda untuk melanjutkan',
                textAlign: TextAlign.left,
              ),
            ),
            
            //FieldNama
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
              child: TextFormField(
                controller: namaController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama Tidak Boleh Kosong";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan Nama Anda',
                ),
              ),
            ),
            
            //FieldEmail
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
              child: TextFormField(
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
                controller: emailController,
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password Tidak Boleh Kosong";
                  }else if (value!.length < 6) {
                    return "Password Tidak Boleh Kurang Dari 6";
                  }
                  return null;
                },
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan Kata Sandi Anda',
                ),
              ),
            ),

            //ButtonDaftar
            Container(
              margin: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text("Daftar"),
                    onPressed: () {
                      // Aksi ketika button diklik
                        checkValidation(_formKey);
                        daftar();
                    },
                  ),
                ],
              ),
            ),
          ]
        ),
      )
    );
  }

  Future<void> daftar() async {
    if (namaController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {

      var email = emailController.text;
      var password = passwordController.text;
      var name = namaController.text;

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
      
      //APISERVICE
      print("{nama : $name, \n email : $email, \n password : $password}");
      APIService.register(name, email, password).then((response) => {
        print(response),
        if (response){
          //valid credential
          ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Register Berhasil"))),
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false),
          namaController.clear(),
          emailController.clear(),
          passwordController.clear(),
        }else{
          //invalid credential
          ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email Yang Digunakan Sudah Terdaftar")))
        }});
    }else{
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
