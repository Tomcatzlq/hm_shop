import 'package:flutter/material.dart';

class Hmcategory extends StatefulWidget {
  Hmcategory({Key? key}) : super(key: key);

  @override
  _HmcategoryState createState() => _HmcategoryState();
}

class _HmcategoryState extends State<Hmcategory> {
  @override
  Widget build(BuildContext context) {
    //return ListView() 返回一个横向排序的组件，但是需要设置高度，可以使用sizebox
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,//水平方向
        itemBuilder: (BuildContext context,int index){
          return Container(
            alignment: Alignment.center,
            width: 80,
            height: 100,
            color: Colors.blue,
            child: Text("分类$index",style: TextStyle(fontSize: 20,color: Colors.white),),
            margin: EdgeInsets.symmetric(horizontal: 10),
          );
        }
      )
    );
  }
}