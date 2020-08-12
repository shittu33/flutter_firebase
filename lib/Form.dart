import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

import 'NoteListWidget.dart';

class FormSample extends StatefulWidget {
  @override
  _FormSampleState createState() => _FormSampleState();
}

class _FormSampleState extends State<FormSample> {
  final txtController = TextEditingController();
  int currentStep = 0;
  bool complete = false;

  next(var steps) {
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  @override
  void dispose() {
    txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var steps = <Step>[
      Step(
        subtitle: Text("error"),
        content: Padding(
          padding: const EdgeInsets.all(18.0),
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail),
                labelText: "okay",
                border: OutlineInputBorder()),
          ),
        ),
        title: Text("Name"),
      ),
      Step(
        content: Padding(
          padding: const EdgeInsets.all(18.0),
          child: TextField(
            controller: txtController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail),
                labelText: "okay",
                border: OutlineInputBorder()),
          ),
        ),
        title: Text("Step 2"),
      ),
      Step(
        content: Padding(
          padding: const EdgeInsets.all(18.0),
          child: RaisedButton(
            elevation: 3,
//              color: Colors.blue,
            onPressed: () {
//              print("Who are you?");
              print(txtController.text);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.laptop_windows),
                  SizedBox(width: 10),
                  Text("Register"),
                ],
              ),
            ),
          ),
        ),
        title: Text("Step 3"),
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Forms"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.save),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          complete
              ? OptionAlertDialog(title: txtController.text)
              : Stepper(
                  steps: steps,
                  type: StepperType.vertical,
                  currentStep: currentStep,
                  onStepContinue: () => next(steps),
                  onStepCancel: () => cancel(),
                  onStepTapped: (step) => goTo(step),
                ),
        ],
      ),
    );
  }
}
