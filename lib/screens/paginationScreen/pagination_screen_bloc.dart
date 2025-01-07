import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:main_app_demo/screens/paginationScreen/pagination_screen_repo.dart';

import 'DemoDl.dart';

class PaginationScreenBloc {
  final PagingController<int, Results> pagingController = PagingController(firstPageKey: 1);
  final PaginationScreenRepo repo = PaginationScreenRepo();

  static const int _pageSize = 20;

  PaginationScreenBloc() {
    pagingController.addPageRequestListener((pageKey) {
      getData(pageKey);
    });
  }

  Future<void> getData(int pageKey) async {
    try {
      final newItems = await repo.fetchData(pageKey);
      List<Results> lst = newItems.results ?? [];
      print("List Of Data =========>>>>>>$lst");
      final isLastPage = (lst.length) < (_pageSize);
      if (isLastPage) {
        pagingController.appendLastPage(lst);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(lst, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void dispose() {
    pagingController.dispose();
  }
}
