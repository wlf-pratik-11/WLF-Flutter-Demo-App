import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/commons/multi_language_strings.dart';
import 'package:main_app_demo/commons/my_colors.dart';

class FormForNavigator extends StatefulWidget {
  const FormForNavigator({super.key});

  @override
  State<FormForNavigator> createState() => _FormForNavigatorState();
}

class _FormForNavigatorState extends State<FormForNavigator> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _name= TextEditingController();
  TextEditingController _mobileNumber = TextEditingController();
  TextEditingController _bDate = TextEditingController();
  TextEditingController _email = TextEditingController();

  String? _emailError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
            MultiLanguageStrings.fillFormForNavigator,
            style: appbarTextStyle(),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: MyColors.darkBlue,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemStatusBarContrastEnforced: true,
            // statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          )),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                    label: Text(
                      "Enter Your Name :",
                      style: TextStyle(color: MyColors.darkBlue),
                    ),
                    prefixIcon: Icon(Icons.account_circle_outlined),
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    iconColor: MyColors.darkBlue,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: MyColors.darkBlue, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: MyColors.darkBlue, width: 2),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: MyColors.darkBlue, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: MyColors.darkBlue, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return "Enter your name..!";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: IntlPhoneField(
                  controller: _mobileNumber,
                  showCountryFlag: false,
                  dropdownTextStyle: TextStyle(fontSize: 17),
                  decoration: InputDecoration(
                    label: Text(
                      "Mobile Number :",
                      style: TextStyle(color: MyColors.darkBlue),
                    ),
                    prefixIcon: Icon(Icons.phone),
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    iconColor: MyColors.darkBlue,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: MyColors.darkBlue, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: MyColors.darkBlue, width: 2),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: MyColors.darkBlue, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: MyColors.darkBlue, width: 2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: TextFormField(
                  controller: _bDate,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      helpText: "Select BirthDate",
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2030),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _bDate.text = DateFormat("dd-MM-yyyy").format(pickedDate);
                      });
                    }
                  },
                  decoration: InputDecoration(
                    label: Text("Birth Date",
                        style: TextStyle(color: MyColors.darkBlue)),
                    prefixIcon: Icon(Icons.date_range),
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    iconColor: MyColors.darkBlue,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: MyColors.darkBlue, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: MyColors.darkBlue, width: 2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                    label: Text("Your Email :",
                        style: TextStyle(color: MyColors.darkBlue)),
                    prefixIcon: Icon(Icons.email_outlined),
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    iconColor: MyColors.darkBlue,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: MyColors.darkBlue, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: MyColors.darkBlue, width: 2),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: MyColors.darkBlue, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: MyColors.darkBlue, width: 2),
                    ),
                  ),
                  validator: (value) {
                    // Real-time email validation
                    if (!EmailValidator.validate(_email.text)) {
                      return "Invalid Email..!";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: ElevatedButton(
                    onPressed: () {
                      // Pass the data back to the previous screen
                      if(_formKey.currentState!.validate())
                      {
                        Navigator.pop(context, {
                          'name': _name.text,
                          'mobile': _mobileNumber.text,
                          'birthDate': _bDate.text,
                          'email': _email.text
                        });
                      }
                      else{
                        print("Not Valivalidate..!!!");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.darkBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
