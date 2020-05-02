import 'package:flutter/material.dart';
import 'package:store_army/pages/data_analysis/data_analysis.dart';
import 'package:store_army/pages/store/main_store.dart';

class ViewPage extends StatefulWidget {
  final int page, child;
  ViewPage(this.page, this.child);
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    return selectModule(widget.page, widget.child);
  }

  Widget selectModule(int page, int child) {
    switch (widget.page) {
      case 0:
        return MainStore(widget.child);
      case 1:
        return AnalysisPage();
      default:
        return MainStore(widget.child);
    }
  }
}
