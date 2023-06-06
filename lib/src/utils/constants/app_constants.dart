import 'package:flutter/material.dart';

Size? screenSize;

void getScreenSize(BuildContext context) {
  screenSize = MediaQuery.of(context).size;
}
