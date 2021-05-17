import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'new_todo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
  TextEditingController firstNameEditingController = TextEditingController();
  // TextEditingController lastNameEditingController = TextEditingController();

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
      appBar: AppBar(
        title: Text('SharedPreferences'),
      ),
      body: Column(
        children: [
          buildBody(),
          Spacer(),
          TextField(
            controller: titleController,
            autofocus: true,
            // onEditingComplete: submit,
            decoration:
                InputDecoration(labelText: 'Title', hintText: 'Enter Notes'),

            // onSubmitted: (value) {
            //   addTodo(Todo(title: value));
            //   setState(() {});
            // },
          ),
          ElevatedButton(
              onPressed: () {
                getTextInputData();
                titleController.clear();
              },
              child: Text('Save Note')),
          SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }

  // void saveStringToSP(String key, String value) {
  //   if (value.isNotEmpty && key.isNotEmpty) {
  //     sharedPreferences.setString(key, value);
  //   }
  // }

  Widget buildBody() {
    //  setState(() {});
    return Container(
      height: 400,
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
