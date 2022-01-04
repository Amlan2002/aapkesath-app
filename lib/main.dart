import 'package:diabetes_app/screen/healthSupportServices.dart';
import 'package:diabetes_app/screen/homePage.dart';
import 'package:diabetes_app/screen/landing_page.dart';
import 'package:diabetes_app/service/auth.dart';
import 'package:diabetes_app/service/firestoreApi.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Auth>(create: (_) => Auth()),
        Provider<FirestoreApi>(create: (_) => FirestoreApi()),
      ],
      child: MaterialApp(
        // Hide the debug banner
        debugShowCheckedModeBanner: false,
        title: 'App Name',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: LandingPage(),
      ),
    );
  }
}
