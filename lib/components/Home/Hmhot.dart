import 'package:flutter/material.dart';

class Hmhot extends StatefulWidget {
  Hmhot({Key? key}) : super(key: key);

  @override
  _HmhotState createState() => _HmhotState();
}

class _HmhotState extends State<Hmhot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      color: Colors.blue,
      child: Text("爆款推荐",style: TextStyle(fontSize: 20,color: Colors.white),),
    );
  }
}