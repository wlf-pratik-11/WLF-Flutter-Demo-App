import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class FormNavigatorScreenBlock {
  FormNavigatorScreenBlock();
  final _myController = StreamController<String>();

  Stream<String> get myStream =>_myController.stream;
  Sink<String> get mySink => _myController.sink;


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController name= TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController bDate = TextEditingController();
  final TextEditingController email = TextEditingController();

  String? nameValidator(String value){
    if(value.isEmpty || value.length<4){
      return "Enter Your Full Name..";
    }else{
      return null;
    }
  }

  String? bDateValidator(DateTime? pickedDate ){
    if (pickedDate != null) {
        bDate.text =  DateFormat("dd-MM-yyyy").format(pickedDate) ;
        return null;
    }
    else{
      return "Select Your Birthdate.";
    }
  }

  String? emailValidator(String? value) {
    bool emailValid =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value ?? "");
    if(emailValid){
      return null;
    }else{
      return "Enter Valid Email..!!";
    }
  }

  void submitForm(BuildContext context){
    Navigator.pop(context, {
      'name': name.text,
      'mobile': mobileNumber.text,
      'birthDate': bDate.text,
      'email': email.text
    });
  }

  void dispose(){
    _myController.close();
  }
}