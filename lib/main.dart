//import 'package:firebase/firebase.dart' ;
import 'package:flutter/material.dart';
import 'package:flutterfirebase/SampleHome.dart';
import 'package:flutterfirebase/style.dart';
import 'CollapseBarWidget.dart';
import 'FirebaseListWidget.dart';
import 'Form.dart';
import 'GridViewWidget.dart';
import 'ListViewWidget.dart';
import 'MyHomePageStateless.dart';
import 'NoteListWidget.dart';

void main() {
  //  initializeApp(
//      apiKey: "AIzaSyCp0UufiBQ7Z58O8iR-PZyONZcXllXGSnQ",
//      authDomain: "myflutter2-b7088.firebaseapp.com",
//      databaseURL: "https://myflutter2-b7088.firebaseio.com",
//      projectId: "myflutter2-b7088",
//      storageBucket: "myflutter2-b7088.appspot.com",
//      messagingSenderId: "975282894062",
//      appId: "1:975282894062:web:c692bfc58c3f655e7d6fff");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const routeHome = '/';
  static const routeInput = '/input';
  static const routeFirebase = '/fire';
  static const routeCollapse = '/colapse';
  static const routeExpand = '/expand';
  static const routeList = '/list';
  static const routeGrid = '/grid';
  static const routeSqlList = '/sqlList';
  static const routeSqlBloc = '/sqlBloc';

//   This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        routeHome: (context) => SampleHome(),
        routeInput: (context) => FormSample(),
        routeFirebase: (context) => FirebaseListWidget(),
        routeCollapse: (context) => CollapseBarWidget(),
        routeExpand: (context) => MyHomePageStateless(title: "yes"),
        routeList: (context) => ListViewWidget(title: "ListView Sample"),
        routeGrid: (context) => GridViewWidget(title: "GridView Sample"),
        routeSqlList: (context) => NoteWidget(),
        routeSqlBloc: (context) => NoteWidget(),
      },
      title: 'Sample',
      theme: ThemeData(
        appBarTheme:
            AppBarTheme(textTheme: TextTheme(headline6: AppBarTextStyle)),
        textTheme:
            TextTheme(headline6: TitleTextStyle, bodyText1: ContentTextStyle),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: routeHome,
    );
  }
}
