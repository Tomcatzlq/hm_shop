//封装一个api，目的是返回业务需要的数据
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

//轮播图列表接口
Future<List<BannerItem>> getBannerListAPI() async {
  //发送请求获取轮播图列表
  final res = await DioRequest().get(HttpConstants.BANNER_LIST);
  //判断是否成功
  if(res == null || res is! List){
    return [];
  }
  return (res as List).map((item){
    return BannerItem.fromJson(item as Map<String,dynamic>);//将map转换为banneritem对象
  }).toList();
}
//分类列表接口
Future<List<CategoryItem>> getCategoryListAPI() async {
  //发送请求获取分类列表
  final res = await DioRequest().get(HttpConstants.CATEGORY_LIST);
  //判断是否成功
  if(res == null || res is! List){
    return [];
  }
  return (res as List).map((item){
    return CategoryItem.fromJson(item as Map<String,dynamic>);//将map转换为categoryitem对象
  }).toList();
}