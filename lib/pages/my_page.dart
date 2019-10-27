import 'package:ctrip_flutter_app/widgets/webview.dart';
import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        url: 'https://github.com/hellojackhui/flutter_ctrip_app',
        hideAppbar: true,
        backForbid: true,
        statusBarColor: '4c5bca',
      ),
    );
  }
}