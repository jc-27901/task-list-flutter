import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoadDataApiScreen extends StatefulWidget {
  static const routename = 'load-data-from-api';

  @override
  _LoadDataApiScreenState createState() => _LoadDataApiScreenState();
}

class _LoadDataApiScreenState extends State<LoadDataApiScreen> {
  var url = Uri.parse('https://exceptional-studios.herokuapp.com/api/users/1/');
  String a = '';
  String name = '';
  void getData() async {
    Response response = await get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);

      var long = jsonDecode(data)['image_url'];
      print(long);
    } else {
      print(response.statusCode);
    }
  }

  void getUrl() async {
    Response response = await get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      print(a);
      print(data);
      var long = jsonDecode(data)['image_url'];
      var uname = jsonDecode(data)['name'];

      print(long);
      setState(() {
        a = long;
        name = uname;
      });
      print(a);
      print(uname);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(a),
                //backgroundColor: Colors.blue,
                radius: 70.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Spacer(),
            Center(
              child: Container(
                height: 60.0,
                width: 210.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      elevation: 8.0,
                      primary: Colors.black,
                      shadowColor: Colors.black),
                  onPressed: (() async {
                    // getData();
                    getUrl();
                  }),
                  child: Text(
                    'Load data from api',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            if (a != '')
              Padding(
                padding: EdgeInsets.only(bottom: 28.0),
                child: Center(
                  child: Text(
                    'Name successfully fetched from API.',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800]),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
