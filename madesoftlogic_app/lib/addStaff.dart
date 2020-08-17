import 'package:flutter/material.dart';

import 'Data.dart';
import 'customSwitch.dart';
import 'customWidget/popUp.dart';

class AddStaffScreen extends StatefulWidget {
  @override
  _AddStaffScreenState createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
  List<Data> staffLabels = [
    Data("Name of Staff", type: Data.TYPE_INPUT),
    Data("Email", type: Data.TYPE_INPUT),
    Data("Address", type: Data.TYPE_INPUT),
    Data("Phone No", type: Data.TYPE_INPUT),
    Data("Password", type: Data.TYPE_INPUT),
    Data("Staff Image", type: Data.BUTTON),
    Data("Select Staff Location", type: Data.PURE),
    Data("Select Staff Access Rights", type: Data.TYPE_INPUT),
    Data("Access to Sales Register", type: Data.PURE),
    Data("Online Pos"),
    Data("All Sales Reports"),
  ];
  bool _enable = false;

  @override
  Widget build(BuildContext context) {
    var labelText = "Name of Staff";
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.pink,
            ),
          ),
          actions: [
            TextPopUpMenuButton(
              iconColor: Colors.pink,
              onButtonTap: (choice) {},
              list: ["settings"],
            ),
            SizedBox(
              width: 20,
            )
          ]),
      body: ListView(
          children: staffLabels.map((data) {
        switch (data.type) {
          case Data.PURE:
            return Padding(
              padding: const EdgeInsets.fromLTRB(28.0, 0, 0, 0),
              child: Text(data.label),
            );
            break;
          case Data.BUTTON:
            return Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.label),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
//                      decoration: BoxDecoration(border: Outli()),
                      child: OutlineButton(
                          borderSide: BorderSide(color: Colors.pink),
                          onPressed: () {},
                          child: Text("Select File")))
                ],
              ),
            );
            break;
          case Data.TYPE_INPUT:
            return StaffEntryWidget(labelText: data.label);
          default:
            return Switch(
              value: true,
              onChanged: (bool val){
                setState(() {
//                  _enabled = val;
                });
              },
            );
        }
      }).toList()
          /*children: [
        StaffEntryWidget(labelText: labelText)
      ],*/
          ),
    );
  }
}

class StaffEntryWidget extends StatelessWidget {
  const StaffEntryWidget({
    Key key,
    @required this.labelText,
  }) : super(key: key);

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: TextField(
        decoration: InputDecoration(labelText: labelText),
      ),
    );
  }
}
