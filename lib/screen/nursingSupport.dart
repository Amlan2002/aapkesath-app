import 'dart:ui';
import 'package:diabetes_app/widget/nursingSupportCard.dart';
import 'package:flutter/material.dart';

class NursingSupport extends StatelessWidget {
  const NursingSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double deviceHeight = mediaQueryData.size.height;
    double devicewidth = mediaQueryData.size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 10,
        title: Text(
          'Nursing Support',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: deviceHeight * 0.82,
        child: Stack(
          children: [
            new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    NursingSupportCard(),
                    NursingSupportCard(),
                    NursingSupportCard(),
                    NursingSupportCard(),
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
