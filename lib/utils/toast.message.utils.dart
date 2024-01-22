import 'package:daily_recipe/utils/toast.status.dart';
import 'package:flutter/material.dart';

abstract class ToastMessageUtils {
  static void toastMessage(
      BuildContext context, ToastStatus toastStatus, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            toastStatus == ToastStatus.success
                ? Icon(Icons.check_circle_outline_outlined)
                : Icon(Icons.dangerous_outlined),
            const SizedBox(
              width: 8,
            ),
            Flexible(
                child: Text(
              message,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            )),
          ],
        ),
        backgroundColor: toastStatus == ToastStatus.failed
            ? Colors.red[100]
            : Colors.green[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(50),
        behavior: SnackBarBehavior.floating,
      ));
    });
  }
}
