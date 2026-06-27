import 'package:flutter/material.dart';
//提示工具类
class ToastUtils{
  static void showToast(BuildContext context, String? msg){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 120,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        content: Text(msg ?? "加载成功",textAlign: TextAlign.center,)
        ),
    );
  }
}