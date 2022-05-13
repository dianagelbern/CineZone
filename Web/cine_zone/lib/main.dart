import 'package:cine_zone/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
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
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(), //MenuScreen
      },
    );
  }
}
