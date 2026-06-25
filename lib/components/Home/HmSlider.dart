import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class Hmslider extends StatefulWidget {
  //子类接受父类传过来的轮播图对象
  final List<BannerItem> bannerList;
  //构造函数
  Hmslider({super.key,required this.bannerList});

  @override
  _HmsliderState createState() => _HmsliderState();
}

class _HmsliderState extends State<Hmslider> {
  //返回轮播图插件
  Widget _getSlider(BuildContext context){
  final double screenWidth = MediaQuery.of(context).size.width;
  return CarouselSlider(
    items:List.generate(widget.bannerList.length, (int index){
      return Image.network(widget.bannerList[index].imageUrl!,
      fit: BoxFit.cover,//图片等比例缩放，填充整个容器
      width: screenWidth,);//！表示非空
    }),
    options: CarouselOptions(
      autoPlay: true,
      viewportFraction: 1.0,
      height: 300,
      autoPlayInterval: Duration(seconds: 3),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    //stack-轮播图-搜索栏-指示灯导航
    return Stack(
      children: [
        _getSlider(context),
      ],
    );
    // return Container(
    //   alignment: Alignment.center,
    //   height: 300,
    //   color: Colors.blue,
    //   child: Text("轮播图",style: TextStyle(fontSize: 20,color: Colors.white),),
    // );
  }
}