import 'dart:convert';

import 'package:dio/dio.dart';

class ApiCallScreenRepo {
  ApiCallScreenRepo();

  String url = "https://674d5d2d635bad45618aedf3.mockapi.io/flutterApiDemo";

  Future<List<Map<String, dynamic>>> getData() async {
    List<Map<String, dynamic>> dataList = [];
    var responce = await Dio().get(url);
    for (var i in responce.data) {
      dataList.add(i);
    }
    print("Datalist length : ${dataList.length}");
    return dataList;
  }

  Future<Map<String, dynamic>> getDataById(int id) async {
    var singleData = new Map<String, dynamic>();
    var responce = await Dio().get("$url/$id");
    singleData.addAll(responce.data);
    return singleData;
  }

  Future<bool> putData(int id, var data) async {
    await Dio().patch("$url/$id", data: jsonEncode(data));
    var responce = await Dio().get("$url/$id");
    print("Data :::::: " + responce.data.toString());
    return (responce.statusCode == 200);

  }

  Future<bool> deleteData(int id) async {
    var response = await Dio().delete("$url/$id");
    return true;
  }
}
