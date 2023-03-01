import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

Future<void> showNoConnectionToast(String message, BuildContext context) async {
  await showFlash(
    context: context,
    duration: const Duration(seconds: 2),
    builder: (context, controller) {
      return Flash.dialog(
        barrierColor: Colors.transparent,
        controller: controller,
        backgroundColor: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            textAlign: TextAlign.center,
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      );
    },
  );
}
