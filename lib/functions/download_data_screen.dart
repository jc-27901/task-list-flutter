import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

final imgUrl =
    "https://mp3.fastupload.co/dl.php?file=YUhSMGNITTZMeTl0Y0RNdVptRnpkSFZ3Ykc5aFpDNWpieTlrWVhSaEx6RTJNakV3TmpFd09ESXZibTkwWlRFdWJYQXo=";
var dio = Dio();

class DownloadFile extends StatefulWidget {
  static const routeName = 'downolad-screen';
  DownloadFile({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DownloadFileState createState() => _DownloadFileState();
}

class _DownloadFileState extends State<DownloadFile> {
  int _counter = 0;
  bool showImage = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future download2(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
      print(1);
      String a = (received / total * 100).toStringAsFixed(0);
      if (a == '100') {
        setState(() {
          showImage = true;
        });
      } else {}
    }
  }

  void playSound(File f) {
    final player = AudioCache();
    player.play('');
  }

  Widget downLoadComplete() {
    print('2');
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          color: Colors.black,
        ),
        TextButton(
            onPressed: () {
              // playSound('/data/user/0/vasu.dev.task_list/cache/boo2.mp3');
              print('hii');
            },
            child: Text('click to play')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download'),
      ),
      body: showImage
          ? downLoadComplete()
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton.icon(
                      onPressed: () async {
                        var tempDir = await getTemporaryDirectory();
                        String fullPath = tempDir.path + "/boo2.mp3";
                        print('full path ${fullPath}');

                        download2(dio, imgUrl, fullPath);
                      },
                      icon: Icon(
                        Icons.file_download,
                        color: Colors.white,
                      ),
                      color: Colors.green,
                      textColor: Colors.white,
                      label: Text('Dowload Invoice')),
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.display1,
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
