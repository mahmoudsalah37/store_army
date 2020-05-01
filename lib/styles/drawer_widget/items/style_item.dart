import 'package:flutter/material.dart';

const TextStyle textStyleItem = TextStyle(color: Colors.white);
const double leftPaddingSubListItem = 23.0;
const double heightContainerItem = 36.0;

//Check on hover
Color isHoverItem(bool isHover) {
  return isHover ? Color.fromRGBO(175, 147, 153, 1.0) : Colors.white;
}
