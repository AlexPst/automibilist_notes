import 'package:flutter/material.dart';

extension ShowReplacing on ScaffoldMessengerState {
  /// Новое сообщение сразу заменяет предыдущее, а не ждёт в очереди.
  void show(SnackBar snackBar) {
    hideCurrentSnackBar();
    showSnackBar(snackBar);
  }
}
