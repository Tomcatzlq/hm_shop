import 'package:get/get.dart';
import 'package:hm_shop/viewmodels/user.dart';
//需要共享的用户对象
class UserController extends GetxController{
  var user = UserInfo.formJson({}).obs;//用户对象被监听了
  //想要取值的话，需要使用user.value
  updateUserInfo(UserInfo newUser){//更新用户信息
    user.value = newUser;
  }
}