import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class Hmsuggestion extends StatefulWidget {
  //接收一个特惠推荐模型类
  final SpecialItem specialItem;
  Hmsuggestion({Key? key,required this.specialItem}) : super(key: key);

  @override
  _HmsuggestionState createState() => _HmsuggestionState();
}

class _HmsuggestionState extends State<Hmsuggestion> {
  //获取三条特惠推荐商品数据
  List<GoodsItem> _getDisplayItems(){
    if(widget.specialItem.subTypes.isEmpty){
      return [];//初始化如果没有获取数据,返回空列表
    }
    return widget.specialItem.subTypes.first.goodsItems.items.take(3).toList();
  }
  //顶部内容
  Widget _buildHeader(){
    return Row(
      children: [
        Text("特惠推荐",
        style: TextStyle(fontSize: 18,color: const Color.fromARGB(255, 148, 47, 47),fontWeight: FontWeight.bold,)),
        SizedBox(width: 10,),
        Text("精选省攻略",
        style: TextStyle(fontSize: 12,color: const Color.fromARGB(255, 53, 40, 40)),),
      ],
    );
  }
  //左侧内容
  Widget _buildLeft(){
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("lib/assets/home_cmd_inner.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
  //右侧内容
  List<Widget> _buildRight(){
    List<GoodsItem> list = _getDisplayItems();//获取商品列表
    return List.generate(list.length, (int index){
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              //返回一个新的部件替代原有图片，防止没有图片时显示错误
              errorBuilder: (context, error, stackTrace){
                return Image.asset("lib/assets/home_cmd_inner.png",
                width: 100,height: 140,fit: BoxFit.cover,);
              },
              list[index].picture,width: 100,height: 140,fit: BoxFit.cover,),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text("￥${list[index].price}",
            style: TextStyle(fontSize: 12,color: const Color.fromARGB(255, 226, 9, 9)),),
            ),
        ],
      );
    });
  }
  //完成渲染组件
  @override
  Widget build(BuildContext context) {
    //增加边距
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        // height: 300,
        padding: EdgeInsets.all(12),
               decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage("lib/assets/home_cmd_sm.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            //顶部内容
            _buildHeader(),
            SizedBox(height: 10,),
            //商品列表
            Row(
              children: [
                //左侧
                _buildLeft(),
                //右侧
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _buildRight(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}