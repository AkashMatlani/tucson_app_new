import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ToastMessageAnimation.dart';

class ToastUtils {
  static Timer toastTimer;
  static OverlayEntry _overlayEntry;

  static void showToast(BuildContext context, String message, Color bgColor) {

    if (toastTimer == null || !toastTimer.isActive) {
      _overlayEntry = createOverlayEntry(context, message, bgColor);
      Overlay.of(context)!.insert(_overlayEntry);
      toastTimer = Timer(Duration(seconds: 2), () {
        if (_overlayEntry != null) {
          _overlayEntry.remove();
        }
      });
    }
  }

  static OverlayEntry createOverlayEntry(BuildContext context, String message, Color bgColor) {
    return OverlayEntry(
        builder: (context) => Positioned(
          width: MediaQuery.of(context).size.width - 80,
          left: 40,
          bottom: MediaQuery.of(context).size.width * 0.15,
          child: ToastMessageAnimation(Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding:
              EdgeInsets.all(13),
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          )
          ),
        )
    );
  }
}

