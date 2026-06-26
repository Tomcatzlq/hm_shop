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
//特惠推荐接口
Future<SpecialItem?> getSpecialAPI() async {
  //发送请求获取特惠推荐
  final res = await DioRequest().get(HttpConstants.PRODUCT_LIST);
  //判断是否成功
  if(res == null || res is! Map<String, dynamic>){
    return null;
  }
  return SpecialItem.fromJson(res);
}
//热榜推荐接口
Future<SpecialItem?> getInVogueAPI() async {
  //发送请求获取热榜推荐
  final res = await DioRequest().get(HttpConstants.IN_VOGUE_LIST);
  //判断是否成功
  if(res == null || res is! Map<String, dynamic>){
    return null;
  }
  return SpecialItem.fromJson(res);
}
//一站式推荐接口
Future<SpecialItem?> getOneStopAPI() async {
  //发送请求获取一站式推荐
  final res = await DioRequest().get(HttpConstants.ONE_STOP_LIST);
  //判断是否成功
  if(res == null || res is! Map<String, dynamic>){
    return null;
  }
  return SpecialItem.fromJson(res);
}