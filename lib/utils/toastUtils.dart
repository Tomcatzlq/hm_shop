import 'package:flutter/material.dart';
//提示工具类
class ToastUtils{
  //阀门控制
  static bool _isShow = false;//是否正在显示提示
  static void showToast(BuildContext context, String? msg){
    if(ToastUtils._isShow){
      return;
    }
    ToastUtils._isShow = true;
    // 3秒后关闭提示
    Future.delayed(Duration(seconds:3), () {
      ToastUtils._isShow = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 180,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        content: Text(msg ?? "加载成功",textAlign: TextAlign.center,)
        ),
    );
  }
}