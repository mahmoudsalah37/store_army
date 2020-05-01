import 'package:flutter/material.dart';
import 'package:store_army/models/page_model.dart';
import 'package:provider/provider.dart';
import 'package:store_army/styles/page/all/app_config.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:store_army/widgets/all/drawer_widget/drawer_widget.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AppConfig ac;
  @override
  Widget build(BuildContext context) {
    ac = AppConfig(context);
    final page = Provider.of<PageModel>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: GradientAppBar(
        title: Row(
          children: <Widget>[
            Text('المخازن'),
            Expanded(
              child: Container(),
            ),
            IconButton(
              icon: Icon(Icons.settings),
              hoverColor: Colors.blue,
              onPressed: () async {
                print('holla');
              },
            ),
            SizedBox(width: 10.0),
          ],
        ),
        
      ),
      drawer: DrawerWidget(),
      body: SafeArea(
        child: Container(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              // //Drawer
              // Visibility(
              //   visible:false,
              //   child: Container(
              //     width: ac.rW(20),
              //     child: DrawerWidget(),
              //   ),
              // ),

              //View
              Container(
                width: MediaQuery.of(context).size.width * 1.0,
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 1.0,
                ),
                color: Colors.grey[200],
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: page.getViewPage(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
