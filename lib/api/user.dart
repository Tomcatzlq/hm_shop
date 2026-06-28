//登录接口api
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/user.dart';

Future<UserInfo> loginAPI(Map<String, dynamic> params) async{
    final res = await DioRequest().post(HttpConstants.LOGIN, params: params);
    return UserInfo.formJson(res);
}
