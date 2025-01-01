import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';

import '../../../commons/my_colors.dart';
import 'edit_data_screen_bloc.dart';

class EditDataScreen extends StatefulWidget {
  const EditDataScreen({super.key, required int id});

  @override
  State<EditDataScreen> createState() => _EditDataScreenState();
}

class _EditDataScreenState extends State<EditDataScreen> {
  EditDataScreenBloc _bloc = EditDataScreenBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar("Your Information"),
      body: _buildScreen(),
    );
  }

  _buildScreen() {
    return StreamBuilder<String>(
        stream: null,
        builder: (context, snapshot) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                inputField("Name", _bloc.name),
                inputField("Birth Date", _bloc.bDate),
                inputField("City", _bloc.city),
                inputField("Phone Number", _bloc.phone, isNumber: true),
                inputField("Email", _bloc.email),
                inputField("Image URL", _bloc.imgUrl),
                inputField("Address", _bloc.address),
                Padding(
                  padding: EdgeInsets.only(top: screenSizeRatio * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: buttonFontsize,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsetsDirectional.symmetric(horizontal: 0, vertical: 10),
                          minimumSize: Size(screenSizeRatio * 0.25, screenSizeRatio * 0.05),
                          backgroundColor: MyColors.darkBlue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 3,
                        ),
                      ),
                      SizedBox(
                        width: screenSizeRatio * 0.03,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: buttonFontsize,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsetsDirectional.symmetric(horizontal: 0, vertical: 10),
                          minimumSize: Size(screenSizeRatio * 0.25, screenSizeRatio * 0.05),
                          backgroundColor: MyColors.darkBlue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
