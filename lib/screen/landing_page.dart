import 'package:diabetes_app/screen/homePage.dart';
import 'package:diabetes_app/screen/register.dart';
import 'package:diabetes_app/service/auth.dart';
import 'package:diabetes_app/widget/alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Widget loadingWidget() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    return StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            if (user != null) {
              if (user.displayName == 'AppkesathUser2021') {
                return HomePage(
                  newuser: false,
                );
              } else {
                return HomePage(
                  newuser: true,
                );
              }
            } else {
              return Login(
                emailNotVerifiedWarning: false,
              );
            }
          }
          return loadingWidget();
        });
  }
}
