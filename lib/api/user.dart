//登录接口api
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/user.dart';
//登录接口api
Future<UserInfo> loginAPI(Map<String, dynamic> params) async{
    final res = await DioRequest().post(HttpConstants.LOGIN, params: params);
    return UserInfo.formJson(res);
}
//用户信息接口api
Future<UserInfo> getUserProfileAPI() async{
    final res = await DioRequest().get(HttpConstants.USER_PROFILE);
    return UserInfo.formJson(res);
}
