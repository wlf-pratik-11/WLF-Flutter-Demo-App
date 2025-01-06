import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/screens/paginationScreen/pagination_screen_bloc.dart';
import 'package:main_app_demo/screens/paginationScreen/pagination_screen_dl.dart';

import '../../commons/my_colors.dart';

class PaginationScreen extends StatefulWidget {
  const PaginationScreen({super.key});

  @override
  State<PaginationScreen> createState() => _PaginationScreenState();
}

class _PaginationScreenState extends State<PaginationScreen> {
  PaginationScreenBloc _bloc = PaginationScreenBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: commonAppBar("Pagination Screen"), body: _buildScreen(_bloc));
  }

  Widget _buildScreen(PaginationScreenBloc _bloc) {
    return StreamBuilder<List<dynamic>>(
        stream: _bloc.paginationScreenBlocController,
        builder: (context, snapshot) {
          return PagedListView(
              pagingController: _bloc.pagingController,
              builderDelegate: PagedChildBuilderDelegate<PaginationScreenDl>(
                itemBuilder: (context, item, index) {
                  print("::::::::::::::::::Image : ${item.avatar}::::::::::::::::::::::::");
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
                              "${item.avatar}",
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
                                  Spacer(),
                                  Text(
                                    " ${item.firstName} ${item.lastName} ",
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenSizeRatio * 0.025),
                                  ),
                                  SizedBox(
                                    height: screenSizeRatio * 0.02,
                                  ),
                                  Text("E-mail : ${item.email}",
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenSizeRatio * 0.025)),
                                  Spacer(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ));
        });
  }
}
