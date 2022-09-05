import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survei_asia/services/shared_service.dart';
import 'dart:async';
import './landing.dart';
import 'dashboard.dart';
import 'models/login_response.dart';

class LauncherPage extends StatefulWidget {
  @override
  _LauncherPageState createState() => new _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    super.initState();
    startLaunching();
  }
  startLaunching() async {
    var duration = const Duration(seconds: 5);
    return new Timer(duration, () {
      checkLogin();
    });
  }

  void checkLogin() async {
    WidgetsFlutterBinding.ensureInitialized();
    bool _isLoggedIn = await SharedService.isLoggedIn();
    LoginResponse? data = await SharedService.loginDetails();
    if (_isLoggedIn) {
      print("Token LoggedIn : ${data?.data?.Token}");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
              (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
              (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xfffbb448),
    ));
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Center(
              child: new Image.asset(
                "images/image1.png",
                height: 70.0,
                width: 200.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// import 'dart:js';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:async';
// import './landing.dart';
//
// class LauncherPage extends StatefulWidget {
//   @override
//   void initState() {
//     super.initState();
//     startLaunching();
//   }
//   startLaunching() async {
//     var duration = const Duration(seconds: 10);
//     return new Timer(duration, () {
//       Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_){
//         return new LandingPage();
//       }));
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Color(0xfffbb448),
//     ));
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(5)),
//           boxShadow: <BoxShadow>[
//             BoxShadow(
//               color: Colors.grey.shade200,
//               offset: Offset(2, 4),
//               blurRadius: 5,
//               spreadRadius: 2
//             )
//           ],
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xfffbb448), Color(0xfff7892b)])),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             new Center(
//               child: new Image.asset(
//                 'images/image1.png',
//                 height: 70.0,
//                 width: 200.0,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }