import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:main_app_demo/screens/paginationScreen/pagination_screen_dl.dart';
import 'package:main_app_demo/screens/paginationScreen/pagination_screen_repo.dart';
import 'package:rxdart/rxdart.dart';

class PaginationScreenBloc {

  final PagingController<int, PaginationScreenDl> pagingController =
  PagingController(firstPageKey: 1);
  final PaginationScreenRepo repo = PaginationScreenRepo();

  static const int _pageSize = 6;

  PaginationScreenBloc() {
    pagingController.addPageRequestListener((pageKey) {
      getData(pageKey);
    });
  }

  Future<void> getData(int pageKey) async {
    try {
      final newItems = await repo.fetchData(pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void dispose() {
    pagingController.dispose();
  }
}
