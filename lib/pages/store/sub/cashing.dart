import 'package:dialog/dialog.dart';
import 'package:easy_stateful_builder/easy_stateful_builder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:store_army/controllers/all/controllers.dart';
import 'package:store_army/controllers/cashing_controller.dart';
import 'package:store_army/models/cashing_model.dart';
import 'package:store_army/models/store_model.dart';
import 'package:store_army/styles/page/all/app_config.dart';
import 'package:store_army/variables/variables.dart';
import 'package:store_army/widgets/all/dialogs.dart';
import 'package:store_army/widgets/all/pages.dart';

class CachingPage extends StatefulWidget {
  _CachingPageState createState() => _CachingPageState();
}

class _CachingPageState extends State<CachingPage> {
  int beforeEditCount = 0;
  List<bool> _isSelected;
  TextEditingController _tecTypeProcces = TextEditingController(text: 'خصم'),
      _tecNumberProcess = TextEditingController(),
      _tecDateProcess = TextEditingController(),
      _tecDepter = TextEditingController(),
      _tecLocationDepter = TextEditingController(),
      _tecDepartmentDepter = TextEditingController(),
      _tecCreditor = TextEditingController(),
      _tecLocationCreditor = TextEditingController(),
      _tecDepartmentCreditor = TextEditingController(),
      _tecCount = TextEditingController(text: '0'),
      _tecGiveDate = TextEditingController();

  StoreModel _storeModel = StoreModel();
  List<StoreModel> _storedata = List<StoreModel>();
  void _getStoreModelData() async {
    var data = await getData('ClassData');
    _storedata = storeModelFromJson(data);
    if (_storedata.isNotEmpty) _storeModel = _storedata[0];
  }

  @override
  void initState() {
    super.initState();
    _isSelected = [true, false];
    modelName = 'المخزن';
    pageName = 'صرف الأصناف';
    resWidthPage = 1400.0;
    controllerBody = ScrollController();
    data = List<CashingModel>();
    dataSearch = List<CashingModel>();
    linkPath = strPath;
    isCheckAll = false;
    checks.clear();
    strSearch = '';
    isAscending = null;
    filter = -1;
    globalKeyAddAndUpdate = GlobalKey<FormState>();
    globalKeyloading = GlobalKey<FormState>();
    // idPage = 'idPage';
    _getStoreModelData();
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
                child: headCell(1, nameColumnTable('نوع الصرف')),
              ),
              Expanded(
                child: headCell(2, nameColumnTable('رقم الصرف')),
              ),
              Expanded(
                child: headCell(3, nameColumnTable('تاريخ طلب الصرف')),
              ),
              Expanded(
                child: headCell(4, nameColumnTable('منصرف من')),
              ),
              Expanded(
                child: headCell(5, nameColumnTable('جهة')),
              ),
              Expanded(
                child: headCell(6, nameColumnTable('قسم')),
              ),
              Expanded(
                child: headCell(7, nameColumnTable('وارد الي')),
              ),
              Expanded(
                child: headCell(8, nameColumnTable('جه')),
              ),
              Expanded(
                child: headCell(9, nameColumnTable('قسم')),
              ),
              Expanded(
                child: headCell(10, nameColumnTable('الكمية')),
              ),
              Expanded(
                child: headCell(11, nameColumnTable('تاريخ الصرف')),
              ),
              Expanded(
                child: headCell(12, nameColumnTable('اسم الصنف')),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  height: 20.0,
                  width: 20.0,
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
      child: FutureBuilder<List<CashingModel>>(
        future: getDataCashing(),
        builder:
            (BuildContext context, AsyncSnapshot<List<CashingModel>> snapshot) {
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
                            child: dataCellRow(dataSearch[index].typeProcces),
                          ),
                          Expanded(
                            child: dataCellRow(dataSearch[index].numberProcess),
                          ),
                          Expanded(
                            child: dataCellRow(dataSearch[index].dateProcess),
                          ),
                          Expanded(
                            child: dataCellRow(dataSearch[index].depter),
                          ),
                          Expanded(
                            child:
                                dataCellRow(dataSearch[index].locationDepter),
                          ),
                          Expanded(
                            child:
                                dataCellRow(dataSearch[index].departmentDepter),
                          ),
                          Expanded(
                            child: dataCellRow(dataSearch[index].creditor),
                          ),
                          Expanded(
                            child:
                                dataCellRow(dataSearch[index].locationCreditor),
                          ),
                          Expanded(
                            child: dataCellRow(
                                dataSearch[index].departmentCreditor),
                          ),
                          Expanded(
                            child: dataCellRow(
                                (dataSearch[index].count.toString() ?? 0)
                                    ?.toString()),
                          ),
                          Expanded(
                            child: dataCellRow(
                                (dataSearch[index].giveDate ?? 0)?.toString()),
                          ),
                          Expanded(
                            child: dataCellRow(
                                (dataSearch[index].classData.nameClass ?? 0)
                                    ?.toString()),
                          ),
                          viewIconWidget(index, context, () {
                            _tecUpdateData(index);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  buildViewDialog(
                                      context, strViewItem, _columnView(index)),
                            );
                          }),
                          // //Edit icon
                          // editIconWidget(index, context, () async {
                          //   _tecUpdateData(index);
                          //   showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) =>
                          //         buildAddAndUpdateDialog(
                          //             context,
                          //             strUpdateItem,
                          //             _columnData(),
                          //             () => updateFunc(context, index),
                          //             index: index),
                          //   );
                          // }),
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
    if (dataSearch[index].typeProcces == 'خصم') {
      _isSelected = [true, false];
      _tecTypeProcces.text = 'خصم';
    } else {
      _tecTypeProcces.text = 'إضافة';
      _isSelected = [false, true];
    }

    _tecNumberProcess.text = dataSearch[index].numberProcess;
    _tecDateProcess.text = dataSearch[index].dateProcess;
    _tecDepter.text = dataSearch[index].depter;
    _tecLocationDepter.text = dataSearch[index].locationDepter;
    _tecDepartmentDepter.text = dataSearch[index].departmentDepter;
    _tecCreditor.text = dataSearch[index].creditor;
    _tecLocationCreditor.text = dataSearch[index].locationCreditor;
    _tecDepartmentCreditor.text = dataSearch[index].departmentCreditor;
    _tecCount.text = dataSearch[index].count.toString();
    _tecGiveDate.text = dataSearch[index].giveDate;
    _storeModel = dataSearch[index].classData;
  }

