import 'dart:convert';

//import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostDataApiScreen extends StatefulWidget {
  static const routeName = 'post-data-to-api';

  @override
  _PostDataApiScreenState createState() => _PostDataApiScreenState();
}

class _PostDataApiScreenState extends State<PostDataApiScreen> {
  @override
  Widget build(BuildContext context) {
    String name = '';
    String email = '';
    String id = '';
    TextEditingController titleControllerName = TextEditingController();
    TextEditingController titleControllerEmail = TextEditingController();
    TextEditingController titleControllerId = TextEditingController();

    String getName() {
      setState(() {
        name = titleControllerName.text;
      });
      print(name);
      return name;
    }

    // Dio dio = Dio();
    // Future postData(String a, String body, String id) async {
    //   final String pathUrl =
    //       'https://exceptional-studios.herokuapp.com/api/users/';
    //   dynamic data = jsonEncode([
    //     {"name": a, "email": body, "collegeId": id}
    //   ]);
    //   var response = await dio.post(pathUrl,
    //       data: data,
    //       options: Options(headers: {
    //         'Content-type': 'application/json',
    //       }));
    //   return response.data;
    // }
    String j = '';
    Future postData(String a, String b, String id) async {
      Map data = {
        "name": a,
        "email": b,
        "collegeId": id,
      };

      String body = json.encode(data);
      String url = 'https://exceptional-studios.herokuapp.com/api/users/';
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      return response.body;
    }

    String getEmail() {
      setState(() {
        email = titleControllerEmail.text;
        j = email;
      });
      print(email);
      return email;
    }

    String getCollegeId() {
      setState(() {
        id = titleControllerId.text;
      });
      print(id);
      return id;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: titleControllerName,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    hintText: "Type your name here",
                    hintStyle: TextStyle(fontSize: 16),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: "Full Name",
                    labelStyle: TextStyle(color: Colors.black)),

                // validator: _FormValidators.validateName,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                style: TextStyle(fontSize: 20),
                controller: titleControllerEmail,
                decoration: InputDecoration(
                    hintText: "Type your email here. (inclue @ / .com)",
                    hintStyle: TextStyle(fontSize: 16),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.black)),

                // validator: _FormValidators.validateName,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                style: TextStyle(fontSize: 20),
                controller: titleControllerId,
                decoration: InputDecoration(
                    hintText: "Type your college ID here",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: "College ID",
                    labelStyle: TextStyle(color: Colors.black)),

                // validator: _FormValidators.validateName,
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 70),
              child: Center(
                child: Container(
                  height: 60.0,
                  width: 210.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        elevation: 8.0,
                        primary: Colors.green,
                        shadowColor: Colors.black),
                    onPressed: (() async {
                      var a = getName();
                      var b = getEmail();
                      var c = getCollegeId();
                      print('posting data');
                      print(j);
                      //getData();
                      await postData(a, b, c).then((value) {
                        print(value);
                      });
                      titleControllerName.clear();
                      titleControllerEmail.clear();
                      titleControllerId.clear();
                    }),
                    child: Text(
                      'Post data to api',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            if (j != '')
              Padding(
                padding: EdgeInsets.only(bottom: 28.0),
                child: Center(
                  child: Text(
                    'You successfully post data to API.',
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
