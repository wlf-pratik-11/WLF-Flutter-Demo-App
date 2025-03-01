import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SignupUsingEmailScreenBloc {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  final signupUsingEmailScreenBlocController = BehaviorSubject<String>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final isPasswordVisible = BehaviorSubject<bool>.seeded(true);
  bool isPasswordVisibleCheack = true;

  final isLoading = BehaviorSubject<bool>.seeded(false);

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

  Future<bool> signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email.text, password: password.text);
      isLoading.sink.add(false);
      return true;
    } on FirebaseAuthException catch (e) {
      isLoading.sink.add(false);
      print("Sign Up Failed : $e");
      return false;
    }
  }

  void dispose() {
    signupUsingEmailScreenBlocController.close();
  }
}
