// ignore_for_file: unused_field

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:local_notification/constant.dart';
import 'chart_page.dart';

final InAppLocalhostServer localhostServer = InAppLocalhostServer(port: 8888);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  localhostServer.start();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);
    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();
      await serviceWorkerController.setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          if (kDebugMode) {
            print(request);
          }
          return null;
        },
      ));
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Constant.isDark,
      builder: (context, value, child) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.lightGreen,
            brightness: value ? Brightness.dark : Brightness.light,
          ),
          useMaterial3: true,
        ),
        home: const ChartPage()
      ),
    );
  }
}
