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
  //定义当前选中的轮播图索引
  int currentIndex = 0;
  //定义轮播图控制器
  CarouselSliderController carouselController = CarouselSliderController();
  //返回轮播图插件
  Widget _getSlider(){
  //获取整体屏幕宽度
  final double screenWidth = MediaQuery.of(context).size.width;
    return CarouselSlider(
      carouselController: carouselController,
      items:List.generate(widget.bannerList.length, (int index){
        return Image.network(widget.bannerList[index].imageUrl,
        fit: BoxFit.cover,//图片等比例缩放，填充整个容器
        width: screenWidth,);//！表示非空
      }),
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1.0,//显示一个轮播图，占满整个宽度
        height: 300,
        autoPlayInterval: Duration(seconds: 3),
        onPageChanged: (int index, CarouselPageChangedReason? reason) {
          setState(() {
            currentIndex = index;//状态更新当前选中的轮播图索引
          });
        },
      ),
    );
  }
  //实现搜索框的样式
  Widget _getSearch(){
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child:Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.4),//透明度
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text("搜索",style: TextStyle(fontSize: 20,color: Colors.white),),
        ),
      ),
    );
  }
  //返回指示灯导航插件
  Widget _getIndicator(){
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child:SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,//主轴居中
          children: List.generate(widget.bannerList.length, (int index){
            return GestureDetector(
              onTap: (){
                setState(() {
                  currentIndex = index;
                  carouselController.animateToPage(index);//切换到指定索引的轮播图
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: index == currentIndex ? 40.0 : 20,
                height: 6,
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: index == currentIndex ? Colors.white : Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            );
          }),
        ),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    //stack-轮播图-搜索栏-指示灯导航
    return Stack(
      children: [
        _getSlider(),
        _getSearch(),
        _getIndicator(),
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