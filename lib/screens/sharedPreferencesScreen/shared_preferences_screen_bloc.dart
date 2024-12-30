import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesScreenBloc {
  SharedPreferencesScreenBloc();

  final myController = BehaviorSubject<String>();

  Future<List<String>> getItemList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? itemList = pref.getStringList('itemList');

    if (itemList != null) {
      return itemList;
    } else {
      return [];
    }
  }
}
