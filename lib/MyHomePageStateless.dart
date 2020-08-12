import 'package:flutter/material.dart';
import 'customWidget/ImageBanner.dart';
import 'customWidget/TextItem.dart';
import 'model/Data.dart';

class MyHomePageStateless extends StatelessWidget {
  MyHomePageStateless({Key key, this.title}) : super(key: key) {
    for (int i = 0; i < 12; i++) {
      data.add(Data(
          imgPath: "assets/bro.jpg",
          title: "Nigeria",
          details: " This is Nigeria, here we are coding for success"
              ", i repeat we are coding for success and everything is"
              " going to be fine sooner or later things are going to be fine just trust my judgement"));
    }
  }

  final String title;

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
        title: Text(title),
      ),
      body: Center(
        child: ListWidget(data: data),
      ),
    );
  }
}

class ListWidget extends StatelessWidget {
  const ListWidget({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List<Data> data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
//        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        mainAxisSize: MainAxisSize.max,
//        direction: Axis.horizontal,
//        verticalDirection: VerticalDirection.up,
//        mainAxisAlignment: MainAxisAlignment.start,
//        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(flex: 1, child: ImageBanner("assets/bro.jpg")),
          Expanded(
            flex: 1,
            child: TextItem(
                "Nigeria",
                "This is Nigeria, here we are coding for success"
                    ", i repeat we are coding for success and everything is"
                    " going to be fine sooner or later things are going to be fine just trust my judgement"),
          ),
        ]..addAll(data
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
    );
  }
}
