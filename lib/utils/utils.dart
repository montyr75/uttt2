import 'package:flutter/material.dart';

String enumToString(enumValue) => enumValue.toString().split(".").last;
T stringToEnum<T>(String str, Iterable<T> values) => values.firstWhere((value) => value.toString().split('.')[1] == str, orElse: () => null);

Border determineCellBorder(int index, BorderSide borderSide) {
  Border border;

  switch(index) {
    case 0: border = Border(bottom: borderSide, right: borderSide); break;
    case 1: border = Border(left: borderSide, bottom: borderSide, right: borderSide); break;
    case 2: border = Border(left: borderSide, bottom: borderSide); break;
    case 3: border = Border(bottom: borderSide, right: borderSide, top: borderSide); break;
    case 4: border = Border(left: borderSide, bottom: borderSide, right: borderSide, top: borderSide); break;
    case 5: border = Border(left: borderSide, bottom: borderSide, top: borderSide); break;
    case 6: border = Border(right: borderSide, top: borderSide); break;
    case 7: border = Border(left: borderSide, top: borderSide, right: borderSide); break;
    case 8: border = Border(left: borderSide, top: borderSide); break;
  }

  return border;
}
