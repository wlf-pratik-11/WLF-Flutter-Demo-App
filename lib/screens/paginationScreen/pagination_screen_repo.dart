import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:main_app_demo/screens/paginationScreen/pagination_screen_dl.dart';

class PaginationScreenRepo {
  final Dio dio = Dio();
  final String url = "https://reqres.in/api/users?page=";

  Future<List<PaginationScreenDl>> fetchData(int page) async {
    try {
      final response = await dio.get("$url$page");
      final data = response.data['data'] as List;
      return data.map((json) => PaginationScreenDl.fromJson(json)).toList();
    } catch (e) {
      print("Failed to load data");
      return [];
    }
  }
}

