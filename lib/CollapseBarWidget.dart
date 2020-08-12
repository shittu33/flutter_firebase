import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'NoteListWidget.dart';
import 'SampleHome.dart';
import 'customWidget/TabWidgets.dart';


class CollapseBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, isScroll) {
            return [
              CollapseAppBar(
                expandedHeight: 235,
//                leading: Icon(Icons.arrow_back_ios),
                centerTitle: true,
                title: Text("Collapse It!!!"),
                background: Image.asset(
                  "assets/bro.jpg",
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                ),
                actions: <Widget>[
                  TextPopUpMenuButton(
                      icon: Icons.directions_run,
                      list: ["delete", "contact", "say Hi"],
                      onButtonTap: (choice) {}),
                  TextPopUpMenuButton(
                      list: ["delete", "contact", "say Hi"],
                      onButtonTap: (choice) {}),
                ],
              ),
              TabWidget(
                unselectedColor: Colors.grey,
                selectedColor: Colors.black,
                tabsList: [
                  new Tab(
                    icon: Icon(Icons.phone),
                    text: "Contact",
                  ),
                  new Tab(
                    icon: Icon(Icons.person_outline),
                    text: "profile",
                  ),
                  new Tab(
                    icon: Icon(Icons.access_alarms),
                    text: "schedule",
                  ),
                ],
              )
            ];
          },
          body: Center(child: MainWidget())),
    );
  }
}

