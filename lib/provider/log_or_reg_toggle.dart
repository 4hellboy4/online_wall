import 'package:flutter/material.dart';

class ToggleProvider extends ChangeNotifier {
  bool _toggle = false;

  void tapToggle() {
    _toggle = !_toggle;
    notifyListeners();
  }

  bool get toggle => _toggle;
}
