import 'package:diabetes_app/screen/homePage.dart';
import 'package:diabetes_app/screen/manageMyHealth.dart';
import 'package:diabetes_app/screen/myDocuments.dart';
import 'package:diabetes_app/screen/register.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  BottomNavigationBarWidget({Key? key, required this.newuser})
      : super(key: key);
  bool newuser;
  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;
  final sceren = [HomePage(), ManageMyHealth(), MyDocuments()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.newuser) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) {
            return Resgister();
          },
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.newuser
        ? Container(
            //  loading widget
            color: Colors.white70,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ),
          )
        : Scaffold(
            body: IndexedStack(
              children: sceren,
              index: _selectedIndex,
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.health_and_safety),
                  label: 'Health',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.document_scanner),
                  label: 'Documents',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.orange,
              onTap: _onItemTapped,
            ),
          );
  }
}
