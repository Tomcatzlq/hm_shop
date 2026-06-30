import 'package:get/get.dart';
import 'package:hm_shop/viewmodels/home.dart';

class CartItem {
  GoodsItem goods;
  int count;
  bool isSelected;

  CartItem({required this.goods, this.count = 1, this.isSelected = true});

  double get totalPrice =>
      double.tryParse(goods.price) != null
          ? double.parse(goods.price) * count
          : 0;
}

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  // 商品数量
  int get totalCount =>
      cartItems.fold(0, (sum, item) => sum + item.count);
      //fold方法用于累计计算，初始值为0，每次迭代将当前值与下一个元素的count相加，返回最终结果

  // 选中商品总价格
  double get selectedTotalPrice => cartItems
      .where((item) => item.isSelected)
      .fold(0.0, (sum, item) => sum + item.totalPrice);

  // 选中商品数量
  int get selectedCount =>
      cartItems.where((item) => item.isSelected).length;

  // 是否全选
  bool get isAllSelected =>
      cartItems.isNotEmpty && cartItems.every((item) => item.isSelected);

  // 添加商品到购物车
  void addGoods(GoodsItem goods) {
    final index = cartItems.indexWhere((item) => item.goods.id == goods.id);
    if (index >= 0) {
      cartItems[index].count++;
      cartItems.refresh();
    } else {
      cartItems.add(CartItem(goods: goods));
    }
  }

  // 减少商品数量
  void decreaseCount(int index) {
    if (cartItems[index].count > 1) {
      cartItems[index].count--;
      cartItems.refresh();
    } else {
      cartItems.removeAt(index);
    }
  }

  // 增加商品数量
  void increaseCount(int index) {
    cartItems[index].count++;
    cartItems.refresh();
  }

  // 切换选中状态
  void toggleSelected(int index) {
    cartItems[index].isSelected = !cartItems[index].isSelected;
    cartItems.refresh();
  }

  // 全选/取消全选
  void toggleAllSelected() {
    final newValue = !isAllSelected;
    for (var item in cartItems) {
      item.isSelected = newValue;
    }
    cartItems.refresh();
  }

  // 删除选中商品
  void removeSelected() {
    cartItems.removeWhere((item) => item.isSelected);
  }
}
