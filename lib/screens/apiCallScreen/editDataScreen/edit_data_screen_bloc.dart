import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import '../api_call_screen_repo.dart';

class EditDataScreenBloc {
  EditDataScreenBloc() {}

  final ApiCallScreenRepo repo = ApiCallScreenRepo();
  final editDataScreenController = BehaviorSubject<String>();
  var singleData = new Map<String, dynamic>();
  final getDataByIdController = BehaviorSubject<Map<String, dynamic>>();

  TextEditingController name = TextEditingController();
  TextEditingController bDate = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController imgUrl = TextEditingController();

  void fetchDataById(int id) async {
    singleData = await repo.getDataById(id);
    getDataByIdController.sink.add(singleData);
  }
}
