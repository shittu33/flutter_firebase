
class Data {
  static const TYPE_INPUT=1;
  static const PURE=2;
  static const SWITCH=3;
  static const BUTTON=4;
  String label;
  int type;


  Data(this.label, {this.type=SWITCH});


}