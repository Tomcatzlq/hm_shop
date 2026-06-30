import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class Hmcategory extends StatefulWidget {
  //分类列表
  final List<CategoryItem> categoryList;
  const Hmcategory({super.key,required this.categoryList});

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
        itemCount: widget.categoryList.length,
        scrollDirection: Axis.horizontal,//水平方向
        itemBuilder: (BuildContext context,int index){
          //获取分类列表中的数据
          final item = widget.categoryList[index];
          return Container(
            alignment: Alignment.center,
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 218, 225, 233),
              borderRadius: BorderRadius.circular(40),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,//垂直方向居中
              children: [
                Image.network(item.picture,width: 40,height: 40),
                Text(item.name,style: TextStyle(fontSize: 12,color: Colors.black),),
              ],
            ),
          );
        }
      )
    );
  }
}