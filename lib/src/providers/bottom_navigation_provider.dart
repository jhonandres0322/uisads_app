import 'package:flutter/material.dart';


class BottomNavigationBarProvider extends ChangeNotifier {
  int _currentPage = 0;
  // Getters y setters para la pagina actual
  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }
}