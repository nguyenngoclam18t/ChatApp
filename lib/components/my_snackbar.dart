import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class MySnackbar {
  static void showMySnackBar(
      BuildContext context, String title, String message, ContentType content) {
    var snackbar = SnackBar(
      elevation: 0,
      duration: Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: content,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
