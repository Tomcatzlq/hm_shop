import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/mine.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Mine/HmGuess.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/userController.dart';
import 'package:hm_shop/viewmodels/home.dart';
import 'package:hm_shop/viewmodels/user.dart';

class MineView extends StatefulWidget {
  MineView({Key? key}) : super(key: key);

  @override
  _MineViewState createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {
  //用户控制器
  final UserController _userController = Get.find();
  //退出登录按钮Widget
  Widget _getLogOut(){
    return _userController.user.value.id.isNotEmpty ? Expanded(
      child:GestureDetector(
        onTap: (){
          //弹出确认提示框
          showDialog(
            context: context, 
            builder: (context){
              return AlertDialog(
                title: Text("提示"),
                content: Text("确定退出登录吗？"),
                actions: [
                  TextButton(
                    onPressed: (){
                      //点击取消按钮，关闭弹窗
                      Navigator.pop(context);
                    },
                    child: Text("取消"),
                  ),
                  TextButton(
                    onPressed: () async{
                      //清除getx状态,删除token
                      await tokenManager.removeToken();
                      _userController.updateUserInfo(UserInfo.formJson({}));
                      // 关闭弹窗
                      Navigator.pop(context);
                    },
                    child: Text("确定"),
                  ),
                ],
              );
            }
          );
        },
        child: Text("退出登录", style: TextStyle(fontSize: 18, color: Colors.black), textAlign: TextAlign.right,)
      )
    ) : Text("");
  }
  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFFFFF2E8), const Color(0xFFFDF6F1)],
        ),
      ),
      padding: const EdgeInsets.only(left: 20, right: 40, top: 80, bottom: 20),
      child: Row(
        children: [
          Obx((){
            return CircleAvatar(
              radius: 26,
              backgroundImage: 
              _userController.user.value.avatar.isNotEmpty
              ? NetworkImage(_userController.user.value.avatar)
              : AssetImage('lib/assets/goods_avatar.png'),
              backgroundColor: Colors.white,
            );
          }),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  //obx中必须要有可监测的响应式数据
                  return GestureDetector(
                    onTap: () {
                      //如果用户没有登录，就跳转到登录页
                      if(_userController.user.value.id.isEmpty){
                        //如果没有用户登录，就跳转到登录页
                        Navigator.pushNamed(context, '/login');
                      }
                    },
                    child: Text(
                      _userController.user.value.id.isNotEmpty
                          ? _userController.user.value.account
                          : '立即登录',//如果没有登录，就显示立即登录
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  );
                })
              ],
            ),
          ),
          Obx(() => _getLogOut()),        
        ],
      ),
    );
  }

  Widget _buildVipCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 197, 153),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Image.asset("lib/assets/ic_user_vip.png", width: 30, height: 30),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                '升级美荟商城会员，尊享无限免邮',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(128, 44, 26, 1),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(126, 43, 26, 1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text('立即开通', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    Widget item(String pic, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(pic, width: 30, height: 30, fit: BoxFit.cover),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            item("lib/assets/ic_user_collect.png", '我的收藏'),
            item("lib/assets/ic_user_history.png", '我的足迹'),
            item("lib/assets/ic_user_unevaluated.png", '我的客服'),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderModule() {
    Widget orderItem(String pic, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(pic, width: 30, height: 30, fit: BoxFit.cover),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),

          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '我的订单',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  orderItem("lib/assets/ic_user_order.png", '全部订单'),
                  orderItem("lib/assets/ic_user_obligation.png", '待付款'),
                  orderItem("lib/assets/ic_user_unreceived.png", '待发货'),
                  orderItem("lib/assets/ic_user_unshipped.png", '待收货'),
                  orderItem("lib/assets/ic_user_unevaluated.png", '待评价'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //猜你喜欢列表
  List<GoodDetailItem> _list = [];
  //猜你喜欢列表接口 有参数 分页参数page:1,pageSize:10
  @override
  void initState() { 
    super.initState();
    _getGuessList();
    //监听滚动事件
    _registerEvent();
  }
  //监听滚动事件
  void _registerEvent(){
    _scrollController.addListener((){
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 50){
        //滚动到底部
        _getGuessList();
      }
    });
  }
  //定义阀门
  bool _isLoading = false;//是否正在加载
  bool _hasMore = true;//是否还有更多数据
  Map<String, dynamic> _params = {"page":1,"pageSize":10};//分页参数
  //获取猜你喜欢列表
  Future<void> _getGuessList() async {
    if(_isLoading || !_hasMore){
      return;
    }
    _isLoading = true;
    final res = await getGuessListAPI(_params);
    _list.addAll(res.items);//添加数据到列表到尾部
    _isLoading = false;
    setState(() {});
    //判断是否还有更多数据
    if(_params["page"] >= res.pages){
      _hasMore = false;
      return;
    }
    _params["page"]++;//分页参数page++
  }
  //控制器
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(child: _buildHeader()),
        SliverToBoxAdapter(child: _buildVipCard()),
        SliverToBoxAdapter(child: _buildQuickActions()),
        SliverToBoxAdapter(child: _buildOrderModule()),
        // 猜你喜欢 pinned表示固定在顶部
        SliverPersistentHeader(delegate: HmGuess(), pinned: true),
        HmMoreList(recommendList: _list)
      ],
    );
  }
}
