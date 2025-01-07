import 'package:dio/dio.dart';

import 'DemoDl.dart';

class PaginationScreenRepo {
  final Dio dio = Dio();
  final String url = "https://rickandmortyapi.com/api/character?page=";

  Future<TryDemoDl> fetchData(int page) async {
    try {
      final response = await dio.get("$url$page");
      return TryDemoDl.fromJson(response.data);
    } catch (e) {
      print("Failed to load data: $e");
      return TryDemoDl();
    }
  }
}
