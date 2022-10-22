import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

class ToastMessage {
  // ignore: non_constant_identifier_names
  static Future ToastMessageShow(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: kBackGroundColor,
        textColor: Colors.black,
        fontSize: 20);
  }
}
