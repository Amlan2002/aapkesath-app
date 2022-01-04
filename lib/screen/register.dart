import 'package:diabetes_app/model/user.dart';
import 'package:diabetes_app/service/auth.dart';
import 'package:diabetes_app/service/firestoreApi.dart';
import 'package:diabetes_app/widget/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class Resgister extends StatefulWidget {
  const Resgister({Key? key, required this.isThirdpartySignup})
      : super(key: key);
  final bool isThirdpartySignup;
  @override
  _ResgisterState createState() => _ResgisterState();
}

class _ResgisterState extends State<Resgister> {
  bool isLoading = false;
  bool isTriedToSubmit = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final numberController = TextEditingController();
  final nationalityController = TextEditingController();
  final pinCodeController = TextEditingController();
  final cityController = TextEditingController();
  final addressDetailsController = TextEditingController();

  GlobalKey<FormState> signupFormkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    cityController.text = "Bhubaneswar";
    if (widget.isThirdpartySignup) {
      final auth = Provider.of<Auth>(context, listen: false);
      emailController.text = auth.currentuser!.email!;
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    numberController.dispose();
    pinCodeController.dispose();
    cityController.dispose();
    nationalityController.dispose();
    addressDetailsController.dispose();
    super.dispose();
  }

  void signUp() async {
    if (signupFormkey.currentState!.validate()) {
      final database = Provider.of<FirestoreApi>(context, listen: false);
      try {
        setState(() {
          isLoading = true;
        });
        final user = AppUser(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passwordController.text,
          contactNumber: numberController.text,
          nationality: nationalityController.text,
          city: cityController.text,
          address: addressDetailsController.text,
          pin: pinCodeController.text,
        );

        if (widget.isThirdpartySignup) {
          await database.userSignUpWithThirdparyProvider(user, context);
          setState(() {
            isLoading = false;
          });
          await showNormalAlretDialog(
            context,
            title: 'Sign up success',
            message:
                'you have successfully signed up. Now you can continue with AppkeSath',
          );
          Navigator.of(context).pop();
        } else {
          await database.userSignUpWithEmail(user, context);

          setState(() {
            isLoading = false;
          });
          await showNormalAlretDialog(
            context,
            title: 'Sign up success',
            message:
                'you have successfully signed up. A varification link is sent to your email id , please verify before login',
          );
          Navigator.of(context).pop();
        }
      } on Exception catch (e) {
        setState(() {
          isLoading = false;
        });
        showExceptionAlertDialog(
          context,
          title: 'Sign up failed',
          exception: e,
        );
      }
    } else {
      setState(() {
        isTriedToSubmit = true;
      });
    }
  }

