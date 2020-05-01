import 'package:flutter/cupertino.dart';
// import 'package:store_army/widgets/all/view_page.dart';

class PageModel with ChangeNotifier {
  Widget _viewPage;
  PageModel(this._viewPage);

  getViewPage() => _viewPage;

  setViewPage(v) {
    _viewPage = v;
    notifyListeners();
  }
}
