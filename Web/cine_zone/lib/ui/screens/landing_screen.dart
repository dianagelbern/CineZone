import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:html';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
/*     Shared.getToken().then((value) {
      print(value);
      if (value.isEmpty) {
        return Navigator.pushNamed(context, '/login');
      } else {
        return Navigator.pushNamed(context, '/menu');
      }
    }); */
    //print(window.localStorage[Constant.bearerToken]);
    super.initState();

    print(window.localStorage[Constant.bearerToken]);
    if (window.localStorage[Constant.bearerToken] != null) {
      Navigator.pushNamed(context, '/menu');
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1A29),
      body: Center(child: Image.asset('assets/images/fondo.png')),
    );
  }
}
