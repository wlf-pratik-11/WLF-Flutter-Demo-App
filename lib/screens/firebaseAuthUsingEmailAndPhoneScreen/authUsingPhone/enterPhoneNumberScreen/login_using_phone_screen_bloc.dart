import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../enterOtpScreen/enter_otp_screen.dart';

class LoginUsingPhoneScreenBloc {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final loginUsingPhoneScreenBlocController = BehaviorSubject<String>();
  final isLoading = BehaviorSubject<bool>.seeded(false);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController phoneNumber = TextEditingController();

  String? phoneNumberValidate(String value) {
    if (value.isEmpty || value.length < 10) {
      return "Enter 10 digit phone number";
    }
  }

  Future<bool> getOTp(BuildContext context) async {
    print("Gettttt OTP MEthoddd ============>>>>>>>>>>>>");
    await _auth.verifyPhoneNumber(
        phoneNumber: "+91 ${phoneNumber.text}",
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {
          print("verificationFailed=================================>>>>>>>>>>>>>>>>>>$error");
        },
        codeSent: (verificationId, forceResendingToken) {
          isLoading.sink.add(false);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EnterOtpScreen(verificationId, phoneNumber.text),
              ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: Duration(seconds: 60));
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
