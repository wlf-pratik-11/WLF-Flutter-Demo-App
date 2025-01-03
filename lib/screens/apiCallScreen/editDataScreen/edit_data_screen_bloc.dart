import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_app_demo/screens/apiCallScreen/api_call_screen_dl.dart';
import 'package:rxdart/rxdart.dart';

import '../api_call_screen_repo.dart';

class EditDataScreenBloc {
  EditDataScreenBloc(int id) {
    fetchDataById(id);
  }

  final ApiCallScreenRepo repo = ApiCallScreenRepo();
  final editDataScreenController = BehaviorSubject<String>();
  var singleData = new Map<String, dynamic>();
  final getDataByIdController = BehaviorSubject<Map<String, dynamic>>();
  final readOnlyTextFieldController = BehaviorSubject<bool>.seeded(true);
  bool readOnly = true;

  TextEditingController name = TextEditingController();
  TextEditingController bDate = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController imgUrl = TextEditingController();

  void fetchDataById(int id) async {
    singleData = await repo.getDataById(id);
    name.text = singleData['name'].toString();
    bDate.text = singleData['bDate'].toString();
    city.text = singleData['city'].toString();
    phone.text = singleData['mobileNum'].toString();
    email.text = singleData['email'].toString();
    address.text = singleData['address'].toString();
    imgUrl.text = singleData['image'].toString();
    getDataByIdController.sink.add(singleData);
  }

  void textFieldVisibility() {
    readOnly = !readOnly;
    readOnlyTextFieldController.sink.add(readOnly);
  }

  Future<void> updateData(int id, BuildContext context, dynamic widget) async {
    Map<String, dynamic> mapData = {
      "name": name.text,
      "bDate": bDate.text,
      "city": city.text,
      "mobileNum": phone.text,
      "email": email.text,
      "address": address.text,
      "image": imgUrl.text,
      "id": id.toString()
    };

    var data = ApiCallScreenDl.fromJson(mapData);
    bool isUpadeted = await repo.putData(id, data);
    if (isUpadeted) {
      await widget.refreshAllData?.call();
      if (context.mounted) Navigator.pop(context);
    }
  }

  Future<void> deleteDataFromApi(int id, BuildContext context, dynamic widget) async {
    bool isDeleted = await repo.deleteData(id);
    if (isDeleted) {
      await widget.refreshAllData?.call();
      if (context.mounted) Navigator.pop(context);
    }
  }
}
