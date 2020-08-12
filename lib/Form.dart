import 'package:flutter/material.dart';
import 'package:flutterfirebase/main.dart';
import 'package:sqflite/sqlite_api.dart';

import 'NoteListWidget.dart';
import 'customWidget/TextItem.dart';

class FormSample extends StatefulWidget {
  @override
  _FormSampleState createState() => _FormSampleState();
}

class _FormSampleState extends State<FormSample> {
  final tittleController = TextEditingController();
  final authorController = TextEditingController();
  final detailsController = TextEditingController();
  int currentStep = 0;
  bool complete = false;

  next(var steps) {
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
    if (complete) {
      Navigator.pop(context, {
        'details': detailsController.text,
        'tittle': tittleController.text,
        'author': authorController.text
      });
      print(tittleController.text);
    }
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
    tittleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var steps = <Step>[
      Step(
        subtitle: Text("specify note title"),
        content: Padding(
            padding: const EdgeInsets.all(18.0),
            child: EditText(
              label: "tittle",
              startDrawable: Icons.text_format,
              txtController: tittleController,
            )),
        title: Text("Tittle"),
      ),
      Step(
        subtitle: Text("Mention the author"),
        content: Padding(
          padding: const EdgeInsets.all(18.0),
          child: EditText(
              txtController: authorController,
              startDrawable: Icons.person_outline,
              label: "author"),
        ),
        title: Text("Author"),
      ),
      Step(
        content: Padding(
          padding: const EdgeInsets.all(18.0),
          child: EditText(
                txtController: detailsController,
              startDrawable: Icons.note_add,
              label: "Details"),
        ),
        title: Text("Note Content"),
      ),
//      Step(
//        content: Padding(
//          padding: const EdgeInsets.all(18.0),
//          child: IconTxtButton(
//            elevation: 3,
//            onPressed: () {
//              txtController.text;
//            },
//            icon: Icons.laptop_windows,
//            text: "register",
//          ),
//        ),
//        title: Text("Step 3"),
//      ),
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
//          complete
//              ? OptionAlertDialog(title: txtController.text)
//              :
          Stepper(
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
