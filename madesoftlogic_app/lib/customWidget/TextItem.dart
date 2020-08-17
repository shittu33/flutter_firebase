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

class IconTxtButton extends StatelessWidget {
  const IconTxtButton({
    Key key,
    @required this.text,
    this.elevation,
    @required this.onPressed,
    this.icon,
  }) : super(key: key);

  final text;
  final double elevation;
  final Null Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: elevation,
//              color: Colors.blue,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon),
            SizedBox(width: 10),
            Text(text),
          ],
        ),
      ),
    );
  }
}

class EditText extends StatelessWidget {
  EditText(
      {this.txtController, this.startDrawable, this.label, this.initialText});

  final TextEditingController txtController;
  final IconData startDrawable;
  final String label;
  String initialText;
//  bool isFirst = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: txtController..text=initialText,
      decoration: InputDecoration(
          prefixIcon: Icon(startDrawable),
          labelText: label,
          border: OutlineInputBorder()),
    );
  }
}
