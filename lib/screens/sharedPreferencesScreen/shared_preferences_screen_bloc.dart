import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesScreenBloc {
  SharedPreferencesScreenBloc(){
   getItemList();
  }

  final myController = BehaviorSubject<List<String>>();

  Future<void> getItemList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? itemList = pref.getStringList('itemList');

    if (itemList != null) {
      print("Item List: $itemList");
      myController.sink.add(itemList);
    } else {
      myController.sink.add([]); // Emit an empty list if no data exists
    }
  }
  void dispose() {
    myController.close();
  }
}
