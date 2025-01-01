import 'package:main_app_demo/screens/apiCallScreen/api_call_screen_repo.dart';
import 'package:rxdart/rxdart.dart';

class ApiCallScreenBloc {
  ApiCallScreenBloc() {
    fetchData();
    print(":::::::::::::: Fetch Data is called :::::::::::::::");
  }

  final ApiCallScreenRepo repo = ApiCallScreenRepo();
  final myController = BehaviorSubject<List<Map<String, dynamic>>>();
  final getDataByIdController = BehaviorSubject<Map<String, dynamic>>();
  List<Map<String, dynamic>> dataList = [];

  void fetchData() async {
    dataList = await repo.getData();
    myController.sink.add(dataList);
  }
}
