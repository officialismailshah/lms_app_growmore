import 'package:flutter/material.dart';
import 'package:grow_lms_app/webview/webview.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: WebViewExample(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/GrowMoreLogo.png",
      backgroundColor: Colors.white,
    );
  }
}
