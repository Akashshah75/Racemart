import 'package:flutter/material.dart';

class IconChangeProvider extends ChangeNotifier {
  bool isActive = false;

  void changeIcon(bool isActives) {
    isActive = isActives;
    notifyListeners();
  }
}
