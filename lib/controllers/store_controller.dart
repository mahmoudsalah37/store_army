import 'package:store_army/models/store_model.dart';

import 'all/controllers.dart';

const String strPath = 'ClassData';
Future<List<StoreModel>> getDataClassData() async {
  var data = await getData(strPath);
  return storeModelFromJson(data);
}

List<StoreModel> getDataSearch(List<StoreModel> snapshot, String strSearch) {
  List<StoreModel> dataSearch = List<StoreModel>();
  snapshot.forEach((StoreModel data) {
    String id = data.id?.toString() ?? '';
    String codeClass = data.codeClass ?? '';
    String nameClass = data.nameClass ?? '';
    String location = data.location ?? '';
    String numberOfType = data.numberOfType ?? '';
    String s = data.s ?? '';
    String d = data.d ?? '';
    String nsn = data.nsn ?? '';
    String motherGroup = data.motherGroup ?? '';
    String storeGroup = data.storeGroup ?? '';
    String storeCapacity = (data.storeCapacity ?? '').toString();
    if (id.toLowerCase().contains(strSearch) ||
        codeClass.toLowerCase().contains(strSearch) ||
        nameClass.toLowerCase().contains(strSearch) ||
        location.toLowerCase().contains(strSearch) ||
        numberOfType.toLowerCase().contains(strSearch) ||
        s.toLowerCase().contains(strSearch) ||
        d.toLowerCase().contains(strSearch) ||
        nsn.toLowerCase().contains(strSearch) ||
        motherGroup.toLowerCase().contains(strSearch) ||
        storeGroup.toLowerCase().contains(strSearch) ||
        storeCapacity.toLowerCase().contains(strSearch)) {
      dataSearch.add(data);
    }
  });
  return dataSearch;
}

List<StoreModel> filterTable(
    List<StoreModel> data, int index, bool isAscending) {
  switch (index) {
    case 0:
      data?.sort((a, b) => a.id?.compareTo(b.id));
      break;
    case 1:
      data?.sort((a, b) =>
          a.codeClass?.toLowerCase()?.compareTo(b.codeClass?.toLowerCase()));
      break;
    case 2:
      data?.sort((a, b) =>
          a.nameClass?.toLowerCase()?.compareTo(b.nameClass?.toLowerCase()));
      break;
    case 3:
      data?.sort((a, b) =>
          a.location?.toLowerCase()?.compareTo(b.location?.toLowerCase()));
      break;
    case 4:
      data?.sort((a, b) => a.numberOfType
          ?.toLowerCase()
          ?.compareTo(b.numberOfType?.toLowerCase()));
      break;
    case 5:
      data?.sort(
          (a, b) => a.nsn?.toLowerCase()?.compareTo(b.nsn?.toLowerCase()));
      break;
    case 6:
      data?.sort((a, b) => a.s?.toLowerCase()?.compareTo(b.s?.toLowerCase()));
      break;
    case 7:
      data?.sort((a, b) => a.d?.toLowerCase()?.compareTo(b.d?.toLowerCase()));
      break;
    case 8:
      data?.sort((a, b) => a.motherGroup
          ?.toLowerCase()
          ?.compareTo(b.motherGroup?.toLowerCase()));
      break;
    case 9:
      data?.sort((a, b) =>
          a.storeGroup?.toLowerCase()?.compareTo(b.storeGroup?.toLowerCase()));
      break;
    case 10:
      data?.sort((a, b) => (a.storeCapacity ?? '')
          .toString()
          ?.toLowerCase()
          ?.compareTo((b.storeCapacity ?? '').toString().toLowerCase()));
      break;
    default:
      return data;
  }

  if (!isAscending) data = data.reversed.toList();
  return data;
}
