// To parse this JSON data, do
//
//     final cashingModel = cashingModelFromJson(jsonString);

import 'dart:convert';

import 'package:store_army/models/store_model.dart';

List<CashingModel> cashingModelFromJson(String str) => List<CashingModel>.from(
    json.decode(str).map((x) => CashingModel.fromJson(x)));

String cashingModelToJson(List<CashingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CashingModel {
  StoreModel classData;
  int id;
  String typeProcces;
  String numberProcess;
  String dateProcess;
  String depter;
  String locationDepter;
  String departmentDepter;
  String creditor;
  String locationCreditor;
  String departmentCreditor;
  int count;
  String giveDate;
  int classId;

  CashingModel({
    this.classData,
    this.id,
    this.typeProcces,
    this.numberProcess,
    this.dateProcess,
    this.depter,
    this.locationDepter,
    this.departmentDepter,
    this.creditor,
    this.locationCreditor,
    this.departmentCreditor,
    this.count,
    this.giveDate,
    this.classId,
  });

  factory CashingModel.fromJson(Map<String, dynamic> json) => CashingModel(
        classData: StoreModel.fromJson(json["class_data"]),
        id: json["id"],
        typeProcces: json["type_procces"],
        numberProcess: json["number_process"],
        dateProcess: json["date_process"],
        depter: json["depter"],
        locationDepter: json["location_depter"],
        departmentDepter: json["department_depter"],
        creditor: json["creditor"],
        locationCreditor: json["location_creditor"],
        departmentCreditor: json["department_creditor"],
        count: json["count"],
        giveDate: json["give_date"],
        classId: json["class_id"],
      );

  Map<String, dynamic> toJson() => {
        "class_data": classData.toJson(),
        "id": id,
        "type_procces": typeProcces,
        "number_process": numberProcess,
        "date_process": dateProcess,
        "depter": depter,
        "location_depter": locationDepter,
        "department_depter": departmentDepter,
        "creditor": creditor,
        "location_creditor": locationCreditor,
        "department_creditor": departmentCreditor,
        "count": count,
        "give_date": giveDate,
        "class_id": classId,
      };
}
