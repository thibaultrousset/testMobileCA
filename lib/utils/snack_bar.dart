
import 'package:flutter/material.dart';

class SnackBarUtil {
  displayMessage(String message, scaffoldKey, BuildContext context) {
    ScaffoldMessenger.of(scaffoldKey.currentContext?? context).removeCurrentSnackBar();
    ScaffoldMessenger.of(scaffoldKey.currentContext?? context).showSnackBar(SnackBar(content: Text(message),behavior: SnackBarBehavior.floating,));
  }
}
