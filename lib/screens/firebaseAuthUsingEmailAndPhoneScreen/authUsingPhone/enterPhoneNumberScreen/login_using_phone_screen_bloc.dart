import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LoginUsingPhoneScreenBloc {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final loginUsingPhoneScreenBlocController = BehaviorSubject<String>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController phoneNumber = TextEditingController();

  String? phoneNumberValidate(String value) {
    if (value.isEmpty || value.length < 10) {
      return "Enter 10 digit phone number";
    }
  }

  Future<bool> getOTp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91 ${phoneNumber.text}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return true;
  }

  bool validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      return true;
    } else {
      return false;
    }
  }
}
