import 'package:flutter/material.dart';

class Hmmorelist extends StatefulWidget {
  Hmmorelist({Key? key}) : super(key: key);

  @override
  _HmmorelistState createState() => _HmmorelistState();
}

class _HmmorelistState extends State<Hmmorelist> {
  @override
  Widget build(BuildContext context) {
    //必须是sliver家族的组件
    return SliverGrid.builder(
      itemCount: 20,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ), 
      itemBuilder: (BuildContext context, int index){
        return Container(
          alignment: Alignment.center,
          child: Text("商品",style: TextStyle(fontSize: 20,color: Colors.white),),
          color: Colors.blue,
        );
    });
  }
}