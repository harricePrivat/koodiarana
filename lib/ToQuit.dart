import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class ToQuit extends StatefulWidget {
  Widget child;
  ToQuit({super.key, required this.child});

  @override
  State<ToQuit> createState() => _ToQuitState();
}

class _ToQuitState extends State<ToQuit> {
  DateTime? lastPressed;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: widget.child,
      onPopInvokedWithResult: (pop, result) {
        if (lastPressed == null ||
            DateTime.now().difference(lastPressed!) >
                const Duration(seconds: 2)) {
          lastPressed = DateTime.now();
          Fluttertoast.showToast(
              msg: 'Appuyer deux fois pour quitter',
              toastLength: Toast.LENGTH_LONG);
        } else {
          exit(0);
        }
      },
    );
  }
}
