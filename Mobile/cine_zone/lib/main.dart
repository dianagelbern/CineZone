import 'package:cine_zone/ui/screens/cine_screen.dart';
import 'package:cine_zone/ui/screens/config_screen.dart';
import 'package:cine_zone/ui/screens/details_screen.dart';
import 'package:cine_zone/ui/screens/home_screen.dart';
import 'package:cine_zone/ui/screens/login_screen.dart';
import 'package:cine_zone/ui/screens/menu_screen.dart';
import 'package:cine_zone/ui/screens/profile_screen.dart';
import 'package:cine_zone/ui/screens/register_screen.dart';
import 'package:cine_zone/ui/screens/search_screen.dart';
import 'package:cine_zone/ui/screens/tickets_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
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
        '/': (context) => const DetailsScreen(), //MenuScreen
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/search': (context) => const SearchScreen()
      },
    );
  }
}
