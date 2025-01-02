import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_app_demo/commons/common_functions.dart';

import '../../../commons/my_colors.dart';
import 'edit_data_screen_bloc.dart';

class EditDataScreen extends StatefulWidget {
  final int id;
  final Function()? refreshAllData;
  const EditDataScreen({super.key, required this.id, this.refreshAllData});

  @override
  State<EditDataScreen> createState() => _EditDataScreenState();
}

class _EditDataScreenState extends State<EditDataScreen> {
  @override
  Widget build(BuildContext context) {
    final EditDataScreenBloc _bloc = EditDataScreenBloc(widget.id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar("Your Information"),
      body: _buildScreen(_bloc, widget.id, context),
    );
  }

  _buildScreen(EditDataScreenBloc _bloc, int id, BuildContext context) {
    return StreamBuilder<String>(
        stream: _bloc.editDataScreenController,
        builder: (context, snapshot) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: StreamBuilder<bool>(
                stream: _bloc.readOnlyTextFieldController,
                builder: (context, readOnly) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      inputField("Name", _bloc.name, readOnly: readOnly.data),
                      inputField("Birth Date", _bloc.bDate, readOnly: readOnly.data),
                      inputField("City", _bloc.city, readOnly: readOnly.data),
                      inputField("Phone Number", _bloc.phone, isNumber: true, readOnly: readOnly.data),
                      inputField("Email", _bloc.email, readOnly: readOnly.data),
                      inputField("Image URL", _bloc.imgUrl, readOnly: readOnly.data),
                      inputField("Address", _bloc.address, readOnly: readOnly.data),
                      Padding(
                        padding: EdgeInsets.only(top: screenSizeRatio * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: (){
                                _bloc.textFieldVisibility();
                                if (readOnly.data == false) {
                                   _bloc.updateData(id,context,widget);
                                   final snakBar = SnackBar(
                                     content: Text(
                                       "Data updated successfully..!!",
                                       style: TextStyle(
                                           color: Colors.white, fontWeight: FontWeight.bold, fontSize: snakbarFontsize),
                                     ),
                                     backgroundColor: Colors.black,
                                   );
                                   ScaffoldMessenger.of(context).showSnackBar(snakBar);
                                }
                              },
                              child: Text(
                                (readOnly.data ?? true) ? "Edit" : "Save",
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
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) => AlertDialog(
                                    title: Text("Are sure want to delete: ${_bloc.name.text} data ?"),
                                    backgroundColor: MyColors.darkBlue,
                                    titleTextStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: alertDilogeTextFontsize,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: GoogleFonts.nunito().fontFamily,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, 'Cancel'),
                                        child: Text('Cancel',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: alertDilogeTextFontsize,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: GoogleFonts.nunito().fontFamily,
                                            )),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _bloc.deleteDataFromApi(id, context,widget);
                                          Navigator.pop(context);
                                          final snakBar = SnackBar(
                                            content: Text(
                                              "Data deleted successfully..!!",
                                              style: TextStyle(
                                                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: snakbarFontsize),
                                            ),
                                            backgroundColor: Colors.black,
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snakBar);
                                        },
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: alertDilogeTextFontsize,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: GoogleFonts.nunito().fontFamily,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
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
                  );
                }),
          );
        });
  }
}
