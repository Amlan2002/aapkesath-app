import 'dart:ui';

import 'package:diabetes_app/widget/bottomNavigationBaWidget.dart';
import 'package:diabetes_app/widget/consultDoctors_card.dart';
import 'package:flutter/material.dart';

class ConsultDoctors extends StatelessWidget {
  const ConsultDoctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double deviceHeight = mediaQueryData.size.height;
    double devicewidth = mediaQueryData.size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.amber,
        title: Text(
          'Consult Doctors',
          style: TextStyle(color: Colors.black),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
      body: Container(
        height: deviceHeight * 0.82,
        child: Stack(
          children: [
            new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ConsultDoctorsCard(),
                    ConsultDoctorsCard(),
                    ConsultDoctorsCard(),
                    ConsultDoctorsCard(),
                  ],
                ),
              ),
            ),
            new Center(
              child: new ClipRect(
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
                  child: new Container(
                    width: devicewidth * 0.7,
                    height: deviceHeight * 0.82,
                    decoration: new BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(0.5)),
                    child: new Center(
                      child: new Text(
                        'Coming Soon!!',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
