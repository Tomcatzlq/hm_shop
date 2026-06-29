import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/userController.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //定义数据，根据数据渲染四个导航
  //一般程序的导航栏是固定的
  final List<Map<String, String>> _tabList = [
    {'icon': 'lib/assets/ic_public_home_normal.png', 'active_icon': 'lib/assets/ic_public_home_active.png', 'title': '首页'},
    {'icon': 'lib/assets/ic_public_pro_normal.png', 'active_icon': 'lib/assets/ic_public_pro_active.png', 'title': '分类'},
    {'icon': 'lib/assets/ic_public_cart_normal.png', 'active_icon': 'lib/assets/ic_public_cart_active.png', 'title': '购物车'},
    {'icon': 'lib/assets/ic_public_my_normal.png', 'active_icon': 'lib/assets/ic_public_my_active.png', 'title': '我的'},
  ];
  //根据数据渲染导航栏
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]['icon']!, width: 30, height: 30),//!!表示非空断言，确保图标路径不为空
        activeIcon: Image.asset(_tabList[index]['active_icon']!, width: 30, height: 30),//!!表示非空断言，确保图标路径不为空
        label: _tabList[index]['title']!,//!!表示非空断言，确保标题不为空
      );
    });
  }
  int _currentIndex = 0;
  List<Widget> _getChildren(){
    return [
      HomeView(),//首页组件
      CategoryView(),//分类组件
      CartView(),//购物车组件
      MineView()];//我的组件
  }
  //初始化时，获取token
  @override
  void initState() {
    super.initState();
    //初始化用户
    initUser();
  }
  final UserController _userController = Get.put(UserController());
  //初始化用户
  initUser() async{
    //先初始化一下
    await tokenManager.init();
    if(tokenManager.getToken().isNotEmpty){
      //如果有token，就获取用户信息
      try{
        _userController.updateUserInfo(await getUserProfileAPI());
      }catch(e){
        print("获取用户信息失败:$e");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //避开安全区，避免被状态栏遮挡
       body: SafeArea(child: IndexedStack(
        index: _currentIndex,//当前选中的索引
        children: _getChildren(),//放置几个组件
       )),
       bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,//显示选中的文本
        showUnselectedLabels: true,//显示未选中的文本
        unselectedItemColor: Colors.grey,//未选中的文本颜色
        selectedItemColor: Colors.black,//选中的文本颜色
        currentIndex: _currentIndex,
        onTap: (int index) {
          //index表示当前点击的索引
          setState(() {
            _currentIndex = index;
          });//通过setState方法更新状态，触发重新构建界面
        },
        items: _getTabBarWidget(),
       ),
    );
  }
}