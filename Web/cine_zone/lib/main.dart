import 'dart:html';

import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/ui/screens/landing_screen.dart';
import 'package:cine_zone/ui/screens/login_screen.dart';
import 'package:cine_zone/ui/screens/menu_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF1C1A29),
      ),
      title: 'Flutter Demo',
      initialRoute: window.localStorage[Constant.bearerToken]!.isEmpty
          ? '/menu'
          : '/login',
      routes: {
        //'/landing': ((context) => const LandingScreen()),
        '/menu': (context) => const MenuScreen(),
        '/login': ((context) => const LoginScreen()),
        //MenuScreen
      },
    );
  }
}
