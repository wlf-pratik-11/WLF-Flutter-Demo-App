import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class LoginScreenBlock{
  LoginScreenBlock();

  final myController = BehaviorSubject();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final isPasswordVisible = BehaviorSubject<bool>.seeded(true);
  bool isPasswordVisibleCheack = true;

  String? emailValidator(String value){
    final bool emailValid =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if(emailValid){
      return null;
    }
    else{
      return "Enter Valid Email";
    }
  }

  String? passwordValidator(String value){
    if(value.length<6){
      return "Enter minimum 6 char password";
    }
    else{
      return null;
    }
  }

  bool validateForm(){
    if(formKey.currentState?.validate()??false){
      return true;
    }
    else{
      return false;
    }
  }

  void isPasswordVisibleFun(){
    isPasswordVisibleCheack = !isPasswordVisibleCheack;
    isPasswordVisible.sink.add(isPasswordVisibleCheack);
  }

  void dispose(){
    myController.close();
  }
}