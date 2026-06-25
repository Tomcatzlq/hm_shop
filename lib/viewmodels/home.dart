//定义轮播图模型类
class BannerItem{
  String? id;//轮播图id，用于点击跳转,非空
  String? imageUrl;//轮播图图片url,非空
  //构造函数
  BannerItem({this.id,this.imageUrl});
}