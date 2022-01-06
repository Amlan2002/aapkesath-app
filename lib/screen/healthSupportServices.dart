import 'package:diabetes_app/screen/consultDoctors.dart';
import 'package:diabetes_app/screen/nursingSupport.dart';
import 'package:flutter/material.dart';

class HealthSupportServices extends StatelessWidget {
  const HealthSupportServices({
    Key? key,
  }) : super(key: key);

  static const routeName = '/Health-Support';

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double deviceHeight = mediaQueryData.size.height;
    double devicewidth = mediaQueryData.size.width;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 40,
                  left: 40,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.orange[200]),
                      height: 50,
                      width: 50,
                      child: Center(
                        child: Icon(Icons.arrow_back_ios_new),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 40,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.orange[200]),
                    height: 50,
                    width: 50,
                    child: Center(
                      child: Icon(Icons.menu),
                    ),
                  ),
                ),
                Positioned(
                  top: 110,
                  right: 40,
                  child: Container(
                    height: 100,
                    width: 100,
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        "images/healthSupport.png",
                        height: 100.0,
                        width: 100.0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 110,
                  left: 40,
                  child: Container(
                    height: 100,
                    width: 200,
                    child: Center(
                      child: Text(
                        "Health Support Services",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: deviceHeight * 0.54,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 120,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.blue[200],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(
                              -10.0, // Move to right 10  horizontally
                              10.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 120,
                          width: 230,
                          alignment: Alignment.center,
                          child: Text(
                            'Diagnosis',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              "images/diagnosis.png",
                              height: 100.0,
                              width: 100.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConsultDoctors())),
                    child: Container(
                      height: 120,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.blue[200],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(
                                -10.0, // Move to right 10  horizontally
                                10.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 120,
                            width: 230,
                            alignment: Alignment.center,
                            child: Text(
                              'Consult Doctor',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                "images/doctor.png",
                                height: 100.0,
                                width: 100.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NursingSupport())),
                    child: Container(
                      height: 120,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.blue[200],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(
                                -10.0, // Move to right 10  horizontally
                                10.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 120,
                            width: 230,
                            alignment: Alignment.center,
                            child: Text(
                              'Nursing Support',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                "images/hospital.png",
                                height: 100.0,
                                width: 100.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
