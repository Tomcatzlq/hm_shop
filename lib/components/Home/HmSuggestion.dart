import 'package:flutter/material.dart';

class Hmsuggestion extends StatefulWidget {
  Hmsuggestion({Key? key}) : super(key: key);

  @override
  _HmsuggestionState createState() => _HmsuggestionState();
}

class _HmsuggestionState extends State<Hmsuggestion> {
  @override
  Widget build(BuildContext context) {
    //增加边距
    return Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        height: 300,
        color: Colors.blue,
        child: Text("推荐",style: TextStyle(fontSize: 20,color: Colors.white),),
      ),
    );
  }
}