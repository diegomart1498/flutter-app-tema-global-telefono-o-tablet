import 'package:flutter/material.dart';
import 'package:my_app/pages/pages.dart';

class LayoutModel extends ChangeNotifier {
  Widget _currentPage = const SlideshowPage();

  Widget get currentPage => _currentPage;

  set currentPage(Widget page) {
    _currentPage = page;
    notifyListeners();
  }

  bool _landscape = false;
  bool get landscape => _landscape;
  set landscape(bool value) {
    _landscape = value;
    // notifyListeners();
  }
}
