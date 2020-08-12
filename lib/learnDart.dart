import 'package:flutter/material.dart';

import 'customWidget/ImageBanner.dart';
import 'customWidget/TextItem.dart';
import 'model/Data.dart';

class LearnDart {
  String name;
  int age;
  String rank;
  final Function(String s) op;

  // list constructor
  LearnDart(this.op, {this.name, this.age, this.rank});

//Named constructor with named parameter
  LearnDart.name(this.op, {this.name = "john", this.age = 4, this.rank = "high"});
}
void TestLearn(){
  LearnDart((txt)=> print(Text),name:"",age:2,rank:"fine");
}
class ExpandedListWidget extends StatelessWidget {
  final List<Data> data = [
    Data(
        imgPath: "assets/bro.jpg",
        title: "Nigeria",
        details: " This is Nigeria, here we are coding for success"
            ", i repeat we are coding for success and everything is"
            " going to be fine sooner or later things are going to be fine just trust my judgement"),
    Data(
        imgPath: "assets/img.PNG",
        title: "Kenya",
        details: "This is Kenya, here we are coding for success"
            ", i repeat we are coding for success and everything is"
            " going to be fine sooner or later things are going to be fine just trust my judgement")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ExpandedListWidget'),
      ),
      body: Center(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[]..addAll(data
                .map((data) => Row(
                      children: <Widget>[
                        Expanded(flex: 1, child: ImageBanner(data.imgPath)),
                        Expanded(
                            flex: 1,
                            child: TextItem(data.title, "${data.details} fgr")),
                      ],
                    ))
                .toList()),
          ),
        ),
      ),
    );
  }
}

class ImageBanner extends StatelessWidget {
  final String _assetPath;

  ImageBanner(this._assetPath);

  @override
  Widget build(BuildContext context) {
    return Container(
//      constraints: BoxConstraints.expand(height: 200.0),
      constraints: BoxConstraints.expand(height: 100.0),
//      decoration: BoxDecoration(color: Colors.grey),
      child: Image.asset(
        _assetPath,
        fit: BoxFit.cover,
      ),
    );
  }
}

class TextItem extends StatelessWidget {
  final String _title;
  final String _body;
  static const double h_pad = 16.0;
  static const double v_pad = 4.0;

  TextItem([this._title, this._body]);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
//        color: _color,
          ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            Icon(Icons.mail,color: Colors.cyan,),
            Container(
              padding: const EdgeInsets.fromLTRB(h_pad, v_pad, h_pad, v_pad),
              child: Text(_title, style: Theme.of(context).textTheme.headline6
//                style: TextStyle(fontSize: 32
                  ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(h_pad, v_pad, h_pad, v_pad),
              child: Text(_body, style: Theme.of(context).textTheme.bodyText1
//                style: TextStyle(fontSize: 32
                  ),
            ),

//            Text(_body)
          ] /*..addAll(List())*/),
    );
  }
}
