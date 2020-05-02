// import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:store_army/packages/draggable_scroll_bar/draggable_scroll_bar.dart';

import 'package:flutter/material.dart';

import 'sub/analysis.dart';
import 'sub/main_store/main_store_model_widget.dart';

final _controller = ScrollController();
Widget items() {
  return DraggableScrollbar(
    controller: _controller,
    heightScrollThumb: 40.0,
    child: ListView(
      controller: _controller,
      shrinkWrap: true,
      children: <Widget>[
        SizedBox(height: 5.0),
        // Policy(),
        // Scope(),
        MainStoreModelWidget(),
        AnalysisWidget(),
        SizedBox(height: 50.0),
      ],
    ),
  );
}
