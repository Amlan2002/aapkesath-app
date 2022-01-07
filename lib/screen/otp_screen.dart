import 'dart:async';

import 'package:diabetes_app/service/auth.dart';
import 'package:diabetes_app/widget/alert_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.number}) : super(key: key);
  final String number;
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool verifying = false;
  bool sent = false;
  late Timer timer;

  int timeLeft = 60;

  @override
  void didChangeDependencies() async {
    await sendOtp();
    super.didChangeDependencies();
  }

  Future<void> sendOtp() async {
    startTimer();
    try {
      final auth = Provider.of<Auth>(context, listen: false);
      await auth.loginWithPhone(phone: '+91' + widget.number, context: context);
    } on Exception catch (e) {
      await showExceptionAlertDialog(
        context,
        title: 'Sign up failed',
        exception: e,
      );
      Navigator.of(context).pop();
    }
  }

  void startTimer() {
    timeLeft = 60;
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft -= 1;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP verification'),
        titleSpacing: 40,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Enter the OTP',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'sent to +91${widget.number}',
                style: TextStyle(fontSize: 17),
              ),
              VerificationCode(
                autofocus: true,
                textStyle: TextStyle(fontSize: 20.0, color: Colors.red[900]),
                underlineColor: Colors.amber,
                keyboardType: TextInputType.number,
                length: 6,
                onCompleted: (String value) async {
                  try {
                    setState(() {
                      verifying = true;
                    });
                    final auth = Provider.of<Auth>(context, listen: false);
                    await auth.verifyOTP(otp: value, context: context);
                    timer.cancel();
                  } on Exception catch (e) {
                    setState(() {
                      verifying = false;
                    });
                    await showExceptionAlertDialog(
                      context,
                      title: 'Sign in failed',
                      exception: e,
                    );
                    if (e is FirebaseException &&
                        e.code == 'invalid-verification-code') {
                    } else {
                      timer.cancel();
                      Navigator.of(context).pop();
                    }
                  }
                },
                onEditing: (bool value) {
                  setState(() {});
                },
              ),
              SizedBox(
                height: 60,
              ),
              if (verifying)
                Text('Verifying otp....', style: TextStyle(fontSize: 15)),
              if (verifying)
                SizedBox(
                  height: 60,
                ),
              if (verifying)
                CircularProgressIndicator(
                  color: Colors.green,
                ),
              if (!verifying)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Didn\'t get otp?',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        if (timeLeft > 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                              'Please wait $timeLeft second to try again',
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            )),
                          );
                        } else {
                          sendOtp();
                        }
                      },
                      child: Text(
                        'Resend',
                        style: TextStyle(color: Colors.green, fontSize: 15),
                      ),
                    ),
                    Text(
                      'in  $timeLeft second',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
