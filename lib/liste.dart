import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  Future<List> getData() async {
    var url = "http://172.20.10.2/isig_2020/getdata.php";
    final reponse = await http.get(Uri.parse(url));
    return json.decode(reponse.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Liste Personnes"),
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(list: snapshot.data ?? [])
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List? list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list?.length,
      itemBuilder: (context, i) {
        return ListTile(
          title: new Text(list?[i]['nom']),
          leading: new Icon(Icons.widgets),
          subtitle: new Text("${list?[i]['adresse']}"),
        );
      },
    );
  }
}
