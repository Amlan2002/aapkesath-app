import 'package:diabetes_app/screen/otp_screen.dart';
import 'package:diabetes_app/service/auth.dart';
import 'package:diabetes_app/widget/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({
    Key? key,
  }) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  bool isTriedToSubmit = false;

  GlobalKey<FormState> loginFormkey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();

  void signInWithGoogle() async {
    final auth = Provider.of<Auth>(context, listen: false);
    try {
      setState(() {
        isLoading = true;
      });
      await auth.signInWithGoogle();
    } on Exception catch (e) {
      setState(() {
        isLoading = false;
      });
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: e,
      );
    }
  }

  void loginwithPhone() async {
    if (loginFormkey.currentState!.validate()) {
      try {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return OtpScreen(number: numberController.text);
        }));
      } on Exception catch (e) {
        showExceptionAlertDialog(
          context,
          title: 'Sign in failed',
          exception: e,
        );
      }
    } else {
      setState(() {
        isTriedToSubmit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white70,
            padding: EdgeInsets.only(
              bottom: 30,
              left: 30,
              right: 30,
              top: MediaQuery.of(context).size.height - 750,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isLoading)
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 0, top: 10, left: 10, right: 10),
                    child: Center(
                      child: Container(
                        height: 275,
                        width: 220,
                        child: Image.asset(
                          "images/aapkeSath.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                if (isLoading)
                  Padding(
                    padding: const EdgeInsets.only(top: 260),
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.green,
                      ),
                    ),
                  ),
                SizedBox(
                  height: 70,
                ),
                Form(
                  autovalidateMode: isTriedToSubmit
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  key: loginFormkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'WELCOME TO',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' APPKESATH',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'An OTP will',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        'sent to your number to login',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        enabled: !isLoading,
                        controller: numberController,
                        decoration: InputDecoration(
                          labelText: 'Enter phone number',
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.green,
                            size: 28,
                          ),
                        ),
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'mobile number required *'),
                          PatternValidator(r'^[0-9]{10}$',
                              errorText: 'enter a valid 10 digit number'),
                        ]),
                        autocorrect: true,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: isLoading ? null : loginwithPhone,
                        child: Text(
                          'Login with OTP',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          fixedSize: Size(1000, 50),
                          primary: Colors.green,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'or',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      OutlinedButton(
                        onPressed: isLoading ? null : signInWithGoogle,
                        child: Text(
                          'Log in with Google',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.black, width: 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            fixedSize: Size(1000, 50),
                            primary: Colors.white,
                            onSurface: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
