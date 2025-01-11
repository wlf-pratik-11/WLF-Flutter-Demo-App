import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/commons/my_colors.dart';
import 'package:main_app_demo/screens/firebaseCrudOperation/brandWisePhoneList/brandwise_phone_list_screen.dart';
import 'package:main_app_demo/screens/firebaseCrudOperation/firebase_crud_screen_bloc.dart';

class FirebaseCrudScreen extends StatefulWidget {
  const FirebaseCrudScreen({super.key});

  @override
  State<FirebaseCrudScreen> createState() => _FirebaseCrudScreenState();
}

class _FirebaseCrudScreenState extends State<FirebaseCrudScreen> {
  FirebaseCrudScreenBloc _bloc = FirebaseCrudScreenBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Firebase Database CRUD"),
      body: ListView.builder(
        itemCount: _bloc.brandLogoList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeRatio * 0.02, horizontal: screenSizeRatio * 0.05),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => BrandwisePhoneListScreen(index)));
              },
              child: Card(
                color: Colors.white,
                elevation: 8,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${_bloc.brandLogoList[index].brandName}  |",
                      style: TextStyle(fontSize: screenSizeRatio * 0.03, fontWeight: FontWeight.bold, color: MyColors.darkBlue),
                    ),
                    SizedBox(
                      width: screenSizeRatio * 0.03,
                    ),
                    SizedBox(
                      height: screenSizeRatio * 0.1,
                      width: screenSizeRatio * 0.1,
                      child: Image.asset(
                        _bloc.brandLogoList[index].path,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
