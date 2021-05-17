import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class LoadListFromApi extends StatefulWidget {
  static const routeName = 'load-list-from-api';

  @override
  _LoadListFromApiState createState() => _LoadListFromApiState();
}

class _LoadListFromApiState extends State<LoadListFromApi> {
  var url = Uri.parse('https://exceptional-studios.herokuapp.com/api/users/');

  @override
  List<ListInfo> _items = [
    ListInfo('Shiromi takkanu', ''),
    ListInfo('Damaso', ''),
    ListInfo('Annie Lannister', ''),
    ListInfo('James Franko', ''),
  ];

  void getData() async {
    Response response = await get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);

      var long = jsonDecode(data)[0]['name'];
      print(long);
    } else {
      print(response.statusCode);
    }
  }

  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //   FutureBuilder(builder: ,future: Net,)
            ListView.builder(
                shrinkWrap: true,
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey,
                    ),
                    height: 80,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            _items[index].name,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue,
                            //backgroundImage: NetworkImage(items[index].imgUrl),
                          ),
                        )
                      ],
                    ),
                  );
                }),
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
                  onPressed: (() {}),
                  child: Text(
                    'Load list from api',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 28.0),
              child: Center(
                child: Text(
                  'List successfully fetched from API.',
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

class ListInfo {
  final String name;
  final String imgUrl;

  ListInfo(this.name, this.imgUrl);
}
