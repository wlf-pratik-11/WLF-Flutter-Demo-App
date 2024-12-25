import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class SignupScreenBloc{
  SignupScreenBloc();

  final myController = BehaviorSubject<bool>.seeded(false);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final isPasswordVisible = BehaviorSubject<bool>.seeded(true);
  bool isPasswordVisibleCheack = true;

  String? nameValidator(String value){
    if(value.isEmpty || value.length<4){
      return "Enter Full Name";
    }else{
      return null;
    }
  }

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

  void tncCheackBox(bool cheack){
    myController.sink.add(cheack);
  }

  void isPasswordVisibleFun(){
    isPasswordVisibleCheack = !isPasswordVisibleCheack;
    isPasswordVisible.sink.add(isPasswordVisibleCheack);
  }

  void dispose(){
    myController.close();
  }

}

