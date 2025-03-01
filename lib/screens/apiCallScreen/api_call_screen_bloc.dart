import 'package:flutter/material.dart';
import 'package:main_app_demo/screens/apiCallScreen/addDataScreen/add_data_screen.dart';
import 'package:main_app_demo/screens/apiCallScreen/api_call_screen_repo.dart';
import 'package:rxdart/rxdart.dart';

import 'editDataScreen/edit_data_screen.dart';

class ApiCallScreenBloc {
  ApiCallScreenBloc() {
    fetchData();
  }

  final ApiCallScreenRepo repo = ApiCallScreenRepo();
  final myController = BehaviorSubject<List<Map<String, dynamic>>>();
  final getDataByIdController = BehaviorSubject<Map<String, dynamic>>();

  void fetchData() async {
    myController.sink.add([]);
    List<Map<String, dynamic>> dataList = await repo.getData();
    myController.sink.add(dataList);
  }

  void goToEditDataScreen(
    BuildContext context,
    int id,
  ) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return EditDataScreen(
          id: id,
          refreshAllData: () {
            print(":::::::::::::::::::::::::::::::Data Refereshed:::::::::::::::::::::::");
            fetchData();
          },
        );
      },
    ));
  }

  void goToAddDataScreen(
    BuildContext context,
  ) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return AddDataScreen(
          refreshAllData: () {
            print(":::::::::::::::::::::::::::::::Data Refereshed:::::::::::::::::::::::");
            fetchData();
          },
        );
      },
    ));
  }
}
