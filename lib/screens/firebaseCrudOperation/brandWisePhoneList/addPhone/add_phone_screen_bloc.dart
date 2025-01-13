import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:main_app_demo/screens/firebaseCrudOperation/brandWisePhoneList/addPhone/add_phone_screen_dl.dart';
import 'package:main_app_demo/screens/firebaseCrudOperation/firebase_crud_screen_bloc.dart';

import '../../../../commons/common_functions.dart';

class AddPhoneScreenBloc {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController phoneName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController imgUrl = TextEditingController();

  void submitDataOrEdit(int index, BuildContext context, {BigInt? itemKey}) async {
    final ref = await FirebaseDatabase.instance.ref(FirebaseCrudScreenBloc().brandLogoList[index].brandName);
    if (itemKey != null) {
      await ref
          .child("${itemKey}")
          .update(
              (AddPhoneScreenDl(phoneName: phoneName.text, price: price.text, description: description.text, imgUrl: imgUrl.text)
                  .toJson()))
          .then(
        (value) {
          var snakBar = SnackBar(
            content: Text(
              "Record Edited Successfully..!!",
              style: TextStyle(color: Colors.white, fontSize: snakbarFontsize, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black,
          );
          ScaffoldMessenger.of(context).showSnackBar(snakBar);
        },
      );
    } else {
      await ref
          .child("${DateTime.now().millisecondsSinceEpoch}")
          .set((AddPhoneScreenDl(phoneName: phoneName.text, price: price.text, description: description.text, imgUrl: imgUrl.text)
              .toJson()))
          .then(
        (value) {
          var snakBar = SnackBar(
            content: Text(
              "Record Added Successfully..!!",
              style: TextStyle(color: Colors.white, fontSize: snakbarFontsize, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black,
          );
          ScaffoldMessenger.of(context).showSnackBar(snakBar);
        },
      );
    }
    Navigator.pop(context);
  }

  void getData(BigInt itemKey, int index) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(FirebaseCrudScreenBloc().brandLogoList[index].brandName);
    DatabaseEvent event = await ref.child("$itemKey").once();
    DataSnapshot snapshot = event.snapshot;
    print("Map Data =======================>>>>>>>>>>>>>>>${snapshot.value}");
    Map data = AddPhoneScreenDl.fromJson(snapshot.value).toJson();
    phoneName.text = data["phoneName"] ?? '';
    price.text = data["price"] ?? '';
    description.text = data["description"] ?? '';
    imgUrl.text = data["imgUrl"] ?? '';
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
