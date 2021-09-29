import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const textInputDecor = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2)
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 2)
  )
);

var toast = Fluttertoast.showToast(
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.green[400],
                        textColor: Colors.white,
                        fontSize: 16
                      );