import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/screens/paginationScreen/pagination_screen_repo.dart';

import '../../commons/my_colors.dart';

class PaginationScreen extends StatefulWidget {
  const PaginationScreen({super.key});

  @override
  State<PaginationScreen> createState() => _PaginationScreenState();
}

class _PaginationScreenState extends State<PaginationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Pagination Screen"),
      body: TextButton(
          onPressed: () {
            PaginationScreenRepo().fetchData();
          },
          child: Center(child: Text("Fetch Data"))),
    );
  }

  Widget _buildScreen() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: screenSizeRatio * 0.01, horizontal: screenSizeRatio * 0.02),
          child: Container(
            height: apiCallScreenListItemHeight,
            decoration: BoxDecoration(
              color: MyColors.darkBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.015),
                  child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTy36PamNFzO0zGn0xBejWv9y-flwXIYSJV1Q&s",
                    fit: BoxFit.cover,
                    height: screenSizeRatio * 0.42,
                    width: screenSizeRatio * 0.26,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.03, vertical: screenSizeRatio * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ABCDEFG",
                          overflow: TextOverflow.fade,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenSizeRatio * 0.025),
                        ),
                        Spacer(),
                        Text("ABCDEFG",
                            overflow: TextOverflow.fade,
                            style:
                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenSizeRatio * 0.025)),
                        Spacer(),
                        Text("ABCDEFG",
                            overflow: TextOverflow.fade,
                            style:
                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenSizeRatio * 0.025)),
                        Spacer(),
                        Text("ABCDEFG",
                            overflow: TextOverflow.fade,
                            style:
                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenSizeRatio * 0.025)),
                        Spacer(),
                        Text("ABCDEFG",
                            overflow: TextOverflow.fade,
                            style:
                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenSizeRatio * 0.025)),
                        Spacer(),
                        Text("ABCDEFG",
                            overflow: TextOverflow.fade,
                            style:
                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenSizeRatio * 0.025)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
