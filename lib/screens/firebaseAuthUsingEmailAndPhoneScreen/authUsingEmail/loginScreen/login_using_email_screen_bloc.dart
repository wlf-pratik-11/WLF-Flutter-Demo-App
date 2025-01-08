import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LoginUsingEmailScreenBloc {
  final loginUsingEmailScreenBlocController = BehaviorSubject<String>();
  final isPasswordVisible = BehaviorSubject<bool>.seeded(true);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isPasswordVisibleCheack = true;

  String? emailValidate(String value) {
    final bool isValidate = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    if (isValidate) {
      return null;
    } else {
      return "Enter Valid Email.!!";
    }
  }

  String? passwordValidate(String value) {
    if (value.isEmpty || value.length < 6) {
      return "Please enter min 6 char password.!";
    } else {
      return null;
    }
  }

  void isPAsswordVisibleFun() {
    isPasswordVisibleCheack = !isPasswordVisibleCheack;
    isPasswordVisible.sink.add(isPasswordVisibleCheack);
  }

  bool validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      return true;
    } else {
      return false;
    }
  }

  void dispose() {
    loginUsingEmailScreenBlocController.close();
  }
}