  Future<bool?> showBackConformationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ct) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('You can\'t use AppkeSath with out registering'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ct).pop(false),
            child: Text('Cancle'),
          ),
          TextButton(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              // final auth = Provider.of<Auth>(context);
              // await auth.signOut();
              return Navigator.of(ct).pop(true);
            },
            child: Text(
              'Back to login',
              style: TextStyle(color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.isThirdpartySignup) {
          final shouldPop = await showBackConformationDialog(context);
          if (shouldPop == true) {
            final auth = Provider.of<Auth>(context, listen: false);
            setState(() {
              isLoading = true;
            });
            auth.signOut();
          }
          return shouldPop ?? false;
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.green,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      height: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 10, top: 35),
                              child: IconButton(
                                onPressed: isLoading
                                    ? null
                                    : () async {
                                        // if (widget.isThirdpartySignup) {
                                        //   bool? willback =
                                        //       await showBackConformationDialog(
                                        //           context);
                                        //   if (willback == true) {
                                        //     final auth = Provider.of<Auth>(context,
                                        //         listen: false);
                                        //     setState(() {
                                        //       isLoading = true;
                                        //     });
                                        //     auth.signOut();
                                        //     setState(() {
                                        //       isLoading = false;
                                        //     });
                                        //     Navigator.pop(context);
                                        //   }
                                        // } else {
                                        //   Navigator.of(context).pop();
                                        // }
                                      },
                                icon: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 5),
                            child: Text(
                              widget.isThirdpartySignup
                                  ? 'Fill the details'
                                  : 'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 15),
                            child: Text(
                              'to continue with AppkeSath',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      )),
                  Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - 170),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        )),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        autovalidateMode: AutovalidateMode.disabled,
                        key: signupFormkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            TextFormField(
                              enabled: !isLoading,
                              controller: firstNameController,
                              decoration: InputDecoration(
                                labelText: 'First name',
                                prefixIcon: Icon(
                                  Icons.account_circle_rounded,
                                  color: Colors.green,
                                  size: 28,
                                ),
                              ),
                              validator:
                                  RequiredValidator(errorText: 'Required'),
                              autocorrect: true,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              enabled: !isLoading,
                              controller: lastNameController,
                              decoration: InputDecoration(
                                labelText: 'Last name',
                                prefixIcon: Icon(
                                  Icons.account_circle_outlined,
                                  color: Colors.green,
                                  size: 28,
                                ),
                              ),
                              validator:
                                  RequiredValidator(errorText: 'Required'),
                              autocorrect: true,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              enabled: !isLoading && !widget.isThirdpartySignup,
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.black26,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.green,
                                  size: 28,
                                ),
                              ),
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Email required *'),
                                EmailValidator(errorText: 'not a valid email')
                              ]),
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            if (!widget.isThirdpartySignup)
                              TextFormField(
                                enabled: !isLoading,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.green,
                                  ),
                                  suffixIcon: passwordController.text.isNotEmpty
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
                                  RequiredValidator(
                                      errorText: 'Passwprd required *'),
                                  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                                      errorText:
                                          'passwords must have at least one special character'),
                                  LengthRangeValidator(
                                      min: 6,
                                      max: 20,
                                      errorText:
                                          'Password must be 6 to 20 character long')
                                ]),
                                textInputAction: TextInputAction.next,
                                obscureText: !isPasswordVisible,
                                keyboardType: TextInputType.visiblePassword,
                              ),
                            if (!widget.isThirdpartySignup)
                              SizedBox(
                                height: 20,
                              ),
                            if (!widget.isThirdpartySignup)
                              TextFormField(
                                enabled: !isLoading,
                                controller: confirmPasswordController,
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.green,
                                  ),
                                  suffixIcon:
                                      confirmPasswordController.text.isNotEmpty
                                          ? (isConfirmPasswordVisible
                                              ? IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isConfirmPasswordVisible =
                                                          !isConfirmPasswordVisible;
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
                                                      isConfirmPasswordVisible =
                                                          !isConfirmPasswordVisible;
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
                                validator: (val) => MatchValidator(
                                        errorText: 'passwords do not match')
                                    .validateMatch(
                                        val!, passwordController.text),
                                textInputAction: TextInputAction.next,
                                obscureText: !isConfirmPasswordVisible,
                                keyboardType: TextInputType.visiblePassword,
                              ),
                            if (!widget.isThirdpartySignup)
                              SizedBox(
                                height: 20,
                              ),
                            TextFormField(
                              controller: numberController,
                              enabled: !isLoading,
                              decoration: InputDecoration(
                                labelText: 'Contact number',
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.green,
                                  size: 28,
                                ),
                              ),
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'mobile number required *'),
                                PatternValidator(r'^(?:[+0]91)?[0-9]{10}$',
                                    errorText: 'enter a valid phone number'),
                              ]),
                              autocorrect: true,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              enabled: !isLoading,
                              controller: nationalityController,
                              decoration: InputDecoration(
                                labelText: 'Nationality',
                                prefixIcon: Icon(
                                  Icons.article,
                                  color: Colors.green,
                                  size: 28,
                                ),
                              ),
                              validator:
                                  RequiredValidator(errorText: 'Required'),
                              autocorrect: true,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: cityController,
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'City',
                                prefixIcon: Icon(
                                  Icons.location_city,
                                  color: Colors.green,
                                  size: 28,
                                ),
                                disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.black38,
                                  ),
                                ),
                              ),
                              validator:
                                  RequiredValidator(errorText: 'Required'),
                              autocorrect: true,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: addressDetailsController,
                              enabled: !isLoading,
                              decoration: InputDecoration(
                                labelText: 'Permanent Address',
                                prefixIcon: Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                  size: 28,
                                ),
                              ),
                              validator: MultiValidator([
                                RequiredValidator(errorText: 'Required'),
                                LengthRangeValidator(
                                    min: 10,
                                    max: 250,
                                    errorText:
                                        'address must be 10 to 250 character long')
                              ]),
                              autocorrect: true,
                              keyboardType: TextInputType.streetAddress,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: pinCodeController,
                              enabled: !isLoading,
                              decoration: InputDecoration(
                                labelText: 'pin code',
                                prefixIcon: Icon(
                                  Icons.push_pin_rounded,
                                  color: Colors.green,
                                  size: 28,
                                ),
                              ),
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'pin code required *'),
                                PatternValidator(r'^[0-9]{6}$',
                                    errorText:
                                        'pincode must be a 6 digit number'),
                              ]),
                              autocorrect: true,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onSurface: Colors.green,
                                  minimumSize: Size(150, 40),
                                  elevation: 8,
                                  shadowColor: Colors.green),
                              onPressed: isLoading ? null : signUp,
                              child: isLoading
                                  ? CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Submit',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
