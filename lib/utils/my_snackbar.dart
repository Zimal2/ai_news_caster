import 'package:flutter/material.dart';

class MySnackbar {
  static OverlayEntry? _overlayEntry;

  static void showSnackBar(BuildContext context, String msg, {bool? success}) {
    // Close any existing snackbar
    closeCurrentSnackbar();

    // Create a new overlay entry for the snackbar
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: success == true ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              msg,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

    // Show the overlay entry
    Overlay.of(context)?.insert(_overlayEntry!);

    // Close the snackbar after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      closeCurrentSnackbar();
    });
  }

  static void closeCurrentSnackbar() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
