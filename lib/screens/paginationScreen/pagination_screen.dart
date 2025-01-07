import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/screens/paginationScreen/DemoDl.dart';
import 'package:main_app_demo/screens/paginationScreen/pagination_screen_bloc.dart';

import '../../commons/my_colors.dart';

class PaginationScreen extends StatefulWidget {
  const PaginationScreen({super.key});

  @override
  State<PaginationScreen> createState() => _PaginationScreenState();
}

class _PaginationScreenState extends State<PaginationScreen> {
  final PaginationScreenBloc _bloc = PaginationScreenBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Pagination Screen"),
      body: _buildView(),
    );
  }

  Widget _buildView() {
    return PagedListView<int, Results>(
      pagingController: _bloc.pagingController,
      builderDelegate: PagedChildBuilderDelegate<Results>(
        itemBuilder: (context, item, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenSizeRatio * 0.01,
              horizontal: screenSizeRatio * 0.02,
            ),
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
                      item.image ?? "",
                      fit: BoxFit.cover,
                      height: screenSizeRatio * 0.42,
                      width: screenSizeRatio * 0.26,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSizeRatio * 0.03,
                        vertical: screenSizeRatio * 0.03,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Text(
                            "Name : ${item.name} ",
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: screenSizeRatio * 0.025,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Location: ${item.location?.name}",
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: screenSizeRatio * 0.025,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Status: ${item.status}",
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: screenSizeRatio * 0.025,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Created: ${item.created}",
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: screenSizeRatio * 0.025,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Gender: ${item.gender}",
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: screenSizeRatio * 0.025,
                            ),
                          ),
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
        firstPageProgressIndicatorBuilder: (context) {
          return Center(
            child: LoadingAnimationWidget.threeRotatingDots(color: MyColors.darkBlue, size: screenSizeRatio * 0.1),
          );
        },
        firstPageErrorIndicatorBuilder: (context) => const Center(child: Text("Error in Loading First Page")),
        noMoreItemsIndicatorBuilder: (context) => const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: Text('Posts are over.!!', style: TextStyle(fontSize: 16.0))),
        ),
        noItemsFoundIndicatorBuilder: (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'No Item Found To Show..!!!',
              style: TextStyle(fontSize: screenSizeRatio * 0.03),
            ),
          ),
        ),
      ),
    );
  }
}
