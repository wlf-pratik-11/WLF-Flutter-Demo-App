import 'package:flutter/cupertino.dart';

class ResetPasswordScreenBlock{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  String? oldPasswordValidator(String value){
    if(value.length<6){
      return "Password Must be 6 Charecter";
    }else{
      return null;
    }
  }

  String? newPasswordValidator(String value){
    if(value.length<6){
      return "Password Must be 6 Charecter";
    }else{
      return null;
    }
  }

  String? confirmPasswordValidator(String value){
    if(newPassword.text != value.toString()){
      return "Plese enter same new and confirm password";
    }else{
      return null;
    }
  }

  bool validateForm(){
    if(formKey.currentState?.validate()??false){
      print("Form State ::::: true");
      return true;
    }
    else{
      print("Form State ::::: false");
      return false;
    }
  }

}