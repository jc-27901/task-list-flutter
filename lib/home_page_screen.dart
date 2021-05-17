import 'package:flutter/material.dart';
import 'package:task_list/screens/database_screen.dart';
import 'package:task_list/screens/linear_graph_screen.dart';
import 'package:task_list/screens/load_data_api_screen.dart';
import 'package:task_list/screens/load_list_api.dart';
import 'package:task_list/screens/play_audio_screen.dart';
import 'package:task_list/screens/postData_api_screen.dart';
import 'package:task_list/screens/send_notification_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<HomepageModel> taskInfo = [
      HomepageModel('Task 1', 'Fetching data from api', Colors.red,
          LoadDataApiScreen.routename),
      HomepageModel('Task 2', 'Working with list view', Colors.black87,
          LoadListFromApi.routeName),
      HomepageModel('Task 3', 'Post data to api', Colors.yellow,
          PostDataApiScreen.routeName),
      HomepageModel('Task 4', 'Working with audio', Colors.purple,
          PlayAudioScreen.routeName),
      HomepageModel('Task 5', 'Working with graphs', Colors.green,
          LinearGraphScreen.routeName),
      HomepageModel('Task 6', 'Save data locally', Colors.red,
          DatabaseLocalScreen.routeName),
      HomepageModel('Task 7', 'Show notifications', Colors.pink,
          SendNotificationScreen.routeName),
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  'Task List',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                height: 600,
                child: ListView.builder(
                  //  shrinkWrap: true,
                    itemCount: taskInfo.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(taskInfo[index].routeNames);
                        },
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          height: 77,
                          width: double.infinity,
                          color: taskInfo[index].containerColor,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15.0, top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      taskInfo[index].taskNumber,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      taskInfo[index].description,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Icon(
                                  Icons.play_arrow_outlined,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomepageModel {
  final String taskNumber;
  final String description;
  final Color containerColor;
  final String routeNames;

  HomepageModel(
      this.taskNumber, this.description, this.containerColor, this.routeNames);
}
