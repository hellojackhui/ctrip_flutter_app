import 'package:flutter/material.dart';

class SpeakPage extends StatefulWidget {
  @override
  _SpeakPageState createState() => _SpeakPageState();
}

class _SpeakPageState extends State<SpeakPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Icon(Icons.title, size: 128.0,),
      ),
    );
  }
}