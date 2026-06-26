import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/components/Home/Hmhot.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //声明一个分类列表模型类
  List<CategoryItem> _categoryList = [];
  //声明一个轮播图模型类
  List<BannerItem> _bannerList = [
  //   BannerItem(id: "1",imageUrl: "https://tomcatzlq1.oss-cn-hangzhou.aliyuncs.com/hm_shop/1.png"),
  //   BannerItem(id: "2",imageUrl: "https://tomcatzlq1.oss-cn-hangzhou.aliyuncs.com/hm_shop/2.png"),
  //   BannerItem(id: "3",imageUrl: "https://tomcatzlq1.oss-cn-hangzhou.aliyuncs.com/hm_shop/3.png"),
  //   BannerItem(id: "4",imageUrl: "https://tomcatzlq1.oss-cn-hangzhou.aliyuncs.com/hm_shop/4.png"),
  ];
  //声明一个特惠推荐模型类
  SpecialItem _specialItem = SpecialItem(
    id: "",
    title: "",
    subTypes: [],
  );
  //声明一个热榜推荐模型类
  SpecialItem _hotItem = SpecialItem(
    id: "",
    title: "",
    subTypes: [],
  );
  //声明一个一站式推荐模型类
  SpecialItem _oneStopItem = SpecialItem(
    id: "",
    title: "",
    subTypes: [],
  );
  //初始化获取数据
  @override
  void initState() { 
    super.initState();
    _getBannerList();//获取轮播图列表
    _getCategoryList();//获取分类列表
    _getSpecialList();//获取特惠推荐列表
    _getHotList();//获取热榜推荐列表
    _getOneStopList();//获取一站式推荐列表
  }
  //获取特惠推荐列表
  Future<void> _getSpecialList() async {
    final result = await getSpecialAPI();
    if(result != null){
      _specialItem = result;
      setState(() {});
    }
  }
  //获取热榜推荐列表
  Future<void> _getHotList() async {
    final result = await getInVogueAPI();
    if(result != null){
      _hotItem = result;
      setState(() {});
    }
  }
  //获取一站式推荐列表
  Future<void> _getOneStopList() async {
    final result = await getOneStopAPI();
    if(result != null){
      _oneStopItem = result;
      setState(() {});
    }
  }
  //获取轮播图列表
  Future<void> _getBannerList() async {
    _bannerList = await getBannerListAPI();
    // print(_bannerList);
    setState(() {});
  }
  //获取分类列表
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
    // print(_categoryList);
    setState(() {});
  }
  List<Widget> _getSlSlivers(){
    return [
      //包裹普通sliver家族的组件
      SliverToBoxAdapter(child: Hmslider(bannerList: _bannerList,),),
      //放置间距组件
      SliverToBoxAdapter(child: SizedBox(height: 10,)),
      //放置分类组件
      SliverToBoxAdapter(child: Hmcategory(categoryList: _categoryList,),),
      //放置推荐组件
      SliverToBoxAdapter(child: SizedBox(height: 10,)),
      SliverToBoxAdapter(child: Hmsuggestion(specialItem: _specialItem,),),      
      //放置热门组件,中间有间距
      SliverToBoxAdapter(child: SizedBox(height: 10,)),
      SliverToBoxAdapter(child: Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            //设置均分空间Expanded
            Expanded(child: HmHot(result: _hotItem,type: "hot",)),
            SizedBox(width: 10,),
            Expanded(child: HmHot(result: _oneStopItem,type: "step",)),
          ],
        )),
      ),
      //放置更多列表组件
      SliverToBoxAdapter(child: SizedBox(height: 10,)),
      Hmmorelist(),
    ];
  }
  @override
  Widget build(BuildContext context) {
      return CustomScrollView(slivers: _getSlSlivers());////silver家族的内容
  }
}