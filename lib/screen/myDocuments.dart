import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetes_app/widget/bottomNavigationBaWidget.dart';
import 'package:diabetes_app/widget/navigationDrawerWidget.dart';
import 'package:flutter/material.dart';

class MyDocuments extends StatelessWidget {
  const MyDocuments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(),
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('My Documents'),
      ),
      body: Container(),
    );
  }
}
