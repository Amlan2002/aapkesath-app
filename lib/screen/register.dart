import 'package:diabetes_app/model/user.dart';
import 'package:diabetes_app/service/auth.dart';
import 'package:diabetes_app/service/firestoreApi.dart';
import 'package:diabetes_app/widget/alert_dialog.dart';
import 'package:diabetes_app/widget/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class Resgister extends StatefulWidget {
  const Resgister({
    Key? key,
  }) : super(key: key);

  @override
  _ResgisterState createState() => _ResgisterState();
}

class _ResgisterState extends State<Resgister> {
  bool isLoading = false;
  bool triedNextInformationForm = false;
  bool triedNextAddressForm = false;
  bool triedNextAuthenticationForm = false;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dobController = TextEditingController();
  final nationalityController = TextEditingController();
  final pinCodeController = TextEditingController();
  final cityController = TextEditingController();
  final addressDetailsController = TextEditingController();
  DateTime? date;
  String? gender;

  GlobalKey<FormState> informationFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> authenticationFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    cityController.text = "Bhubaneswar";
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    pinCodeController.dispose();
    cityController.dispose();
    nationalityController.dispose();
    addressDetailsController.dispose();
    super.dispose();
  }

  Future pickDate(BuildContext context) async {
    final currentDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? currentDate,
      firstDate: DateTime(currentDate.year - 100),
      lastDate: DateTime(currentDate.year + 1),
    );

    if (newDate == null) return;

    setState(() {
      date = newDate;
      dobController.text = '${date!.day}/${date!.month}/${date!.year}';
    });
  }

  void register() async {
    final database = Provider.of<FirestoreApi>(context, listen: false);
    try {
      setState(() {
        isLoading = true;
      });
      final user = AppUser(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        nationality: nationalityController.text,
        city: cityController.text,
        address: addressDetailsController.text,
        pin: pinCodeController.text,
        dob: date!,
        gender: gender!,
      );

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

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: Text('Account'),
          content: InformationForm(),
        ),
        Step(
          state: StepState.editing,
          isActive: _activeStepIndex >= 1,
          title: Text('Address'),
          content: AddressForm(),
        ),
      ];

  int _activeStepIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showBackConformationDialog(context);
        if (shouldPop == true) {
          final auth = Provider.of<Auth>(context, listen: false);
          setState(() {
            isLoading = true;
          });
          auth.signOut();
        }
        return shouldPop ?? false;
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.green,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 5),
                            child: Text(
                              'Fill the details',
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
                        maxHeight: MediaQuery.of(context).size.height - 140,
                        maxWidth: MediaQuery.of(context).size.width),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        )),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 22),
                        child: Stepper(
                          steps: stepList(),
                          type: StepperType.horizontal,
                          currentStep: _activeStepIndex,
                          onStepContinue: () {
                            switch (_activeStepIndex) {
                              case 0:
                                {
                                  if (informationFormKey.currentState!
                                      .validate()) {
                                    if (gender != null) {
                                      _activeStepIndex += 1;
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: const Text(
                                          'Please select your gender',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 20),
                                        )),
                                      );
                                    }
                                  } else {
                                    triedNextInformationForm = true;
                                  }
                                }
                                break;
                              case 1:
                                {
                                  if (addressFormKey.currentState!.validate()) {
                                    register();
                                  } else {
                                    triedNextAddressForm = true;
                                  }
                                }
                                break;
                            }
                            setState(() {});
                          },
                          onStepCancel: () {
                            if (_activeStepIndex == 0) {
                              return;
                            }
                            _activeStepIndex -= 1;
                            setState(() {});
                          },
                          controlsBuilder:
                              (BuildContext context, ControlsDetails details) {
                            return Row(
                              children: [
                                if (_activeStepIndex != 0)
                                  Expanded(
                                      child: ElevatedButton(
                                    onPressed:
                                        isLoading ? null : details.onStepCancel,
                                    child: Text('Back'),
                                  )),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: ElevatedButton(
                                  onPressed:
                                      isLoading ? null : details.onStepContinue,
                                  child: _activeStepIndex == 1
                                      ? Text(
                                          'Submit',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : Text(
                                          'Next',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      onSurface: Colors.green),
                                )),
                              ],
                            );
                          },
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

  Widget InformationForm() {
    return SingleChildScrollView(
      child: Form(
        autovalidateMode: triedNextInformationForm
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        key: informationFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(
                labelText: 'First name',
                prefixIcon: Icon(
                  Icons.account_circle_rounded,
                  color: Colors.green,
                  size: 28,
                ),
              ),
              validator: RequiredValidator(errorText: 'Required'),
              autocorrect: true,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(
                labelText: 'Last name',
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.green,
                  size: 28,
                ),
              ),
              validator: RequiredValidator(errorText: 'Required'),
              autocorrect: true,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: dobController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Date of birth',
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: Colors.green,
                  size: 24,
                ),
              ),
              validator: RequiredValidator(errorText: 'Required'),
              autocorrect: true,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              onTap: () => pickDate(context),
            ),
            SizedBox(
              height: 20,
            ),
            customDorpDown(
              child: DropdownButton<String>(
                underline: Container(
                  height: 0,
                ),
                isExpanded: true,
                hint: Text('Select your gender'),
                items: ['male', 'female'].map((value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                value: gender,
                onChanged: (String? value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
              icon: Icon(
                Icons.assignment_ind_outlined,
                color: Colors.green,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: nationalityController,
              decoration: InputDecoration(
                labelText: 'Nationality',
                prefixIcon: Icon(
                  Icons.article,
                  color: Colors.green,
                  size: 24,
                ),
              ),
              validator: RequiredValidator(errorText: 'Required'),
              autocorrect: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  Widget AddressForm() {
    return SingleChildScrollView(
      child: Form(
        autovalidateMode: triedNextAddressForm
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        key: addressFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: addressDetailsController,
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
                    min: 6,
                    max: 250,
                    errorText: 'address must be 10 to 250 character long')
              ]),
              autocorrect: true,
              keyboardType: TextInputType.streetAddress,
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
              validator: RequiredValidator(errorText: 'Required'),
              autocorrect: true,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: pinCodeController,
              decoration: InputDecoration(
                labelText: 'pin code',
                prefixIcon: Icon(
                  Icons.push_pin_rounded,
                  color: Colors.green,
                  size: 28,
                ),
              ),
              validator: MultiValidator([
                RequiredValidator(errorText: 'pin code required *'),
                PatternValidator(r'^[0-9]{6}$',
                    errorText: 'pincode must be a 6 digit number'),
              ]),
              autocorrect: true,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
            ),
            if (isLoading)
              SizedBox(
                height: 30,
              ),
            if (isLoading)
              CircularProgressIndicator(
                color: Colors.green,
              ),
            if (isLoading)
              SizedBox(
                height: 60,
              ),
            if (!isLoading)
              SizedBox(
                height: 100,
              ),
          ],
        ),
      ),
    );
  }
}
