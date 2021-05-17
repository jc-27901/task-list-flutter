import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseLocalScreen extends StatefulWidget {
  static const routeName = 'working-with-local-database';

  @override
  _DatabaseLocalScreenState createState() => _DatabaseLocalScreenState();
}

class _DatabaseLocalScreenState extends State<DatabaseLocalScreen> {
  SharedPreferences sharedPreferences;
  // ignore: deprecated_member_use
  List<Todo> list = List<Todo>();
  @override
  void initState() {
    loadSharedPreferences();
    super.initState();
  }

  void loadSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  TextEditingController titleController = TextEditingController();
  String result = '';
  getTextInputData() {
    setState(() {
      result = titleController.text;
      addTodo(Todo(title: result));
    });
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Data fetched from local db.',
                style: TextStyle(fontSize: 17),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'This is example text from local database.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            buildBody(),
            Spacer(),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: titleController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "Type a note here",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  // validator: _FormValidators.validateName,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0, left: 20, right: 20),
              child: Center(
                child: Container(
                  height: 60.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 8.0,
                        primary: Colors.green,
                        shadowColor: Colors.black),
                    onPressed: (() {
                      getTextInputData();
                      titleController.clear();
                    }),
                    child: Text(
                      'Save Data',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    //  setState(() {});
    return Container(
      height: 150,
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return buildListTile(list[index]);
          }),
    );
  }

  Widget buildListTile(Todo item) {
    return ListTile(
      title: Text(item.title),
    );
  }

  void addTodo(Todo item) {
    list.add(item);
    saveData();
  }

  void saveData() {
    List<String> spList = list.map((item) => jsonEncode(item.toMap())).toList();
    sharedPreferences.setStringList('list', spList);
    print(spList);
  }

  void loadData() {
    List<String> spList = sharedPreferences.getStringList('list');
    list = spList.map((item) => Todo.fromMap(jsonDecode(item))).toList();
    setState(() {});
  }
}

class Todo {
  String title;
  Todo({
    this.title,
  });

  Todo.fromMap(Map map) : this.title = map['title'];

  Map toMap() {
    return {
      'title': this.title,
    };
  }
}