  void tecClearData() {
    _tecTypeProcces.text = 'خصم';
    _isSelected = [true, false];
    _tecNumberProcess.clear();
    _tecDateProcess.clear();
    _tecDepter.clear();
    _tecLocationDepter.clear();
    _tecDepartmentDepter.clear();
    _tecCreditor.clear();
    _tecLocationCreditor.clear();
    _tecDepartmentCreditor.clear();
    _tecCount.text = '0';
    _tecGiveDate.clear();
    _storeModel = _storedata[0];
  }

  void enterMapData(Map<String, dynamic> mapData) {
    mapData["type_procces"] = _tecTypeProcces.text.trim();
    mapData["number_process"] = _tecNumberProcess.text.trim();
    mapData["date_process"] = _tecDateProcess.text.trim();
    mapData["depter"] = _tecDepter.text.trim();
    mapData["location_depter"] = _tecLocationDepter.text.trim();
    mapData["department_depter"] = _tecDepartmentDepter.text.trim();
    mapData["creditor"] = _tecCreditor.text.trim();
    mapData["location_creditor"] = _tecLocationCreditor.text.trim();
    mapData["department_creditor"] = _tecDepartmentCreditor.text.trim();
    mapData["count"] = _tecCount.text.trim();
    mapData["give_date"] = _tecGiveDate.text.trim();
    mapData["class_id"] = _storeModel.id.toString();
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
        if (_isSelected[0])
          _storeModel.storeCapacity =
              _storeModel.storeCapacity - int.parse(_tecCount.text);
        else if (_isSelected[1])
          _storeModel.storeCapacity =
              _storeModel.storeCapacity + int.parse(_tecCount.text);

        await putData('ClassData', _storeModel.toJson());
        EasyStatefulBuilder.setState('cashingUpdate', (x) {});
        // CashingModel model = CashingModel.fromJson(json.decode(response.body));
        // EasyStatefulBuilder.setState(idPage, (state) {
        //   data.add(model);
        // });
        // tecClearData();
        setState(() {});
      } else
        alert('Something Happened!');
      Navigator.of(globalKeyloading.currentContext, rootNavigator: true).pop();
      // Navigator.of(context).pop();
    }
  }

  // updateFunc(BuildContext context, int index) async {
  //   if (globalKeyAddAndUpdate.currentState.validate()) {
  //     Dialogs.showLoadingDialog(context, globalKeyloading);
  //     Map<String, dynamic> mapData = Map<String, dynamic>();
  //     mapData['id'] = dataSearch[index].id.toString();
  //     enterMapData(mapData);
  //     Response response = await putData(linkPath, mapData);
  //     if (response.statusCode >= 200 && response.statusCode <= 299) {
  //       _storeModel.storeCapacity -= int.parse(_tecCount.text) - dataSearch[index].count;
  //       await putData('ClassData', _storeModel.toJson());
  //       // CashingModel model = CashingModel.fromJson(json.decode(response.body));
  //       // EasyStatefulBuilder.setState(idPage, (state) {
  //       //   data[data.indexWhere((element) => element.id == model.id)] = model;
  //       // });
  //       setState(() {});
  //       // tecClearData();
  //     } else
  //       alert('Something Happened!');
  //     Navigator.of(globalKeyloading.currentContext, rootNavigator: true).pop();
  //     // Navigator.of(context).pop();
  //   }
  // }

  Widget _columnView(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        textFormFieldShow('نوع الصرف', _tecTypeProcces),
        SizedBox(height: 8.0),
        textFormFieldShow('رقم الصرف', _tecNumberProcess),
        SizedBox(height: 8.0),
        textFormFieldShow('تاريخ طلب الصرف', _tecDateProcess),
        SizedBox(height: 8.0),
        textFormFieldShow('منصرف من', _tecDepter),
        SizedBox(height: 8.0),
        textFormFieldShow('جهة', _tecLocationDepter),
        SizedBox(height: 8.0),
        textFormFieldShow('قسم', _tecDepartmentDepter),
        SizedBox(height: 8.0),
        textFormFieldShow('وارد الي', _tecCreditor),
        SizedBox(height: 8.0),
        textFormFieldShow('جه', _tecLocationCreditor),
        SizedBox(height: 8.0),
        textFormFieldShow('قسم', _tecDepartmentCreditor),
        SizedBox(height: 8.0),
        textFormFieldShow('الكمية', _tecCount),
        SizedBox(height: 8.0),
        textFormFieldShow('تاريخ الصرف', _tecGiveDate),
        SizedBox(height: 8.0),
        stringFormFieldShow('اسم الصنف', dataSearch[index].classData.nameClass),
        SizedBox(height: 8.0),
      ],
    );
  }

  Widget _columnData() {
    return EasyStatefulBuilder(
        identifier: 'cashingUpdate',
        builder: (BuildContext context, d) {
          return StatefulBuilder(builder: (context, x) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                choiceWidget(),
                SizedBox(height: 8.0),
                textFormField('رقم الصرف', _tecNumberProcess),
                SizedBox(height: 8.0),
                datePicker(context, _tecDateProcess, 'تاريخ طلب الصرف'),
                SizedBox(height: 8.0),
                textFormField('منصرف من', _tecDepter, color: Colors.redAccent),
                SizedBox(height: 8.0),
                textFormField('جهة', _tecLocationDepter,
                    color: Colors.redAccent),
                SizedBox(height: 8.0),
                textFormField('قسم', _tecDepartmentDepter,
                    color: Colors.redAccent),
                SizedBox(height: 8.0),
                textFormField('وارد الي', _tecCreditor, color: Colors.green),
                SizedBox(height: 8.0),
                textFormField('جه', _tecLocationCreditor, color: Colors.green),
                SizedBox(height: 8.0),
                textFormField('قسم', _tecDepartmentCreditor,
                    color: Colors.green),
                SizedBox(height: 8.0),
                dropDownMenu('اسم الصنف', x),
                SizedBox(height: 8.0),
                numberFormFieldCashing('الكمية', _tecCount,
                    _storeModel.storeCapacity, _isSelected),
                SizedBox(height: 8.0),
                datePicker(context, _tecGiveDate, 'تاريخ الصرف'),
                SizedBox(height: 8.0),
              ],
            );
          });
        });
  }

  Widget dropDownMenu(String title, x) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text(
          '$title:',
          style: TextStyle(color: Colors.blue),
        ),
        DropdownButton<int>(
          value: _storeModel.id,
          items: _storedata.map((v) {
            return DropdownMenuItem(
              value: v.id,
              child: Text(v.nameClass),
            );
          }).toList(),
          onChanged: (int v) {
            _storeModel =
                _storedata[_storedata.indexWhere((element) => element.id == v)];
            x(() {});
          },
        )
      ])
    ]);
  }

  Widget choiceWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 50.0,
        ),
        Center(
          child: StatefulBuilder(
            builder: (BuildContext context, setState) {
              return ToggleButtons(
                borderColor: Colors.green[200],
                fillColor: Colors.green,
                borderWidth: 2,
                selectedBorderColor: Colors.green,
                selectedColor: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'خصم',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'إضافة',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    if (index == 0)
                      _tecTypeProcces.text = 'خصم';
                    else if (index == 1) _tecTypeProcces.text = 'إضافة';

                    for (int i = 0; i < _isSelected.length; i++) {
                      if (i == index) {
                        _isSelected[i] = true;
                      } else {
                        _isSelected[i] = false;
                      }
                    }
                  });
                },
                isSelected: _isSelected,
              );
            },
          ),
        ),
        SizedBox(width: 15.0),
      ],
    );
  }
}
