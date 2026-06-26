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
  //声明一个推荐列表模型类
  List<GoodDetailItem> _recommendList = [];
  //初始化获取数据
  @override
  void initState() { 
    super.initState();
    _getBannerList();//获取轮播图列表
    _getCategoryList();//获取分类列表
    _getSpecialList();//获取特惠推荐列表
    _getHotList();//获取热榜推荐列表
    _getOneStopList();//获取一站式推荐列表
    _getRecommendList();//获取推荐列表
    _registerEvent();//注册事件
  }
  //页码
  int _page = 1;
  bool _isLoading = false;//是否正在加载更多数据
  bool _hasMore = true;//是否还有更多数据
  //注册事件
  void _registerEvent(){
    _scrollController.addListener((){
      //滚动到底部再触发
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent){
        //加载更多数据
        _getRecommendList();//获取推荐列表
        // print("滚动到底部了");
      }
    });
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
  //获取推荐列表
  Future<void> _getRecommendList() async {
    if(_isLoading || !_hasMore){//判断是否正在加载数据 或 是否还有更多数据 就放弃请求
      return;
    }
    _isLoading = true;//占住位置
    _recommendList = await getRecommendListAPI({"limit": _page * 10});
    _isLoading = false;//释放位置
    setState(() {});
    if(_recommendList.length <  _page * 10){
      _hasMore = false;
      return;
    }
    _page++;
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
      HmMoreList(recommendList: _recommendList),
    ];
  }
  //滚动控制器
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
      return CustomScrollView(
        slivers: _getSlSlivers(),
        controller: _scrollController,//绑定滚动控制器
        );////silver家族的内容
  }
}