import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      title: Text(widget.title),
    ),
    body: Center(
      child: Stepper(
        steps: steps,
        type: StepperType.horizontal,
        currentStep: currentStep,
        onStepContinue: () => next(steps),
        onStepCancel: () => cancel(),
        onStepTapped: (step) => goTo(step),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: (){},
      tooltip: 'Increment',
      child: Icon(Icons.add),
    ), // This trailing comma makes auto-formatting nicer for build methods.
  );
}}
