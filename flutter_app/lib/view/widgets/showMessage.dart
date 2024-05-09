import 'package:flutter/material.dart';
import 'package:flutter_app/cofig/textstyles.dart';

void showMessage(String message, context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: const Text(
            "Alert!",
            style: AppTextStyle.dialogTitle,
          ),
          content: Text(
            message,
            style: AppTextStyle.dialogSmall,
          ),
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
