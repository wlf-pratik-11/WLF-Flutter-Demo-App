import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/screens/firebaseCrudOperation/brandWisePhoneList/addPhone/add_phone_screen_bloc.dart';
import 'package:main_app_demo/screens/firebaseCrudOperation/firebase_crud_screen_bloc.dart';

class AddPhoneScreen extends StatefulWidget {
  final index;
  final itemKey;
  AddPhoneScreen(this.index, {this.itemKey, super.key});

  @override
  State<AddPhoneScreen> createState() => _AddPhoneScreenState();
}

class _AddPhoneScreenState extends State<AddPhoneScreen> {
  AddPhoneScreenBloc _bloc = AddPhoneScreenBloc();
  @override
  Widget build(BuildContext context) {
    (widget.itemKey != null ? _bloc.getData(widget.itemKey, widget.index) : null);
    return Scaffold(
      appBar: widget.itemKey == null
          ? commonAppBar("Add ${FirebaseCrudScreenBloc().brandLogoList[widget.index].brandName} Phone")
          : commonAppBar("Edit ${FirebaseCrudScreenBloc().brandLogoList[widget.index].brandName} Phone"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _bloc.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    inputField(
                      "Phone Name",
                      _bloc.phoneName,
                      validator: (value) {
                        return _bloc.validatePhoneName();
                      },
                    ),
                    inputField("Price", _bloc.price, validator: (value) {
                      return _bloc.validatePrice();
                    }, isNumber: true),
                    inputField(
                      "Image URL",
                      _bloc.imgUrl,
                      validator: (value) {
                        return _bloc.validatePhoneImgUrl();
                      },
                    ),
                    inputField(
                      "Description",
                      _bloc.description,
                      validator: (value) {
                        return _bloc.validatePhoneDesc();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeRatio * 0.05, horizontal: screenSizeRatio * 0.03),
            child: darkBlueCommonButton(widget.itemKey == null ? "Submit" : "Submit Edited Data", onPressed: () {
              if (_bloc.validateForm()) {
                return widget.itemKey == null
                    ? _bloc.submitDataOrEdit(widget.index, context)
                    : _bloc.submitDataOrEdit(widget.index, context, itemKey: widget.itemKey);
              }
            }),
          )
        ],
      ),
    );
  }
}
