import 'dart:async';

import 'package:flutter/material.dart';

class Debounce {
  final int milliseconds;
  Debounce({
    required this.milliseconds,
  });

  Timer? timer;

  //todo 1 (next todos_page.dart)
  void run(VoidCallback action) {
    if (timer != null) {
      timer?.cancel();
    }
    timer = Timer(
      Duration(milliseconds: milliseconds),
      action,
    );
  }
}
