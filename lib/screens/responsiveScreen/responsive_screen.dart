import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/commons/my_colors.dart';

class ResponsiveScreen extends StatefulWidget {
  const ResponsiveScreen({super.key});

  @override
  State<ResponsiveScreen> createState() => _ResponsiveScreenState();
}

class _ResponsiveScreenState extends State<ResponsiveScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: commonAppBar("Responsive Screen"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenSize.height*0.01,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screenSize.width * 0.025,
              ),
              Image.asset(
                "assets/images/demoimage.jpg",
                height: screenSize.height * 0.2,
                width: screenSize.width * 0.45,
              ),
              SizedBox(
                width: screenSize.width * 0.05,
              ),
              Image.asset(
                "assets/images/demoimage.jpg",
                height: screenSize.height * 0.2,
                width: screenSize.width * 0.45,
              ),
              SizedBox(
                width: screenSize.width * 0.025,
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: buttonFontsize,fontWeight:FontWeight.bold ),),
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.darkBlue,
                minimumSize: Size(screenSize.width *0.8,screenSize.height* 0.05), // Set minimum width and height
              ),
            ),
          ),
        ],
      ),
    );
  }
}
