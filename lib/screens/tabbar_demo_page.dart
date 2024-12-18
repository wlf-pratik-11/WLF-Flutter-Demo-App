import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_app_demo/screens/form_for_navigator.dart';

import '../commons/common_functions.dart';
import '../commons/multi_language_strings.dart';
import '../commons/my_colors.dart';

class TabbarDemoPage extends StatefulWidget {
  const TabbarDemoPage({super.key});

  @override
  State<TabbarDemoPage> createState() => _TabbarDemoPageState();
}

class _TabbarDemoPageState extends State<TabbarDemoPage> {
  String name = '';
  String mobile = '';
  String birthDate = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              MultiLanguageStrings.tabBarDemo,
              style: appbarTextStyle(),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: MyColors.darkBlue,
            systemOverlayStyle: SystemUiOverlayStyle(
              systemStatusBarContrastEnforced: true,
              // statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  // icon: Icon(
                  //   Icons.home,
                  //   color: Colors.white,
                  //   size: 30,
                  child: Text(
                    "Dialog Box",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Tab(
                    // icon: Icon(
                    //   Icons.account_balance,
                    //   color: Colors.white,
                    //   size: 30,
                    // ),
                    child: Text(
                  "Bottom Sheet",
                  style: TextStyle(color: Colors.white),
                )),
                Tab(
                    // icon: Icon(
                    //   Icons.account_box,
                    //   color: Colors.white,
                    //   size: 30,
                    // ),
                    child: Text(
                  "Navigator",
                  style: TextStyle(color: Colors.white),
                ))
              ],
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          body: TabBarView(children: [
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Close",
                                    style: TextStyle(
                                      color: Colors.white,
                                    )))
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
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      sheetAnimationStyle:
                          AnimationStyle(duration: Duration(seconds: 1)),
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
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 40, 0, 0),
                                    child: Text("Close",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18)),
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
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 35, 0, 25),
                  child: ElevatedButton(
                      onPressed: () {
                        _navigateAndGetDAtaFromForm(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.darkBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      child: Text(
                        "Fill Form",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
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
                    style: TextStyle(
                        color: MyColors.darkBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Name : ${name}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Mobile No : $mobile",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Birth Date : $birthDate",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Email : $email",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,30,0,0),
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Edit Data",
                          style: TextStyle(color: Colors.white),
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
                )
                ,
              ],
            )
          ]),
        ));
  }

  Future<void> _navigateAndGetDAtaFromForm(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FormForNavigator(),
        ));

    if (!context.mounted) return;

    if (result != null) {
      setState(() {
        name = result['name'];
        mobile = result['mobile'];
        birthDate = result['birthDate'];
        email = result['email'];
      });
    }
  }
}
