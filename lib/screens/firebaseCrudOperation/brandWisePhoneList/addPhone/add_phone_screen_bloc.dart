import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:main_app_demo/screens/firebaseCrudOperation/brandWisePhoneList/addPhone/add_phone_screen_dl.dart';
import 'package:main_app_demo/screens/firebaseCrudOperation/firebase_crud_screen_bloc.dart';

class AddPhoneScreenBloc {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController phoneName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController imgUrl = TextEditingController();

  void submitData(int index, BuildContext context) async {
    final ref = await FirebaseDatabase.instance.ref(FirebaseCrudScreenBloc().brandLogoList[index].brandName);
    await ref.child("${DateTime.now().millisecondsSinceEpoch}").set(
        (AddPhoneScreenDl(phoneName: phoneName.text, price: price.text, description: description.text, imgUrl: imgUrl.text)
            .toJson()));
    Navigator.pop(context);
  }

  String? validatePhoneName() {
    if (phoneName.text.isEmpty || phoneName.text.length < 6) {
      return "Enter Valid Phone Name";
    }
    return null;
  }

  String? validatePrice() {
    if (price.text.isEmpty || price.text.length > 7) {
      return "Enter Valid Phone Price";
    }
    return null;
  }

  String? validatePhoneDesc() {
    if (description.text.isEmpty) {
      return "Enter Valid description";
    }
    return null;
  }

  String? validatePhoneImgUrl() {
    if (phoneName.text.isEmpty) {
      return "Enter Valid Phone Image URL";
    }
    return null;
  }

  bool validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      return true;
    } else {
      return false;
    }
  }
}
