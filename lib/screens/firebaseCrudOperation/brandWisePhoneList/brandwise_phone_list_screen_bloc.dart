import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/screens/firebaseCrudOperation/firebase_crud_screen_bloc.dart';

class BrandwisePhoneListScreenBloc {
  dynamic getFirebaseRef(int index) {
    final ref = FirebaseDatabase.instance.ref(FirebaseCrudScreenBloc().brandLogoList[index].brandName);
    return ref;
  }

  void deleteData(int index, BigInt itemKey, BuildContext context) async {
    final ref = await FirebaseDatabase.instance.ref(FirebaseCrudScreenBloc().brandLogoList[index].brandName);
    await ref.child("${itemKey}").remove().then(
      (value) {
        var snakBar = SnackBar(
          content: Text(
            "Record Deleted Successfully..!!",
            style: TextStyle(color: Colors.white, fontSize: snakbarFontsize, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black,
        );
        ScaffoldMessenger.of(context).showSnackBar(snakBar);
        Navigator.pop(context);
      },
    );
  }
}
