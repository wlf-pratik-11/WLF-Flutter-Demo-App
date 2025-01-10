import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../commons/common_functions.dart';
import '../../../../commons/my_colors.dart';

class EnterOtpScreenBloc {
  final EnterOtpScreenBlocController = BehaviorSubject<String>();
  final isLoading = BehaviorSubject<bool>.seeded(false);

  TextEditingController OTP = TextEditingController();

  Future<bool> otpVeryfy(String verificationId, BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: OTP.text.trim());
      await FirebaseAuth.instance.signInWithCredential(credential).then(
        (value) {
          isLoading.sink.add(false);
          final snakBar = SnackBar(
            content: Text(
              "Login via OTP Succesfull..!!",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: snakbarFontsize),
            ),
            backgroundColor: MyColors.darkBlue,
          );
          ScaffoldMessenger.of(context).showSnackBar(snakBar);
          Navigator.pop(context);
          Navigator.pop(context);
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
