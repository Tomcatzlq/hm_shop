//基于Dio的请求工具类
import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';

class DioRequest {
  final Dio _dio = Dio();//dio请求对象
  //基础地址拦截器
  DioRequest(){
    _dio.options//连续赋值操作
    ..baseUrl = GlobalConstants.BASE_URL
    ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
    ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
    ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    //拦截器
    addInterceptors();
  }
  //添加拦截器
  void addInterceptors(){
    _dio.interceptors.add(
        InterceptorsWrapper(
            onRequest: (request, handler){
                handler.next(request);
            },
            onResponse: (response, handler){
                //判断是否成功
                if(response.statusCode! >=200 && response.statusCode! < 300){
                    handler.next(response);
                    return;
                }
                
            },
            onError: (error, handler){
                handler.reject(error);
            },
        )
    );
  }
  //get请求
  //url:请求地址
  //params:请求参数
  Future<dynamic> get(String url, {Map<String, dynamic>? params}){
    return _handleResponse(_dio.get(url, queryParameters: params));
  }
  //处理响应
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try{
        //异步处理响应
        Response<dynamic> res = await task;
        final data = res.data as Map<String, dynamic>;//data才是真实的数据
        //判断是否成功
        if(data["code"] == GlobalConstants.SUCCESS_CODE){
            return data["result"] as dynamic;
        }
        //如果失败，抛出异常
            throw Exception(data["msg"] ?? "请求失败");
        }
        catch(e){
            throw Exception("还没有处理就失败:" + e.toString());
    }
  }
}
//单例对象
final DioRequest dioRequest = DioRequest();//单例对象,在App整个生命周期中也只会被实例化一次