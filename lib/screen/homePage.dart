import 'package:diabetes_app/model/user.dart';
import 'package:diabetes_app/screen/healthSupportServices.dart';
import 'package:diabetes_app/screen/manageMyHealth.dart';
import 'package:diabetes_app/widget/navigationDrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.moveToDocument,
  }) : super(key: key);
  static const routeName = '/Home-page';
  final VoidCallback moveToDocument;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(
        moveToDocuments: widget.moveToDocument,
      ),
      appBar: AppBar(
        title: Text('AapkeSath'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    height: 130,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            height: 50,
                            width: 220,
                            child: Text(
                              "Welcome",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          left: 10,
                          child: Container(
                            height: 50,
                            width: 200,
                            child: Consumer<AppUser?>(
                              builder: (ctx, user, child) => FittedBox(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${user!.firstName}!",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            height: 100,
                            width: 100,
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "images/oldMan.png",
                                height: 100.0,
                                width: 100.0,
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
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ManageMyHealth()),
                    ),
                    child: Container(
                      height: 120,
                      width: 360,
                      decoration: BoxDecoration(
                          color: Colors.red[200],
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
                              'Manage My Health',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: new EdgeInsets.only(
                              right: 15,
                            ),
                            height: 100,
                            width: 100,
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                "images/manageMyHealth.png",
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
                            builder: (context) => HealthSupportServices())),
                    child: Container(
                      height: 120,
                      width: 360,
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
                              'Health Support',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: new EdgeInsets.only(
                              right: 15,
                            ),
                            height: 100,
                            width: 100,
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                "images/healthSupport1.png",
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
                  Container(
                    height: 120,
                    width: 360,
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
                          margin: new EdgeInsets.only(
                            left: 15,
                          ),
                          height: 120,
                          width: 230,
                          alignment: Alignment.center,
                          child: Text(
                            'Healthy Living Products',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: new EdgeInsets.only(
                            right: 15,
                          ),
                          height: 100,
                          width: 100,
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              "images/healthyLivingProduct.png",
                              height: 100.0,
                              width: 100.0,
                            ),
                          ),
                        ),
                      ],
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
