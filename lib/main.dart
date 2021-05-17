import 'package:flutter/material.dart';
import 'package:task_list/functions/download_data_screen.dart';

import 'package:task_list/home_page_screen.dart';
import 'package:task_list/screens/load_list_from_api.dart';
import 'package:task_list/screens/database_screen.dart';
import 'package:task_list/screens/linear_graph_screen.dart';
import 'package:task_list/screens/load_data_api_screen.dart';

import 'package:task_list/screens/play_audio_screen.dart';
import 'package:task_list/screens/postData_api_screen.dart';
import 'package:task_list/screens/send_notification_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        LoadDataApiScreen.routename: (ctx) => LoadDataApiScreen(),
        LoadlistJson.routename: (ctx) => LoadlistJson(),
        // LoadListFromApi.routeName: (ctx) => LoadListFromApi(),
        PostDataApiScreen.routeName: (ctx) => PostDataApiScreen(),
        PlayAudioScreen.routeName: (ctx) => PlayAudioScreen(),
        LinearGraphScreen.routeName: (ctx) => LinearGraphScreen(),
        DatabaseLocalScreen.routeName: (ctx) => DatabaseLocalScreen(),
        SendNotificationScreen.routeName: (ctx) => SendNotificationScreen(),
        DownloadFile.routeName: (ctx) => DownloadFile(),
      },
    );
  }
}
