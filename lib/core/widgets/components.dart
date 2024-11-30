import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String msg, Color? color, int? time}) {
  FocusManager.instance.primaryFocus?.unfocus();
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: time ?? 2,
      backgroundColor: color ?? Colors.black45,
      textColor: Colors.white,
      fontSize: 16.0);
}
