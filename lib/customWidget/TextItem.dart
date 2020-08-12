import 'package:flutter/material.dart';

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
