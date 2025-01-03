import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main_app_demo/commons/common_functions.dart';

import '../../../commons/my_colors.dart';
import 'add_data_screen_bloc.dart';

class AddDataScreen extends StatefulWidget {
  final Function()? refreshAllData;
  const AddDataScreen({super.key, this.refreshAllData});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  AddDataScreenBloc _bloc = AddDataScreenBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar("Add Data Screen"),
      body: _buildScreen(_bloc),
    );
  }

  Widget _buildScreen(AddDataScreenBloc _bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _bloc.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  inputField(
                    "Name",
                    _bloc.name,
                    validator: (value) {
                      return _bloc.nameValidate(value);
                    },
                  ),
                  inputField(
                    "Birth Date",
                    _bloc.bDate,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context, initialDate: DateTime.now(), firstDate: DateTime(1990), lastDate: DateTime.now());
                      if (pickedDate == null) return;
                      _bloc.bDate.text = DateFormat("dd-MM-yyyy").format(pickedDate);
                    },
                    validator: (value) {
                      return _bloc.birthDateValidate(value);
                    },
                  ),
                  inputField(
                    "City",
                    _bloc.city,
                    validator: (value) {
                      return _bloc.cityValidate(value);
                    },
                  ),
                  inputField(
                    "Phone Number",
                    _bloc.phone,
                    isNumber: true,
                    validator: (value) {
                      return _bloc.mobileNumberValidate(value);
                    },
                  ),
                  inputField(
                    "Email",
                    _bloc.email,
                    validator: (value) {
                      return _bloc.emailValidate(value);
                    },
                  ),
                  inputField(
                    "Image URL",
                    _bloc.imgUrl,
                    validator: (value) {
                      return _bloc.imgUrlValidate(value);
                    },
                  ),
                  inputField(
                    "Address",
                    _bloc.address,
                    validator: (value) {
                      return _bloc.addressValidate(value);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenSizeRatio * 0.03, horizontal: screenSizeRatio * 0.025),
          child: ElevatedButton(
            onPressed: () {
              if (_bloc.valiDateForm()) {
                _bloc.saveDatainApi(widget, context);
                final snakBar = SnackBar(
                  content: Text(
                    "Data Saved successfully..!!",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: snakbarFontsize),
                  ),
                  backgroundColor: Colors.black,
                );
                ScaffoldMessenger.of(context).showSnackBar(snakBar);
              }
            },
            child: Text(
              "Save",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: buttonFontsize,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10),
              minimumSize: Size(double.infinity, 50), // Full width
              backgroundColor: MyColors.darkBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 3,
            ),
          ),
        ),
      ],
    );
  }
}
