import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
// import 'dart:convert';

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  Completer<WebViewController> controller = Completer<WebViewController>();
  WebViewController? _controller;

  Future<bool> _onWillPop(BuildContext context) async {
    if (await _controller!.canGoBack()) {
      _controller!.goBack();
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: SafeArea(
          child: WebView(
            initialUrl: 'https://lms.growmore.pk',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController wbcontroller) {
              controller.complete(wbcontroller);
            },
          ),
        ),
      ),
    );
  }
}
