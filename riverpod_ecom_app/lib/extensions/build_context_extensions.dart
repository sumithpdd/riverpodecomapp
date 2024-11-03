import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  void goTo(Widget screen, {bool replace = false}) {
    if (replace) {
      Navigator.of(this).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => screen), (route) => false);
    } else {
      Navigator.of(this).push(MaterialPageRoute(builder: (_) => screen));
    }
  }

  void goBack() {
    Navigator.of(this).pop();
  }
}
