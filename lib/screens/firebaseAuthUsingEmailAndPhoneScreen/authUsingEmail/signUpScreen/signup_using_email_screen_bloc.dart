import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SignupUsingEmailScreenBloc {
  final signupUsingEmailScreenBlocController = BehaviorSubject<String>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final isPasswordVisible = BehaviorSubject<bool>.seeded(true);
  bool isPasswordVisibleCheack = true;

  String? nameValidate(String value) {
    if (value.isEmpty || value.length < 4) {
      return "Enter your name.!!";
    } else {
      return null;
    }
  }

  String? emailValidate(String value) {
    final bool emailValidate = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    if (emailValidate) {
      return null;
    } else {
      return "Enter valid e-mail.!!";
    }
  }

  String? passwordValidate(String value) {
    if (value.length < 6) {
      return "Enter minimum 6 char password";
    } else {
      return null;
    }
  }

  bool validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      return true;
    } else {
      return false;
    }
  }

  void isPasswordVisibleFun() {
    isPasswordVisibleCheack = !isPasswordVisibleCheack;
    isPasswordVisible.sink.add(isPasswordVisibleCheack);
  }

  void dispose() {
    signupUsingEmailScreenBlocController.close();
  }
}
