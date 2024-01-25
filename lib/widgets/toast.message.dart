import 'package:flutter/material.dart';

import '../utils/toast.status.dart';
class ToastMessageWidget extends StatelessWidget {
  const ToastMessageWidget({super.key, required this. toastStatus, required this. message});
 final ToastStatus toastStatus;
 final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              children: [
                toastStatus == ToastStatus.success
                    ? Icon(Icons.check_circle_outline_outlined,color: Colors.green,)
                    : Icon(Icons.dangerous_outlined,color: Colors.red,),
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
            /*action: SnackBarAction(
              label: 'ACTION',
              onPressed: () { },
            ),*/
          ));
        },
        child: const Text('SHOW SNACK'),
      ),
    );
  }
}
