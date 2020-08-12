import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customWidget/TabWidgets.dart';
import 'main.dart';

class SampleHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.phone), title: Text("Login")),
          BottomNavigationBarItem(
              icon: Icon(Icons.laptop), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.radio), title: Text("SignOut")),
        ]),
        appBar: AppBar(
          title: Text('Sample Home'),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  child: Container(
                      constraints: BoxConstraints.expand(),
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Image.asset("assets/bro.jpg"))),
              DrawerItem(title: "settings"),
              DrawerItem(title: "about"),
              DrawerItem(title: "tutorial"),
              DrawerItem(title: "Story"),
              DrawerItem(title: "Names"),
            ],
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, isScroll) {
            return <Widget>[
              TabWidget(
                tabsList: [
                  new Tab(
                    text: "Contact",
                  ),
                  new Tab(
                    text: "profile",
                  ),
                  new Tab(
                    text: "schedule",
                  ),
                ],
                unselectedColor: Colors.grey,
                selectedColor: Colors.black,
              ),
            ];
          },
          body: MainWidget(),
        ));
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pop(context),
      title: Text(title),
      leading:
          CircleAvatar(child: Image.asset("assets/img.PNG", fit: BoxFit.fill)),
    );
  }
}

class MainWidget extends StatelessWidget {
  static const simple = "Simple  Example";
  static const input = "input  Example";
  static const list = "ListView  Example";
  static const grid = "GridView  Example";
  static const fire = "Firebase  Example";
  static const sqlList = "Sqlite List  Example";
  static const sqlBloc = "Sqlite Bloc  Example";
  static const collapseSample = "Collapse  Example";

  final List<String> samples = [
    simple,
    input,
    list,
    grid,
    fire,
    sqlList,
    sqlBloc,
    collapseSample
  ];

  MainWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(58.0),
        child: ListView(
          children: samples
              .map((sample) => GestureDetector(
                    onTap: () {
                      switch (sample) {
                        case simple:
                          Navigator.pushNamed(context, MyApp.routeExpand);
                          break;
                        case input:
                          Navigator.pushNamed(context, MyApp.routeInput);
                          break;
                        case fire:
                          Navigator.pushNamed(context, MyApp.routeFirebase);
                          break;
                        case list:
                          Navigator.pushNamed(context, MyApp.routeList);
                          break;
                        case grid:
                          Navigator.pushNamed(context, MyApp.routeGrid);
                          break;
                        case sqlList:
                          Navigator.pushNamed(context, MyApp.routeSqlList);
                          break;
                        case sqlBloc:
                          Navigator.pushNamed(context, MyApp.routeSqlBloc);
                          break;
                        case collapseSample:
                          Navigator.pushNamed(context, MyApp.routeCollapse);
                          break;
                        default:
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Not available yet"),
                            action: SnackBarAction(
                              label: "ok",
                              onPressed: () {
                                print(simple);
                              },
                            ),
                          ));
                      }
                    },
                    child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                              child: Text(
                                sample,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.deepPurple),
                              )),
                        )),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
