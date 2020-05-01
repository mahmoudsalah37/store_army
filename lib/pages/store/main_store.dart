import 'package:flutter/material.dart';
import 'sub/store.dart';
import 'sub/cashing.dart';

class MainStore extends StatefulWidget {
  final int child;
  MainStore(this.child);
  _MainStoreState createState() => _MainStoreState();
}

class _MainStoreState extends State<MainStore> {
  @override
  Widget build(BuildContext context) {
    return selectPage(widget.child);
  }

  Widget selectPage(int child) {
    switch (child) {
      case 0:
        return StorePage();
      case 1:
        return CachingPage();
      default:
        return StorePage();
    }
  }
}
