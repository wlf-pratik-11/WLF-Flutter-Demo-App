import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import 'my_colors.dart';

Size? screenSize;
commonFontSizes(BuildContext context){
  screenSize = MediaQuery.sizeOf(context);
}

var screenSizeRatio = ((screenSize!.height+screenSize!.width)/2);

var drawerWidth = ((screenSize!.height+screenSize!.width)/2)*0.4;

//Text Sizes
var buttonFontsize = ((screenSize!.height+screenSize!.width)/2)*0.035;
var descriptionFontsize = ((screenSize!.height+screenSize!.width)/2)*0.027;
var tabbarFontsize = ((screenSize!.height+screenSize!.width)/2)*0.035;
var textfieldTitleFontsize = ((screenSize!.height+screenSize!.width)/2)*0.028;
var drawerTextFontsize = ((screenSize!.height+screenSize!.width)/2)*0.025 ;
var tabbarTitleTextFontsize = ((screenSize!.height+screenSize!.width)/2)*0.025;
var alertDilogeTextFontsize = ((screenSize!.height+screenSize!.width)/2)*0.03;
var cardTitleTextFontsize = ((screenSize!.height+screenSize!.width)/2)*0.033;
var cardSubTextFontsize = ((screenSize!.height+screenSize!.width)/2)*0.026;
var snakbarFontsize = ((screenSize!.height+screenSize!.width)/2)*0.027;

//Card Sizes

var cardHeight = ((screenSize!.height+screenSize!.width)/2)*0.1;


//Icon Sizes

var iconSize = ((screenSize!.height+screenSize!.width)/2)*0.04;


//Container Sizes

var apiCallScreenListItemHeight = ((screenSize!.height+screenSize!.width)/2)*0.45;


AppBar commonAppBar(String title,{List<Widget>? actions}){
  return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontSize: tabbarFontsize,
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
      actions: actions ?? []  ,
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: MyColors.darkBlue,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemStatusBarContrastEnforced: true,
      ));
}

ListView drawerItem(List lstItem) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: lstItem.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(
          lstItem[index]["name"],
          style: TextStyle(fontSize: drawerTextFontsize, fontWeight: FontWeight.w800),
        ),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => lstItem[index]["route"]));
        },
      );
    },
  );
}

Widget inputField(String fieldName, TextEditingController controller,
    {Function(String value)? validator,
      bool showEyeIcon = false,
      bool? isPassword,
      Function()? onPressed,bool? isNumber}) {
  return Padding(
    padding: const EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15),
    child: TextFormField(
      obscureText: isPassword ?? false,
      controller: controller,
      keyboardType:isNumber??false ? TextInputType.number:TextInputType.text,
      maxLength: isNumber??false ? 10:null,
      decoration: InputDecoration(
        label: Text(
          fieldName,
          style: TextStyle(color: Colors.black,fontSize: textfieldTitleFontsize),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black26, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        errorStyle: TextStyle(color: Colors.red),
        suffixIcon: showEyeIcon
            ? IconButton(
          color: Colors.black38,
          icon: Icon(Icons.remove_red_eye_outlined),
          onPressed: () {
            onPressed?.call();
          },
          splashRadius: 5,
          highlightColor: Colors.deepPurpleAccent.withOpacity(0.3),
        )
            : null,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return validator?.call(value ?? "");
      },
    ),
  );
}

Widget commonButton(String text, {Function()? buttonStatusFun}) {
  return Container(
    width: double.maxFinite,
    padding: EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15),
    child: ElevatedButton(
      onPressed: buttonStatusFun,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: buttonFontsize),
        ),
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurpleAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          disabledBackgroundColor: Colors.deepPurpleAccent.withOpacity(0.5)),
    ),
  );
}

Widget sliderView(String mainTxt,String? subTxt,String? img){
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(img??""),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Text(
            mainTxt,
            style: TextStyle(
                color: Color.fromRGBO(36, 74, 78, 1.0),
                fontSize: tabbarFontsize,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20,top: 20),
          child: Text(
            subTxt??"",
            style:
            TextStyle(fontSize: descriptionFontsize, color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    ),
  );
}
