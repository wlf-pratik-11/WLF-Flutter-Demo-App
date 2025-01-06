import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:main_app_demo/screens/paginationScreen/pagination_screen_dl.dart';

class PaginationScreenRepo {
  PaginationScreenRepo();

  String url = "https://reqres.in/api/users?page=";

  var dio = Dio();

  Future<List<PaginationScreenDl>> fetchData(int page) async {
    List<PaginationScreenDl> lst = [];

    dynamic res = await dio.get(url + page.toString());

    var decodedJson = jsonDecode(res.toString());

    if (decodedJson["data"] is List) {
      lst = (decodedJson["data"] as List).map((item) => PaginationScreenDl.fromJson(item)).toList();
    }
    return lst;
  }
}
