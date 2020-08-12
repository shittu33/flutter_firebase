import 'package:flutter/material.dart';
import 'model/Data.dart';

class GridViewWidget extends StatefulWidget {
  final String title;

  GridViewWidget({
    this.title,
  });

  @override
  _GridViewWidgetState createState() => _GridViewWidgetState(title);
}

class _GridViewWidgetState extends State<GridViewWidget> {
  final String title;
  List<Data> data = [
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
            " going to be fine sooner or later things are going to be fine just trust my judgement"),
    Data(
        imgPath: "assets/bro.jpg",
        title: "Nairobi",
        details: " This is Nairobi, here we are coding for success"
            ", i repeat we are coding for success and everything is"
            " going to be fine sooner or later things are going to be fine just trust my judgement"),
  ];

  @override
  void initState() {
    super.initState();
    for (int x = 0; x < 34; x++) {
      data.add(
        Data(
            imgPath: "assets/bro.jpg",
            title: "Nairobi",
            details: " This is Nairobi, here we are coding for success"
                ", i repeat we are coding for success and everything is"
                " going to be fine sooner or later things are going to be fine just trust my judgement"),
      );
    }
  }

  _GridViewWidgetState(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GridView.builder(
        itemCount: data.length,
        itemBuilder: (context, int position) {
//          var currentData = data[position];
          return CardItem(
              currentData: data[position],
              deleteOperation: () {
                setState(() {
                  data.remove(data[position]);
                });
              });
        },
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final Data currentData;
  final Function deleteOperation;

  const CardItem({
    Key key,
    @required this.currentData,
    @required this.deleteOperation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        elevation: 6,
        child: GridTile(
//          onTap: () {
//            print("Everything is so cool right from here");
//          },
//          contentPadding: EdgeInsets.all(12),
          header: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(currentData.title,style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),)),
          ),
//child:TextItem("okay",""),
          child: Container(
            constraints: BoxConstraints.expand(width: 100.0, height: 900.0),
            child: Center(
              child: CircleAvatar(
               radius: 32,
                  child: Image.asset(
                currentData.imgPath,
                fit: BoxFit.cover,
              )),
            ),
          ),
          footer: FlatButton.icon(
              onPressed: deleteOperation,
              icon: Icon(Icons.delete),
              label: Text("delete")),
        ),
      ),
    );
  }
}
