import 'package:easy_stateful_builder/easy_stateful_builder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store_army/controllers/all/analysis_controller.dart';
import 'package:store_army/controllers/all/controllers.dart';
import 'package:store_army/models/cashing_model.dart';
import 'package:store_army/styles/all/all.dart';
import 'package:store_army/styles/page/all/app_config.dart';
import 'package:store_army/variables/variables.dart';
import 'package:store_army/widgets/all/pages.dart';

class AnalysisPage extends StatefulWidget {
  _AnalysisPageState createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  int beforeEditCount = 0;
  static DateFormat formatter = DateFormat('yyyy-MM-dd');
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
      _tecGiveDate = TextEditingController(),
      _controllerFrom = TextEditingController(
          text: formatter.format(DateTime.now().subtract(Duration(days: 1)))),
      _controllerTo =
          TextEditingController(text: formatter.format(DateTime.now()));

  void _getStoreModelData() async {
    var data = await getData('ClassData');
  }

  @override
  void initState() {
    super.initState();
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
            Container(
              height: 40.0,
              color: colorContext,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 4.0,
                  ),
                  nameMainHeadPage('$modelName/'),
                  //Page name
                  nameSubHeadPage(pageName),
                  Expanded(
                    child: Container(),
                  ),
                  //Search Icon

                  //Search text
                  Container(
                    width: 178.0,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 20.0),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                            width: 150,
                            height: 37.0,
                            color: Colors.white,
                            child: TextField(
                              maxLines: 1,
                              onChanged: (String v) async {
                                EasyStatefulBuilder.setState(idPage, (state) {
                                  strSearch = v.trim().toLowerCase();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20.0),
                  //Delete icon

                  SizedBox(width: 20.0),
                  //Add new item

                  SizedBox(width: 20.0),

                  SizedBox(width: 20.0),
                ],
              ),
            ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              datePickerCeck(context, _controllerFrom, 'من'),
              datePickerCeck(context, _controllerTo, 'الي'),
            ],
          ),
          SizedBox(height: 8.0),

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

  Widget datePickerCeck(
      BuildContext context, TextEditingController controller, String strName) {
    return Wrap(
      children: <Widget>[
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.horizontal,
          children: <Widget>[
            Center(
              child: Container(
                width: 180.0,
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  readOnly: true,
                  controller: controller,
                  validator: (String v) {
                    String value = v.trim();
                    if (value.isEmpty) return 'الخانة فارغه';
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: strName,
                    labelStyle: TextStyle(
                      color: colorLabelText,
                    ),
                    hintText: '',
                    hintStyle: TextStyle(
                      color: colorHintText,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Center(
              child: IconButton(
                hoverColor: Colors.grey,
                icon: Center(child: Icon(Icons.timer)),
                onPressed: () async {
                  var date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1950),
                    initialDate: DateTime.now(),
                    lastDate: DateTime(2050),
                  );
                  if (date != null) {
                    controller.text = dataFormater.format(date);
                    setState(() {});
                  }
                },
              ),
            ),
            SizedBox(width: 15.0),
          ],
        ),
      ],
    );
  }

  //Body table
  Container _bodyTable() {
    return Container(
      height: getBodyTableHeight,
      //rows
      child: FutureBuilder<List<CashingModel>>(
        future: getDatafilterList(_controllerFrom, _controllerTo),
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
    _tecTypeProcces.text = dataSearch[index].typeProcces;
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
  }

  void tecClearData() {
    _tecTypeProcces.text = 'خصم';
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
}
