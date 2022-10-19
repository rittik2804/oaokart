// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'no_internet.dart';

import 'connectivity.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime timeBackPressed = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();

    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    if (Platform.isIOS) WebView.platform = CupertinoWebView();
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    // ignore: prefer_const_constructors
    return Consumer<ConnectivityProvider>(
        builder: (consumerContext, model, child) {
      if (model.isOnline != null) {
        return model.isOnline! ? pageUi() : NoInternet();
      }
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}

class pageUi extends StatefulWidget {
  const pageUi({Key? key}) : super(key: key);

  @override
  _pageUiState createState() => _pageUiState();
}

class _pageUiState extends State<pageUi> {
  late WebViewController controller;
  DateTime timeBackPressed = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExistingWarning = difference >= Duration(seconds: 2);
          timeBackPressed = DateTime.now();

          if (isExistingWarning) {
            final massage = 'Press back again to exit';
            Fluttertoast.showToast(msg: massage, fontSize: 18);
            return false;
          } else {
            Fluttertoast.cancel();
            return true;
          }
        },
        child: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                child: WebView(
                  initialUrl: ('https://oaokart.com/'),
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: ((WebViewController controller) {
                    this.controller = controller;
                  }),
                  navigationDelegate: (NavigationRequest request) {
                    if (request.url.startsWith("https://oaokart.com/")) {
                      return NavigationDecision.navigate;
                    } else {
                      _launchURL(request.url);
                      return NavigationDecision.prevent;
                    }
                  },
                ),
              )),
        ));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
