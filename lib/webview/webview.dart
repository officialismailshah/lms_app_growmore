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

  Future<bool> _willPopCallback() async {
    WebViewController webViewController = await controller.future;
    // await webViewController.canGoForward();
    if (await webViewController.canGoForward()) {
      webViewController.canGoForward();
      return true;
    } else if (await webViewController.canGoBack()) {
      webViewController.canGoBack();
      return false;
    } else {
      return true;
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
        onWillPop: () => _willPopCallback(),
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
