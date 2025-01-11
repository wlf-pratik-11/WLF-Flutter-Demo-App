import 'package:firebase_database/firebase_database.dart';
import 'package:main_app_demo/screens/firebaseCrudOperation/firebase_crud_screen_bloc.dart';

class BrandwisePhoneListScreenBloc {
  dynamic getFirebaseRef(int index) {
    final ref = FirebaseDatabase.instance.ref(FirebaseCrudScreenBloc().brandLogoList[index].brandName);
    return ref;
  }
}
