//定义猜你喜欢接口
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';
//猜你喜欢列表接口 有参数 分页参数page:1,pageSize:10
Future<GoodsDetailsItems> getGuessListAPI(Map<String, dynamic> params) async {
  //发送请求获取猜你喜欢列表
  final res = await DioRequest().get(HttpConstants.GUESS_LIST, params: params);
  //判断是否成功
  if(res == null || res is! Map<String, dynamic>){
    return GoodsDetailsItems();
  }
  return GoodsDetailsItems.formJSON(res);
}