
import 'package:flutter/material.dart';
import 'package:main_app_demo/screens/resetPasswordScreen/reset_password_screen_block.dart';

import '../../commons/common_functions.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  ResetPasswordScreenBlock _bloc = ResetPasswordScreenBlock();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(
            top: 15,
          ),
          child: Text(
            "Reset Password",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Form(
        key: _bloc.formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox.fromSize(size: Size.fromHeight(60)),
              inputField("Old Password", _bloc.oldPassword,validator:(value) {
                return _bloc.oldPasswordValidator(value);
              }, isPassword: false,showEyeIcon: false),

              inputField("New Password", _bloc.newPassword,validator:(value) {
                return _bloc.newPasswordValidator(value);
              }, isPassword: false,showEyeIcon: false),

              inputField("Confirm Password", _bloc.confirmPassword,validator:(value) {
                return _bloc.confirmPasswordValidator(value);
              }, isPassword: false,showEyeIcon: false),
              
              commonButton("Continue",buttonStatusFun: () {
                if(_bloc.validateForm()){
                  final snakBar = SnackBar(
                    content:Text("Password reset successfully..!!",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    backgroundColor: Colors.deepPurpleAccent,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snakBar);
                  _bloc.oldPassword.clear();
                  _bloc.newPassword.clear();
                  _bloc.confirmPassword.clear();
                  Navigator.pop(context);
                }
              },)

              ] ,
          ),
        ),
      ),
    );
  }
}
