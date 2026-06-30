import 'package:hm_shop/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  //返回持久化的对象的实例对象
  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }
  //全局token
  String _token = "";
  //初始化
  Future<void> init() async {
    //获取实例对象
    final SharedPreferences prefs = await _getInstance();
    //设置token
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }
  //设置token
  Future<void> setToken(String token) async{
    //获取实例对象
    final SharedPreferences prefs = await _getInstance();
    //设置token
    prefs.setString(GlobalConstants.TOKEN_KEY, token);
    _token = token;//更新全局token
  }
  //获取token
  String getToken() {
    return _token;//返回全局token 同步方法
  }
  //移除token
  Future<void> removeToken() async{
    //获取实例对象
    final SharedPreferences prefs = await _getInstance();
    prefs.remove(GlobalConstants.TOKEN_KEY);//移除token 磁盘中移除
    _token = "";//更新全局token = ""; 内存中移除
  }
}
//设置单例模式
final TokenManager tokenManager = TokenManager();