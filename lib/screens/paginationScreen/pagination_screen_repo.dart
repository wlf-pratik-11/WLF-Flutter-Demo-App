import 'dart:convert';

import 'package:dio/dio.dart';

class PaginationScreenRepo {
  PaginationScreenRepo();

  String limitCount = "1";
  String url = "https://dummyjson.com/users?limit=";

  var dio = Dio();

  Future<void> fetchData() async {
    List lst = [];
    dynamic res = await dio.get(url + limitCount);
    // print(":::::::::::::::::::::::::DAta of Users :${res[1]["firstName"]}");
    final Map<String, dynamic> decodedJson = jsonDecode(res.toString());

    final List<dynamic> users = decodedJson['users'];
    final List<Map<String, dynamic>> extractedUsers = users.map((user) {
      return {
        "firstName": user['firstName'],
        "lastName": user['lastName'],
        "maidenName": user['maidenName'],
        "phone": user['phone'],
        "email": user['email'],
        "image": user['image'],
        "city": user['address']['city']
      };
    }).toList();

    print(extractedUsers);
  }
}
