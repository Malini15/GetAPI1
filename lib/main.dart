import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(Page());
}

class Page extends StatelessWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Page1(),
    );
  }
}

List listdata = [];

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  Future<List> getapi() async {
    /* var url = 'https://api.github.com/repositories/19438/issues';
    var uri = Uri.parse(url);
    var dataurl = await http.get(uri);*/
    http.Response dataurl;
    dataurl = await http
        .get(Uri.parse('https://api.github.com/repositories/19438/issues'));
    List listdata = jsonDecode(dataurl.body);
    return listdata;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: FutureBuilder(
          future: getapi(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List mydata = snapshot.data;
              return ListView.builder(
                  itemCount: mydata.length,
                  itemBuilder: (BuildContext context, index) {
                    final data = mydata[index];
                    final mapdata = data['user'];
                    return ListTile(
                      title: Text(data['title'].toString()),
                      subtitle: Text(mapdata['login'].toString()),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
