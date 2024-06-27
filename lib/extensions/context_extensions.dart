import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  //*
  void popRoute() => Navigator.pop(this);

  Future<dynamic> pushMaterialRoute(Widget screen) async {
    return await Navigator.push(
      this,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  Future<dynamic> pushUntilRoute(Widget screen) async {
    return await Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (_) => screen),
      (route) => false,
    );
  }
}
