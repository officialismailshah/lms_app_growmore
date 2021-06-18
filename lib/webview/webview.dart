import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
// import 'dart:convert';

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  // Completer<WebViewController> controller = Completer<WebViewController>();
  WebViewController? controllerGlobal;

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal!.canGoBack()) {
      print("onwill goback");
      controllerGlobal!.goBack();
      return false;
    } else if (await controllerGlobal!.currentUrl() ==
        'https://lms.growmore.pk') {
      SystemNavigator.pop();
      // ignore: deprecated_member_use
      // Scaffold.of(context).showSnackBar(
      //   const SnackBar(content: Text("No back history item")),
      // );
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () => _exitApp(context),
        child: SafeArea(
          child: WebView(
            initialUrl: 'https://lms.growmore.pk',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (wbcontroller) {
              controllerGlobal = wbcontroller;
            },
          ),
        ),
      ),
    );
  }
}
