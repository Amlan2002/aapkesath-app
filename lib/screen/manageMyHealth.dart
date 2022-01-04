import 'package:diabetes_app/widget/bottomNavigationBaWidget.dart';
import 'package:diabetes_app/widget/healthdata.dart';
import 'package:diabetes_app/widget/uploadImage.dart';
import 'package:flutter/material.dart';

class ManageMyHealth extends StatefulWidget {
  const ManageMyHealth({Key? key}) : super(key: key);

  // final VoidCallback moveToManageMyHealth;
  static const routeName = '/Manage-My-Health';

  @override
  _ManageMyHealthState createState() => _ManageMyHealthState();
}

class _ManageMyHealthState extends State<ManageMyHealth> {
  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Health Data'),
          content: const Center(
            child: HealthData(),
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Upload'),
            content: const Center(
              child: UploadImage(),
            )),
        Step(
            state: StepState.editing,
            isActive: _activeStepIndex >= 2,
            title: const Text('Confirm'),
            content: const Center(
              child: Text('Confirm'),
            )),
      ];

  int _activeStepIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(),
      appBar: AppBar(
        title: const Text("Manage My Health"),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepContinue: () {
          if (_activeStepIndex < (stepList().length - 1)) {
            _activeStepIndex += 1;
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
      ),
    );
  }
}
