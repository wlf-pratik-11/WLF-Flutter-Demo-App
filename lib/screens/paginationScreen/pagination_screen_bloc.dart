import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:main_app_demo/screens/paginationScreen/pagination_screen_dl.dart';
import 'package:main_app_demo/screens/paginationScreen/pagination_screen_repo.dart';
import 'package:rxdart/rxdart.dart';

class PaginationScreenBloc {
  PaginationScreenBloc() {
    pagingController.addPageRequestListener((pagekey) {
      getData(pagekey);
    });
  }

  PaginationScreenRepo repo = PaginationScreenRepo();

  static const _pageSize = 6;
  final PagingController<int, PaginationScreenDl> pagingController = PagingController(firstPageKey: 0);

  final paginationScreenBlocController = BehaviorSubject<List<dynamic>>();

  Future<void> getData(int pagekey) async {
    try {
      final newItems = await repo.fetchData(pagekey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        print(
            "::::::::::::::::::::::::::::::::::::::::::::::::: is Load : ${newItems.length}:::::::::::::: ${newItems.length}::::::::::::::::::::");
        pagingController.appendLastPage(newItems);
      } else {
        print(
            "::::::::::::::::::::::::::::::::::::::::::::::::: is Load not : ${newItems.length}:::::::::::::: ${newItems.length}::::::::::::::::::::");
        final nextPageKey = pagekey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
    // paginationScreenBlocController.sink.add([]);
    // List<dynamic> dataList = await repo.fetchData(pagekey);
    // paginationScreenBlocController.sink.add(dataList);
  }
}
