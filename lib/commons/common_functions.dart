import 'dart:ui';

import 'package:flutter/material.dart';

TextStyle appbarTextStyle() {
  return TextStyle(
    color: Colors.white,
  );
}

ListView drawerItem(List lstItem) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: lstItem.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(
          lstItem[index]["name"],
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
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
      Function()? onPressed}) {
  return Padding(
    padding: const EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15),
    child: TextFormField(
      obscureText: isPassword ?? false,
      controller: controller,
      decoration: InputDecoration(
        label: Text(
          fieldName,
          style: TextStyle(color: Colors.black),
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
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
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
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20,top: 20),
          child: Text(
            subTxt??"",
            style:
            TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    ),
  );
}
