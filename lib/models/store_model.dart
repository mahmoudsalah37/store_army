//     final storeModel = storeModelFromJson(jsonString);

import 'dart:convert';

List<StoreModel> storeModelFromJson(String str) => List<StoreModel>.from(json.decode(str).map((x) => StoreModel.fromJson(x)));

String storeModelToJson(List<StoreModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreModel {
    int id;
    String codeClass;
    String nameClass;
    String location;
    String numberOfType;
    String nsn;
    String s;
    String d;
    String motherGroup;
    String storeGroup;
    int storeCapacity;

    StoreModel({
        this.id,
        this.codeClass,
        this.nameClass,
        this.location,
        this.numberOfType,
        this.nsn,
        this.s,
        this.d,
        this.motherGroup,
        this.storeGroup,
        this.storeCapacity,
    });

    factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        id: json["id"],
        codeClass: json["code_class"],
        nameClass: json["name_class"],
        location: json["location"],
        numberOfType: json["number_of_type"],
        nsn: json["nsn"],
        s: json["s"],
        d: json["d"],
        motherGroup: json["mother_group"],
        storeGroup: json["store_group"],
        storeCapacity: json["store_capacity"],
    );

    Map<String, String> toJson() => {
        "id": id.toString(),
        "code_class": codeClass,
        "name_class": nameClass,
        "location": location,
        "number_of_type": numberOfType,
        "nsn": nsn,
        "s": s,
        "d": d,
        "mother_group": motherGroup,
        "store_group": storeGroup,
        "store_capacity": storeCapacity.toString(),
    };
}
