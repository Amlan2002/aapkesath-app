import 'package:diabetes_app/model/user.dart';
import 'package:diabetes_app/service/auth.dart';
import 'package:diabetes_app/service/firestoreApi.dart';
import 'package:diabetes_app/widget/bottomNavigationBaWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingUser extends StatefulWidget {
  const LoadingUser({Key? key, required this.newUser}) : super(key: key);
  final bool newUser;
  @override
  _LoadingUserState createState() => _LoadingUserState();
}

class _LoadingUserState extends State<LoadingUser> {
  AppUser user = AppUser(
    firstName: '',
    lastName: '',
    dob: DateTime.now(),
    gender: 'male',
    nationality: 'indian',
    city: 'Bhubaneswar',
    address: '',
    pin: '',
  );

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final db = Provider.of<FirestoreApi>(context, listen: false);
    return widget.newUser == true
        ? BottomNavigationBarWidget(
            newuser: true,
          )
        : StreamProvider<AppUser?>.value(
            value: db.getCurrentUserDetailsStream(auth.currentuser!.uid),
            initialData: user,
            child: BottomNavigationBarWidget(
              newuser: false,
            ),
          );
  }
}
