import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/utils/ToastUtils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController(); // 账号控制器
  TextEditingController _codeController = TextEditingController(); // 密码控制器
  // 用户账号Widget
  Widget _buildPhoneTextField() {
    return TextFormField(
      //validator可以返回校验文本
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "账号不能为空，请输入账号";
        }
        // 校验手机号格式
        if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(value)) {
          return "请输入正确的手机号格式";
        }
        return null;
      },
      controller: _phoneController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入账号",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  // 用户密码Widget
  Widget _buildCodeTextField() {
    return TextFormField(
      //validator可以返回校验文本
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "密码不能为空，请输入密码";
        }
        // 校验6-12位密码或数字
        if (!RegExp(r'^[a-zA-Z0-9]{6,12}$').hasMatch(value)) {
          return "请输入6-12位密码或数字";
        }
        return null;
      },
      controller: _codeController,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入密码",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
  //登录方法
  Future<void> _login() async{
    try{
      final userInfo = await loginAPI({
        "account": _phoneController.text,
        "password": _codeController.text,
      });
      print("当前的用户信息:$userInfo");
      ToastUtils.showToast(context, "登录成功");
      Navigator.pop(context);//返回上一个界面
      // 登录成功，跳转到首页
      Navigator.pushNamed(context, "/home");
    }catch(e){
      print(e);
      ToastUtils.showToast(context, (e as DioException).message ?? "登录失败");
    }
  }
  // 登录按钮Widget
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // 登录逻辑
          if (_formKey.currentState!.validate()) {
            if(_isChecked){
              // 校验通过，执行登录逻辑
              // print("登录按钮点击了");
              _login();
            }else{
              // 校验不通过，提示用户
              ToastUtils.showToast(context, "请先同意隐私条款和用户协议");
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text("登录", style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  bool _isChecked = false;
  // 勾选Widget
  Widget _buildCheckbox() {
    return Row(
      children: [
        // 设置勾选为圆角
        Checkbox(
          value: _isChecked,
          activeColor: Colors.black,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value ?? false;
            });
          },
          // 设置形状
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 圆角大小
          ),
          // 可选：设置边框
          side: BorderSide(color: Colors.grey, width: 2.0),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "查看并同意"),
              TextSpan(
                text: "《隐私条款》",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(text: "和"),
              TextSpan(
                text: "《用户协议》",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 头部Widget
  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "账号密码登录",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
  //global key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("惠多美登录", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(30),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 30),
              _buildPhoneTextField(),
              SizedBox(height: 20),
              _buildCodeTextField(),
              SizedBox(height: 20),
              _buildCheckbox(),
              SizedBox(height: 20),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
