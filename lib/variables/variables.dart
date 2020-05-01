import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store_army/styles/page/all/app_config.dart';

List data, dataSearch;
GlobalKey<FormState> globalKeyAddAndUpdate, globalKeyloading;
bool isCheckAll;
AppConfig ac;
String strSearch, linkPath, modelName, pageName, selectedStatus;
const List<String> statusList = <String>['pending', 'completed'];
List<int> checks = List<int>();
ScrollController controllerBody;
const String strAddNewItem = 'أضافة بيانات جديدة';
const String strUpdateItem = 'تعديل البيانات';
const String strViewItem = 'عرض البيانات';
const String strPutAndGet = 'خصم و إضافة';
double resWidthPage = 0.0;
DateFormat yearFormater = new DateFormat('yyyy');
DateFormat dataFormater = new DateFormat().add_yMd();
DateFormat monthFormater = new DateFormat('mm');
double get getBodyTableHeight {
  return ac.rH(100.0) - 176.0;
}

