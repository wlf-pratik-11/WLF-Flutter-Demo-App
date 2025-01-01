import 'package:dio/dio.dart';

class ApiCallScreenRepo {
  ApiCallScreenRepo();

  List<Map<String, dynamic>> dataList = [];
  var singleData = new Map<String, dynamic>();

  Future<List<Map<String, dynamic>>> getData() async {
    var responce = await Dio().get("https://674d5d2d635bad45618aedf3.mockapi.io/flutterApiDemo");
    for (var i in responce.data) {
      dataList.add(i);
    }
    return dataList;
  }

  Future<Map<String, dynamic>> getDataById(int id) async {
    var responce = await Dio().get("https://674d5d2d635bad45618aedf3.mockapi.io/flutterApiDemo/$id");
    singleData.addAll(responce.data);
    return singleData;
  }
}
