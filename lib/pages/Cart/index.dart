import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/stores/cartController.dart';
import 'package:hm_shop/viewmodels/home.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartController _cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  // 加载模拟数据
  void _loadMockData() {
    if (_cartController.cartItems.isNotEmpty) return;
    final mockGoods = [
      GoodsItem(
        id: "1",
        name: "SILVER LAKE CLUB 银湖俱乐部 皮革2WAY竖版男士单肩斜挎包 黑色",
        price: "2092.00",
        picture: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/249992/p1.png",
      ),
      GoodsItem(
        id: "2",
        name: "十方未来 十方未来强化系列平角裤 米色",
        price: "119.00",
        picture: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/94076/p2.png",
      ),
      GoodsItem(
        id: "3",
        name: "极光限定 珠光蓝珐琅锅",
        price: "199.00",
        picture: "http://yjy-xiaotuxian-dev.oss-cn-beijing.aliyuncs.com/picture/2021-04-05/7f483771-6831-4a7a-abdb-2625acb755f3.png",
      ),
    ];
    for (var goods in mockGoods) {
      _cartController.addGoods(goods);
    }
  }

  // 构建顶部导航栏
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text("购物车", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      backgroundColor: Colors.white,
      elevation: 0.5,
      actions: [
        Obx(() => _cartController.cartItems.isNotEmpty
            ? TextButton(
                onPressed: () {
                  _showDeleteConfirmDialog();
                },
                child: Text("删除选中", style: TextStyle(color: Colors.grey, fontSize: 14)),
              )
            : SizedBox()),
      ],
    );
  }

  // 删除确认弹窗
  void _showDeleteConfirmDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("确定删除选中的商品吗？"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("取消"),
            ),
            TextButton(
              onPressed: () {
                _cartController.removeSelected();
                Navigator.pop(context);
              },
              child: Text("确定", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  // 构建购物车列表
  Widget _buildCartList() {
    return Obx(() {
      if (_cartController.cartItems.isEmpty) {
        return _buildEmptyCart();
      }
      return ListView.builder(
        padding: EdgeInsets.only(bottom: 60),
        itemCount: _cartController.cartItems.length,
        itemBuilder: (context, index) {
          return _buildCartItem(index);
        },
      );
    });
  }

  // 构建空购物车
  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[300]),
          SizedBox(height: 16),
          Text("购物车是空的", style: TextStyle(color: Colors.grey, fontSize: 16)),
          SizedBox(height: 8),
          Text("快去挑选心仪的商品吧", style: TextStyle(color: Colors.grey[400], fontSize: 13)),
        ],
      ),
    );
  }

  // 构建单个购物车商品
  Widget _buildCartItem(int index) {
    final item = _cartController.cartItems[index];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // 选中框
          GestureDetector(
            onTap: () => _cartController.toggleSelected(index),
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: item.isSelected ? Colors.red : Colors.grey[300]!,
                  width: 2,
                ),
                color: item.isSelected ? Colors.red : Colors.transparent,
              ),
              child: item.isSelected
                  ? Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ),
          SizedBox(width: 10),
          // 商品图片
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.goods.picture,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "lib/assets/home_cmd_inner.png",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          SizedBox(width: 10),
          // 商品信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 商品名称
                Text(
                  item.goods.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: Colors.black87),
                ),
                SizedBox(height: 8),
                // 价格和数量
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "¥${double.tryParse(item.goods.price)?.toInt() ?? 0}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    // 数量控制
                    _buildQuantityControl(index),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 构建数量控制器
  Widget _buildQuantityControl(int index) {
    final item = _cartController.cartItems[index];
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 减少按钮
          GestureDetector(
            onTap: () => _cartController.decreaseCount(index),
            child: Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              child: Icon(Icons.remove, size: 16, color: Colors.grey[600]),
            ),
          ),
          // 数量
          Container(
            width: 36,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.grey[300]!),
                right: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Text(
              "${item.count}",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          // 增加按钮
          GestureDetector(
            onTap: () => _cartController.increaseCount(index),
            child: Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              child: Icon(Icons.add, size: 16, color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  // 构建底部结算栏
  Widget _buildBottomBar() {
    return Obx(() {
      if (_cartController.cartItems.isEmpty) return SizedBox();
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            // 全选
            GestureDetector(
              onTap: () => _cartController.toggleAllSelected(),
              child: Row(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _cartController.isAllSelected ? Colors.red : Colors.grey[300]!,
                        width: 2,
                      ),
                      color: _cartController.isAllSelected ? Colors.red : Colors.transparent,
                    ),
                    child: _cartController.isAllSelected
                        ? Icon(Icons.check, size: 14, color: Colors.white)
                        : null,
                  ),
                  SizedBox(width: 6),
                  Text("全选", style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            Spacer(),
            // 合计
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text("合计: ", style: TextStyle(fontSize: 13)),
                    Text(
                      "¥${_cartController.selectedTotalPrice.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Text(
                  "已选${_cartController.selectedCount}件",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(width: 12),
            // 结算按钮
            GestureDetector(
              onTap: _cartController.selectedCount > 0
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("暂未对接结算接口")),
                      );
                    }
                  : null,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  color: _cartController.selectedCount > 0 ? Colors.red : Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "结算(${_cartController.selectedCount})",
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(
        children: [
          Expanded(child: _buildCartList()),
          _buildBottomBar(),
        ],
      ),
    );
  }
}
