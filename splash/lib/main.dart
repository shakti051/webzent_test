import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splash/constants.dart';
import 'package:splash/home_page.dart';
import 'package:splash/splash_screen.dart';


void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Webzent Splash',
      theme: ThemeData(primaryColor: Colors.blueAccent),
      routes: <String, WidgetBuilder>{
        HOME_PAGE: (BuildContext context) => HomePage(),
        SPLASH_SCREEN: (BuildContext context) => AnimatedSplashScreen(),
      },
      initialRoute: SPLASH_SCREEN,
    );
  }
}