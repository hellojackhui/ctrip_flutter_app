import 'package:ctrip_flutter_app/navigator/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/services.dart';

void main() async {
  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = new SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
  runApp(
    ColorFiltered(colorFilter: ColorFilter.mode(Colors.white, BlendMode.color), child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Travel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabNavigator()
    );
  }
}

