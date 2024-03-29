import 'package:daily_recipe/utils/toast.status.dart';
import 'package:flutter/material.dart';

abstract class ToastMessageUtils {
  static void showToastMessage(
      BuildContext context, ToastStatus toastStatus, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            toastStatus == ToastStatus.success
                ? const Icon(Icons.check_circle_outline_outlined,color: Colors.green,)
                : const Icon(Icons.dangerous_outlined,color: Colors.red,),
            const SizedBox(
              width: 8,
            ),
            Flexible(
                child: Text(
              message,
              style: const TextStyle(color: Colors.black, fontSize: 16),
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
