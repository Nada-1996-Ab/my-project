import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String getDate() {
  String date = "${DateTime.now().toLocal()}".split(' ')[0] +
      "  " +
      "${TimeOfDay.now().hour.toString()}:${TimeOfDay.now().minute.toString()}"
          .split(' ')[0];
  return date;
}

getToast(String text) {
  return Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
  );
}