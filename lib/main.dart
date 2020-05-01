import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_army/models/page_model.dart';
import 'package:store_army/pages/store/sub/store.dart';

import 'views/home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'المخازن',
      theme: ThemeData(),
      home: ChangeNotifierProvider<PageModel>(
        child: Home(),
        create: (BuildContext context) {
          return PageModel(StorePage());
        },
      ),
    );
  }
}
