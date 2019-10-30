import 'package:ctrip_flutter_app/navigator/tab_navigator.dart';
import 'package:flutter/material.dart';

class OpenPage extends StatefulWidget {
  @override
  _OpenPageState createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Animation _animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this
    );
    _animation = Tween(
      begin:  0.0,
      end: 1.0
    ).animate(_controller);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => TabNavigator()), (route) => route == null);
      }
    });
    _controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Image.asset('assets/images/open_page.jpg', fit: BoxFit.fill),
    );
  }
}