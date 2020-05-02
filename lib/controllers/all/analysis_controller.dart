import 'package:flutter/cupertino.dart';
import 'package:store_army/models/cashing_model.dart';

import 'controllers.dart';
import 'package:http/http.dart' as http;

const String strPath = 'filter';
Future<List<CashingModel>> getDatafilterList(
    TextEditingController from, TextEditingController to) async {
  var data = await getDataFilter(strPath, from, to);
  return cashingModelFromJson(data);
}

Future<String> getDataFilter(String strPath, TextEditingController from,
    TextEditingController to) async {
  final http.Response response = await http
      .get('$domin/api/$strPath?from=${from.text}&to=${to.text}', headers: {
    'Access-Control-Allow-Origin': '*',
  });
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load post');
  }
}

List<CashingModel> getDataSearch(
    List<CashingModel> snapshot, String strSearch) {
  List<CashingModel> dataSearch = List<CashingModel>();
  snapshot.forEach((CashingModel data) {
    String id = data.id?.toString() ?? '';
    String typeProcces = data.typeProcces ?? '';
    String numberProcess = data.numberProcess ?? '';
    String dateProcess = data.dateProcess ?? '';
    String depter = data.depter ?? '';
    String locationDepter = data.locationDepter ?? '';
    String departmentDepter = data.departmentDepter ?? '';
    String creditor = data.creditor ?? '';
    String locationCreditor = data.locationCreditor ?? '';
    String departmentCreditor = data.departmentCreditor ?? '';
    String count = (data.count ?? '').toString();
    String giveDate = data.giveDate ?? '';
    String nameClass = data.classData.nameClass ?? '';
    if (id.toLowerCase().contains(strSearch) ||
        typeProcces.toLowerCase().contains(strSearch) ||
        numberProcess.toLowerCase().contains(strSearch) ||
        dateProcess.toLowerCase().contains(strSearch) ||
        depter.toLowerCase().contains(strSearch) ||
        locationDepter.toLowerCase().contains(strSearch) ||
        departmentDepter.toLowerCase().contains(strSearch) ||
        creditor.toLowerCase().contains(strSearch) ||
        locationCreditor.toLowerCase().contains(strSearch) ||
        departmentCreditor.toLowerCase().contains(strSearch) ||
        giveDate.toLowerCase().contains(strSearch) ||
        nameClass.toLowerCase().contains(strSearch) ||
        count.toLowerCase().contains(strSearch)) {
      dataSearch.add(data);
    }
  });
  return dataSearch;
}

List<CashingModel> filterTable(
    List<CashingModel> data, int index, bool isAscending) {
  switch (index) {
    case 0:
      data?.sort((a, b) => a.id?.compareTo(b.id));
      break;

    case 1:
      data?.sort((a, b) => a.typeProcces
          ?.toLowerCase()
          ?.compareTo(b.typeProcces?.toLowerCase()));
      break;
    case 2:
      data?.sort((a, b) => a.numberProcess
          ?.toLowerCase()
          ?.compareTo(b.numberProcess?.toLowerCase()));
      break;
    case 3:
      data?.sort((a, b) => a.dateProcess
          ?.toLowerCase()
          ?.compareTo(b.dateProcess?.toLowerCase()));
      break;
    case 4:
      data?.sort((a, b) =>
          a.depter?.toLowerCase()?.compareTo(b.depter?.toLowerCase()));
      break;
    case 5:
      data?.sort((a, b) => a.locationDepter
          ?.toLowerCase()
          ?.compareTo(b.locationDepter?.toLowerCase()));
      break;
    case 6:
      data?.sort((a, b) => a.departmentDepter
          ?.toLowerCase()
          ?.compareTo(b.departmentDepter?.toLowerCase()));
      break;
    case 7:
      data?.sort((a, b) =>
          a.creditor?.toLowerCase()?.compareTo(b.creditor?.toLowerCase()));
      break;
    case 8:
      data?.sort((a, b) => a.locationCreditor
          ?.toLowerCase()
          ?.compareTo(b.locationCreditor?.toLowerCase()));
      break;
    case 9:
      data?.sort((a, b) => a.departmentCreditor
          ?.toLowerCase()
          ?.compareTo(b.departmentCreditor?.toLowerCase()));
      break;
    case 10:
      data?.sort((a, b) => (a.count ?? '')
          .toString()
          ?.toLowerCase()
          ?.compareTo((b.count ?? '').toString().toLowerCase()));
      break;
    case 11:
      data?.sort((a, b) => (a.giveDate ?? '')
          .toString()
          ?.toLowerCase()
          ?.compareTo((b.giveDate ?? '').toString().toLowerCase()));
      break;
    case 12:
      data?.sort((a, b) => (a.classData.nameClass ?? '')
          .toString()
          ?.toLowerCase()
          ?.compareTo((b.classData.nameClass ?? '').toString().toLowerCase()));
      break;
    default:
      return data;
  }

  if (!isAscending) data = data.reversed.toList();
  return data;
}
