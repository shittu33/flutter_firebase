import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterfirebase/main.dart';
import 'package:flutterfirebase/model/NoteFire.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqlite_api.dart';

import 'NoteListWidget.dart';
import 'customWidget/TextItem.dart';

class StdFormScreen extends StatefulWidget {
  @override
  _StdFormScreenState createState() => _StdFormScreenState();
}

class _StdFormScreenState extends State<StdFormScreen> {
  final _picker = ImagePicker();

  final tittleController = TextEditingController();
  final authorController = TextEditingController();
  final detailsController = TextEditingController();
  int currentStep = 0;
  bool complete = false;
  bool isFirst = true;

  next(var steps) async {
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
    if (complete) {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      final File file = File(pickedFile.path);
//      Navigator.pop(context, {
//        NoteFire.fieldDetail: detailsController.text,
//        NoteFire.fieldTitle: tittleController.text,
//        NoteFire.fieldAuthor: authorController.text
//      });
    }
  }

  goTo(int step) {
    setState(() {
      isFirst=false;
      return currentStep = step;
    });
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  @override
  void dispose() {
    tittleController.dispose();
    authorController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic data = ModalRoute.of(context).settings.arguments;
    NoteFire note;
    if (data!= null && data.isNotEmpty) {
      note = NoteFire.fromMap(data);
    }
    var steps = <Step>[
      Step(
        subtitle: Text("specify note title"),
        content: Padding(
            padding: const EdgeInsets.all(18.0),
            child: EditText(
              initialText: isFirst?(note!=null?note.title:""):(tittleController.text),
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
              initialText: isFirst?(note!=null?note.author:""):(authorController.text),
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
              initialText: isFirst?(note!=null?note.details:""):(detailsController.text),
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
        title: Text("Student Registration"),
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
