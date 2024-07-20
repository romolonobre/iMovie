import 'package:flutter/material.dart';

class Errorhandler {
  static Future<void> report(
    dynamic exception,
    StackTrace stackTrace,
    String tag,
  ) async {
    debugPrintStack(label: exception.toString(), stackTrace: stackTrace);
  }
}
