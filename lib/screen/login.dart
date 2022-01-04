import 'package:diabetes_app/screen/register.dart';
import 'package:diabetes_app/service/auth.dart';
import 'package:diabetes_app/widget/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key? key, required this.emailNotVerifiedWarning}) : super(key: key);
  final bool emailNotVerifiedWarning;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  bool isTriedToSubmit = false;
  bool isPasswordVisible = false;

  final emailController = TextEditingController();
  final passWordcontroller = TextEditingController();

  GlobalKey<FormState> loginFormkey = GlobalKey<FormState>();

  void signInWithEmail() async {
    if (loginFormkey.currentState!.validate()) {
      print('validated');
      final auth = Provider.of<Auth>(context, listen: false);
      try {
        setState(() {
          isLoading = true;
        });
        await auth.signInWithEmailAndPassword(
            emailController.text, passWordcontroller.text);
      } on Exception catch (e) {
        print(e.toString());
        setState(() {
          isLoading = false;
        });
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

  @override
  void initState() {
    super.initState();

    if (widget.emailNotVerifiedWarning == true) {
      showNormalAlretDialog(context,
          title: 'Email not verified',
          message: 'please verify your email before login.');
      final auth = Provider.of<Auth>(context, listen: false);
      auth.signOut();
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
              top: 70,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isLoading)
                  Padding(
                    padding: const EdgeInsets.all(10),
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
                    padding: const EdgeInsets.only(top: 130),
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
                  autovalidateMode: AutovalidateMode.disabled,
                  key: loginFormkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextFormField(
                        enabled: !isLoading,
                        controller: emailController,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.green,
                              size: 28,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.green,
                                    style: BorderStyle.solid)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.green,
                                    style: BorderStyle.solid)),
                            focusColor: Colors.green),
                        keyboardType: TextInputType.emailAddress,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Email required *'),
                          EmailValidator(errorText: 'not a valid email')
                        ]),
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        enabled: !isLoading,
                        controller: passWordcontroller,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          focusColor: Colors.green,
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green,
                                  style: BorderStyle.solid)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green,
                                  style: BorderStyle.solid)),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.green,
                          ),
                          suffixIcon: passWordcontroller.text.isNotEmpty
                              ? (isPasswordVisible
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isPasswordVisible =
                                              !isPasswordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.visibility_off,
                                        color: Colors.green,
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isPasswordVisible =
                                              !isPasswordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.visibility,
                                        color: Colors.green,
                                      ),
                                    ))
                              : Container(
                                  width: 0,
                                ),
                        ),
                        onChanged: (_) {
                          setState(() {});
                        },
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Password required *'),
                          LengthRangeValidator(
                              min: 6,
                              max: 20,
                              errorText:
                                  'Password must be 6 to 20 character long')
                        ]),
                        textInputAction: TextInputAction.done,
                        obscureText: !isPasswordVisible,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password ?',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: isLoading ? null : signInWithEmail,
                        child: Text(
                          'LOG IN',
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
                        height: 12,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'New to AppkeSath?',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) {
                                  return Resgister(isThirdpartySignup: false);
                                }),
                              );
                            },
                            child: Text(
                              'Register',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 17),
                            ),
                          ),
                        ],
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
