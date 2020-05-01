import 'dart:convert';
import 'package:dialog/dialog.dart';
import 'package:easy_stateful_builder/easy_stateful_builder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:store_army/controllers/all/controllers.dart';
import 'package:store_army/controllers/store_controller.dart';
import 'package:store_army/models/store_model.dart';
import 'package:store_army/styles/page/all/app_config.dart';
import 'package:store_army/variables/variables.dart';
import 'package:store_army/widgets/all/dialogs.dart';
import 'package:store_army/widgets/all/pages.dart';


class StorePage extends StatefulWidget {
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  TextEditingController _tecCodeClass = TextEditingController(),
      _tecNameClass = TextEditingController(),
      _tecLocation = TextEditingController(),
      _tecNumberOfType = TextEditingController(),
      _tecNSN = TextEditingController(),
      _tecS = TextEditingController(),
      _tecD = TextEditingController(),
      _tecMotherGroup = TextEditingController(),
      _tecStoreGroup = TextEditingController(),
      _tecStoreCapacity = TextEditingController(),
      _tecAddAndDelete = TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();
    modelName = 'المخزن';
    pageName = 'تسجيل الأصناف';
    resWidthPage = 1400.0;
    controllerBody = ScrollController();
    data = List<StoreModel>();
    dataSearch = List<StoreModel>();
    linkPath = strPath;
    isCheckAll = false;
    checks.clear();
    strSearch = '';
    isAscending = null;
    filter = -1;
    globalKeyAddAndUpdate = GlobalKey<FormState>();
    globalKeyloading = GlobalKey<FormState>();
    // idPage = 'idPage';
  }

  @override
  Widget build(BuildContext context) {
    ac = AppConfig(context);
    return responsiveWidthPage(
        context,
        resWidthPage,
        Column(
          // shrinkWrap: true,
          children: <Widget>[
            //Head
            headPage(context, modelName, pageName, () async {
              setState(() {});
            }, () {
              tecClearData();
              showDialog(
                context: context,
                builder: (BuildContext context) => buildAddAndUpdateDialog(
                    context,
                    strAddNewItem,
                    _columnData(),
                    () => addFunc(context)),
              );
            }),
            SizedBox(height: 4.0),
            //Body
            _bodyPage(),
            powerdBy()
          ],
        ));
  }

  //Body page
  Container _bodyPage() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          //Head table
          headTable(Row(
            children: <Widget>[
              EasyStatefulBuilder(
                  identifier: idPage,
                  builder: (BuildContext context, data) {
                    return checkbox();
                  }),
              SizedBox(
                width: 100,
                child: headCell(0, nameColumnTable('رقم تسلسلي')),
              ),
              Expanded(
                child: headCell(1, nameColumnTable('كود الصنف')),
              ),
              Expanded(
                child: headCell(2, nameColumnTable('اسم الصنف')),
              ),
              Expanded(
                child: headCell(3, nameColumnTable('مكان التخرين')),
              ),
              Expanded(
                child: headCell(4, nameColumnTable('رقم العينة')),
              ),
              Expanded(
                child: headCell(5, nameColumnTable('NSN')),
              ),
              Expanded(
                child: headCell(6, nameColumnTable('ص')),
              ),
              Expanded(
                child: headCell(7, nameColumnTable('د')),
              ),
              Expanded(
                child: headCell(8, nameColumnTable('المجموعة الأم')),
              ),
              Expanded(
                child: headCell(9, nameColumnTable('المجموعة المخرنية')),
              ),
              Expanded(
                child: headCell(10, nameColumnTable('الكمية المتبقة')),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(4.0),
              //   child: SizedBox(
              //     height: 20.0,
              //     width: 40.0,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  height: 20.0,
                  width: 40.0,
                ),
              ),
            ],
          )),
          SizedBox(height: 8.0),
          //Body table
          _bodyTable()
        ],
      ),
    );
  }

  //Body table
  Container _bodyTable() {
    return Container(
      height: getBodyTableHeight,
      //rows
      child: FutureBuilder<List<StoreModel>>(
        future: getDataClassData(),
        builder:
            (BuildContext context, AsyncSnapshot<List<StoreModel>> snapshot) {
          if (snapshot.hasData) {
            data = snapshot.data;
            return EasyStatefulBuilder(
              identifier: idPage,
              builder: (BuildContext context, d) {
                proccessData();
                return draggableListDataViewWidget(ListView.builder(
                  controller: controllerBody,
                  scrollDirection: Axis.vertical,
                  itemCount: dataSearch.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return containerBodyTable(
                      Row(
                        children: <Widget>[
                          checkboxItem(index),
                          SizedBox(
                            width: 100,
                            child: dataCellRow(dataSearch[index].id.toString()),
                          ),
                          Expanded(
                            child: dataCellRow(dataSearch[index].codeClass),
                          ),
                          Expanded(
                            child: dataCellRow(dataSearch[index].nameClass),
                          ),
                          Expanded(
                            child: dataCellRow(dataSearch[index].location),
                          ),
                          Expanded(
                            child: dataCellRow(dataSearch[index].numberOfType),
                          ),
                          Expanded(
                            child: dataCellRow(dataSearch[index].nsn),
                          ),
                          Expanded(
                            child: dataCellRow(dataSearch[index].s),
                          ),
                          Expanded(
                            child: dataCellRow(dataSearch[index].d),
                          ),
                          Expanded(
                            child: dataCellRow(dataSearch[index].motherGroup),
                          ),
                          Expanded(
                            child: dataCellRow(dataSearch[index].storeGroup),
                          ),
                          Expanded(
                            child: dataCellRow(
                                (dataSearch[index].storeCapacity ?? 0)
                                    ?.toString()),
                          ),
                          // Container(
                          //   width: 40.0,
                          //   child: IconButton(
                          //       icon: Icon(
                          //         Icons.local_grocery_store,
                          //         color: Colors.orange,
                          //       ),
                          //       onPressed: () async {
                          //         _tecUpdateData(index);
                          //         showDialog(
                          //           context: context,
                          //           builder: (BuildContext context) =>
                          //               buildAddAndDeleteDialog(
                          //                   context,
                          //                   'الكمية الحالية (${_tecStoreCapacity.text})',
                          //                   _cloumnAddAndDelete(index)),
                          //         );
                          //       }),
                          // ),
                          viewIconWidget(index, context, () {
                            _tecUpdateData(index);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  buildViewDialog(
                                      context, strViewItem, _columnView(index)),
                            );
                          }),
                          //Edit icon
                          editIconWidget(index, context, () async {
                            _tecUpdateData(index);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  buildAddAndUpdateDialog(
                                      context,
                                      strUpdateItem,
                                      _columnData(),
                                      () => updateFunc(context, index),
                                      index: index),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                ));
              },
            );
          } else if (snapshot.hasError) {}
          return loadingWiget();
        },
      ),
    );
  }

  void _tecUpdateData(int index) {
    _tecCodeClass.text = dataSearch[index].codeClass;
    _tecNameClass.text = dataSearch[index].nameClass;
    _tecLocation.text = dataSearch[index].location;
    _tecNumberOfType.text = dataSearch[index].numberOfType;
    _tecNSN.text = dataSearch[index].nsn;
    _tecS.text = dataSearch[index].s;
    _tecD.text = dataSearch[index].d;
    _tecMotherGroup.text = dataSearch[index].motherGroup;
    _tecStoreGroup.text = dataSearch[index].storeGroup;
    _tecStoreCapacity.text = dataSearch[index].storeCapacity.toString();
  }

  void tecClearData() {
    _tecCodeClass.clear();
    _tecNameClass.clear();
    _tecLocation.clear();
    _tecNumberOfType.clear();
    _tecNSN.clear();
    _tecS.clear();
    _tecD.clear();
    _tecMotherGroup.clear();
    _tecStoreGroup.clear();
    _tecStoreCapacity.clear();
    _tecAddAndDelete.text = '0';
  }

  void enterMapData(Map<String, dynamic> mapData) {
    mapData["code_class"] = _tecCodeClass.text.trim();
    mapData["name_class"] = _tecNameClass.text.trim();
    mapData["location"] = _tecLocation.text.trim();
    mapData["number_of_type"] = _tecNumberOfType.text.trim();
    mapData["nsn"] = _tecNSN.text.trim();
    mapData["s"] = _tecS.text.trim();
    mapData["d"] = _tecD.text.trim();
    mapData["mother_group"] = _tecMotherGroup.text.trim();
    mapData["store_group"] = _tecStoreGroup.text.trim();
    mapData["store_capacity"] = _tecStoreCapacity.text.trim();
  }

  void enterMapDataAddOrDelete(Map<String, dynamic> mapData) {
    mapData["code_class"] = _tecCodeClass.text.trim();
    mapData["name_class"] = _tecNameClass.text.trim();
    mapData["location"] = _tecLocation.text.trim();
    mapData["number_of_type"] = _tecNumberOfType.text.trim();
    mapData["nsn"] = _tecNSN.text.trim();
    mapData["s"] = _tecS.text.trim();
    mapData["d"] = _tecD.text.trim();
    mapData["mother_group"] = _tecMotherGroup.text.trim();
    mapData["store_group"] = _tecStoreGroup.text.trim();
    mapData["store_capacity"] = (int.parse(_tecStoreCapacity.text.trim()) +
            int.parse(_tecAddAndDelete.text.trim()))
        .toString();
  }

  void proccessData() {
    if (strSearch != null && strSearch != '')
      dataSearch = getDataSearch(data, strSearch);
    else
      dataSearch = data;
    if (checks.isNotEmpty) checks.clear();
    if (isCheckAll) {
      dataSearch.forEach((d) => checks.add(d.id));
    }
    if (filter != -1 && isAscending != null)
      dataSearch = filterTable(dataSearch, filter, isAscending);
  }

  addFunc(BuildContext context) async {
    if (globalKeyAddAndUpdate.currentState.validate()) {
      Dialogs.showLoadingDialog(context, globalKeyloading);
      Map<String, dynamic> mapData = Map<String, dynamic>();
      enterMapData(mapData);
      Response response = await postData(linkPath, mapData);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        StoreModel model = StoreModel.fromJson(json.decode(response.body));
        EasyStatefulBuilder.setState(idPage, (state) {
          data.add(model);
        });
        tecClearData();
      } else
        alert('Something Happened!');
      Navigator.of(globalKeyloading.currentContext, rootNavigator: true).pop();
      Navigator.of(context).pop();
    }
  }

  updateFunc(BuildContext context, int index) async {
    if (globalKeyAddAndUpdate.currentState.validate()) {
      Dialogs.showLoadingDialog(context, globalKeyloading);
      Map<String, dynamic> mapData = Map<String, dynamic>();
      mapData['id'] = dataSearch[index].id.toString();
      enterMapData(mapData);
      Response response = await putData(linkPath, mapData);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        StoreModel model = StoreModel.fromJson(json.decode(response.body));
        EasyStatefulBuilder.setState(idPage, (state) {
          data[data.indexWhere((element) => element.id == model.id)] = model;
        });
        tecClearData();
      } else
        alert('Something Happened!');
      Navigator.of(globalKeyloading.currentContext, rootNavigator: true).pop();
      Navigator.of(context).pop();
    }
  }

  addAndDeleteFunc(BuildContext context, int index) async {
    if (true) {
      Map<String, dynamic> mapData = Map<String, dynamic>();
      mapData['id'] = dataSearch[index].id.toString();
      enterMapDataAddOrDelete(mapData);
      Response response = await putData(linkPath, mapData);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        StoreModel model = StoreModel.fromJson(json.decode(response.body));
        EasyStatefulBuilder.setState(idPage, (state) {
          data[data.indexWhere((element) => element.id == model.id)] = model;
        });
        tecClearData();
      } else
        alert('Something Happened!');
    }
  }


  Widget _columnView(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        textFormFieldShow('كود الصنف', _tecCodeClass),
        SizedBox(height: 8.0),
        textFormFieldShow('اسم الصنف', _tecNameClass),
        SizedBox(height: 8.0),
        textFormFieldShow('مكان التخرين', _tecLocation),
        SizedBox(height: 8.0),
        textFormFieldShow('رقم العينة', _tecNumberOfType),
        SizedBox(height: 8.0),
        textFormFieldShow('NSN', _tecNSN),
        SizedBox(height: 8.0),
        textFormFieldShow('ص', _tecS),
        SizedBox(height: 8.0),
        textFormFieldShow('د', _tecD),
        SizedBox(height: 8.0),
        textFormFieldShow('المجموعة الأم', _tecMotherGroup),
        SizedBox(height: 8.0),
        textFormFieldShow('المجموعة المخزنية', _tecStoreGroup),
        SizedBox(height: 8.0),
        textFormFieldShow('الرصيد الحالي', _tecStoreCapacity),
        SizedBox(height: 8.0),
      ],
    );
  }

  Widget _columnData() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        textFormField('كود الصنف', _tecCodeClass),
        SizedBox(height: 8.0),
        textFormField('اسم الصنف', _tecNameClass),
        SizedBox(height: 8.0),
        textFormField('مكان التخرين', _tecLocation),
        SizedBox(height: 8.0),
        textFormField('رقم العينة', _tecNumberOfType),
        SizedBox(height: 8.0),
        textFormField('NSN', _tecNSN),
        SizedBox(height: 8.0),
        textFormField('ص', _tecS),
        SizedBox(height: 8.0),
        textFormField('د', _tecD),
        SizedBox(height: 8.0),
        textFormField('المجموعة الأم', _tecMotherGroup),
        SizedBox(height: 8.0),
        textFormField('المجموعة المخزنية', _tecStoreGroup),
        SizedBox(height: 8.0),
        numberFormField('الرصيد الحالي', _tecStoreCapacity),
        SizedBox(height: 8.0),
      ],
    );
  }
}
