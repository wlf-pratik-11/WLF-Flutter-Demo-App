import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class EnterOtpScreenBloc {
  final EnterOtpScreenBlocController = BehaviorSubject<String>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController OTP = TextEditingController();

  String? OTPValidate() {
    if (OTP.text.isEmpty || OTP.toString().length < 6) {
      return "Enter Valid OTP";
    } else if (OTP.text == "123456") {
      return "OTP Verified";
    }
  }

  bool validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      return true;
    } else {
      return false;
    }
  }
}
