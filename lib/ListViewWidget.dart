import 'package:flutter/material.dart';
import 'model/Data.dart';

class ListViewWidget extends StatefulWidget {
  final String title;

  ListViewWidget({
    this.title,
  });

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState(title);
}

class _ListViewWidgetState extends State<ListViewWidget> {
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
    for (int x = 0; x < 24; x++) {
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

  _ListViewWidgetState(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, int position) {
//          var currentData = data[position];
          return ListCardItem(
              currentData: data[position],
              deleteOperation: () {
                setState(() {
                  data.remove(data[position]);
                });
              });
        },
      ),
    );
  }
}

class ListCardItem extends StatelessWidget {
  final Data currentData;
  final Function deleteOperation;

  ListCardItem({
    Key key,
    @required this.currentData,
    @required this.deleteOperation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: ListTile(
          onTap: () {
            print("Everything is so cool right from here");
          },
          title: Text(currentData.title),
          leading: CircleAvatar(
            child: Image.asset(
              currentData.imgPath,
              fit: BoxFit.cover,
            ),
          ),
          trailing: FlatButton.icon(
              onPressed: deleteOperation,
              icon: Icon(Icons.delete),
              label: Text("delete")),
        ),
      ),
    );
  }
}
