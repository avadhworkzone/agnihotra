import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void commonFlutterToastMsg(String msg){

  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}