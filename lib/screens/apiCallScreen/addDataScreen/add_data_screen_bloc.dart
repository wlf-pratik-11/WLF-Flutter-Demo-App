import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../api_call_screen_repo.dart';

class AddDataScreenBloc {
  AddDataScreenBloc();

  final addDataScreenController = BehaviorSubject<String>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ApiCallScreenRepo repo = ApiCallScreenRepo();

  TextEditingController name = TextEditingController();
  TextEditingController bDate = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController imgUrl = TextEditingController();

  String? nameValidate(String value) {
    if (value.isEmpty || value.length < 6) {
      return "Enter Full Name.";
    }
    return null;
  }

  String? birthDateValidate(String value) {
    if (bDate.text.isEmpty) {
      return "Please select your birth date.";
    }
    return null;
  }

  String? mobileNumberValidate(String value) {
    if (phone.text.isEmpty) {
      return "Please enter your mobile number.";
    }
    return null;
  }

  String? cityValidate(String value) {
    if (value.isEmpty) {
      return "Enter Your City";
    }
    return null;
  }

  String? emailValidate(String value) {
    final emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value.isEmpty) {
      return "Enter Your Email";
    } else if (!emailValid.hasMatch(value)) {
      return "Enter Valid Email";
    }
    return null;
  }

  String? imgUrlValidate(String value) {
    if (value.isEmpty) {
      return "Enter Imag Url";
    }
    return null;
  }

  String? addressValidate(String value) {
    if (value.isEmpty || value.length < 6) {
      return "Enter Your Full Address";
    }
    return null;
  }

  bool valiDateForm() {
    if (formKey.currentState?.validate() ?? false) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> saveDatainApi(dynamic widget, BuildContext context) async {
    Map<String, dynamic> mapData = {
      "name": name.text,
      "bDate": bDate.text,
      "city": city.text,
      "mobileNum": phone.text,
      "email": email.text,
      "address": address.text,
      "image": imgUrl.text,
    };
    bool isDataSaved = await repo.postData(mapData);
    if (isDataSaved) {
      await widget.refreshAllData?.call();
      if (context.mounted) Navigator.pop(context);
    }
    print(":::::::::::::::Data to be Svaed : ${isDataSaved}:::::::::::::::::::::::");
  }
}
