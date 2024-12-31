import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_app_demo/screens/tabbarDemo/formForNavigatorDemo/form_for_navigator_screen.dart';
import 'package:main_app_demo/screens/tabbarDemo/tabbar_screen_block.dart';

import '../../commons/common_functions.dart';
import '../../commons/multi_language_strings.dart';
import '../../commons/my_colors.dart';

class TabbarDemoPage extends StatefulWidget {
  const TabbarDemoPage({super.key});

  @override
  State<TabbarDemoPage> createState() => _TabbarDemoPageState();
}

class _TabbarDemoPageState extends State<TabbarDemoPage> {
  final TabbarScreenBlock _bloc = TabbarScreenBlock();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              MultiLanguageStrings.tabBarDemo,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: MyColors.darkBlue,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemStatusBarContrastEnforced: true,
              // statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "Dialog Box",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: tabbarTitleTextFontsize),
                  ),
                ),
                Tab(
                  child: Text(
                    "BottomSheet",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: tabbarTitleTextFontsize),
                  ),
                ),
                Tab(
                  child: Text(
                    "Navigation",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: tabbarTitleTextFontsize),
                  ),
                ),
              ],
              indicatorColor: Colors.white,
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          shadowColor: Colors.black,
                          backgroundColor: MyColors.darkBlue,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: Text(
                                  "This Is Home Page..!!",
                                  style: TextStyle(color: Colors.white, fontSize: alertDilogeTextFontsize),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Close",
                                  style: TextStyle(
                                    color: Colors.white,
                                      fontSize: alertDilogeTextFontsize
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.darkBlue,
                    ),
                    child: Text(
                      "Home Page",
                      style: TextStyle(color: Colors.white, fontSize: buttonFontsize),
                    )),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        sheetAnimationStyle: AnimationStyle(duration: Duration(seconds: 1)),
                        context: context,
                        builder: (context) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: MyColors.darkBlue,
                            ),
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Your Balance is : 54600",
                                    style: TextStyle(fontSize: alertDilogeTextFontsize, color: Colors.white),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                                      child: Text("Close", style: TextStyle(color: Colors.white, fontSize: alertDilogeTextFontsize)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.darkBlue,
                    ),
                    child: Text(
                      "Cheak Account Balance",
                      style: TextStyle(color: Colors.white, fontSize: buttonFontsize),
                    )),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 35, 0, 25),
                    child: ElevatedButton(
                        onPressed: () {
                          _bloc.navigateAndGetDAtaFromForm(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.darkBlue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                        child: Text(
                          "Fill Form",
                          style: TextStyle(fontSize: buttonFontsize, color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                  Divider(
                    color: Colors.black54,
                    thickness: 2.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      "Form Data",
                      style: TextStyle(color: MyColors.darkBlue, fontWeight: FontWeight.bold, fontSize: buttonFontsize),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: StreamBuilder(
                      stream: _bloc.myStream,
                      builder: (context, myStream) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Name :",
                                style: TextStyle(fontSize: descriptionFontsize),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Mobile No :" + _bloc.mobile,
                                style: TextStyle(fontSize: descriptionFontsize),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Birth Date :" + _bloc.birthDate,
                                style: TextStyle(fontSize: descriptionFontsize),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Email :" + _bloc.email,
                                style: TextStyle(fontSize: descriptionFontsize),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            "Edit Data",
                            style: TextStyle(color: Colors.white,fontSize: buttonFontsize),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.darkBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
