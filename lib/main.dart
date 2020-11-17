import 'package:flutter/material.dart';
import 'package:meditation/CCList.dart';

void main(List<String> args) => runApp(CCTracker());

class CCTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CCTracker",
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: CCList(),
    );
  }
}
