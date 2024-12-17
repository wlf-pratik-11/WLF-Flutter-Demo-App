import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../commons/common_functions.dart';
import '../commons/multi_language_strings.dart';
import '../commons/my_colors.dart';

class TabbarDemoPage extends StatelessWidget {
  const TabbarDemoPage({super.key});

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
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.account_balance,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.account_box,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          body: TabBarView(children: [
            Center(
              child: ElevatedButton(onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,15,0,0),
                            child: Text("This Is Home Page..!!"),
                          ),
                          TextButton(onPressed: () {
                            Navigator.pop(context);
                          }, child: Text("Close",style: TextStyle(color: MyColors.darkBlue,)))
                        ],
                      ),
                    ),
                );
              },
                  style: ElevatedButton.styleFrom(backgroundColor: MyColors.darkBlue,),
              child: Text("Home Page",style: TextStyle(color: Colors.white,fontSize: 20),)),
            ),
            Center(
              child: Text("Account Balance"),
            ),
            Center(
              child: Text("Account Box"),
            )
          ]),
        ));
  }
}
