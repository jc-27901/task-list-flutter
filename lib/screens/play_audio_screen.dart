import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:http/http.dart';

class PlayAudioScreen extends StatefulWidget {
  static const routeName = 'play-download-audio';

  @override
  _PlayAudioScreenState createState() => _PlayAudioScreenState();
}

class _PlayAudioScreenState extends State<PlayAudioScreen> {
  var url =
      Uri.parse('https://exceptional-studios.herokuapp.com/api/audio-task');
  String a = '';

  void getUrl() async {
    Response response = await get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      // print(a);
      print(data);
      var long = jsonDecode(data)['audio_file'];
      // var uname = jsonDecode(data)['name'];
      setState(() {
        a = long;
      });
      print(long);
      play(long);
      // setState(() {
      //   a = long;
      //   name = uname;
      // });
      //   print(a);
      //print(uname);
    } else {
      print(response.statusCode);
    }
  }

  final player = AudioPlayer();

  Future<void> play(String songUrl) async {
    await player.setUrl(songUrl);

    player.play();
  }

  void pause() {
    //  final player = AudioPlayer();
    player.pause();
  }

  Future<void> playLocalAudio() async {
    await player.setAsset('assets/note1.mp3');
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
            ),
            GestureDetector(
              onTap: () {
                pause();
              },
              child: Container(
                height: 180,
                width: 180,
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Tap here to stop audio',
              style: TextStyle(fontSize: 18),
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
                      primary: Colors.green,
                      shadowColor: Colors.black),
                  onPressed: (() {
                    // Navigator.of(context).pushNamed(DownloadFile.routeName);
                    // playSound();
                    getUrl();
                  }),
                  child: Text(
                    'Download & play',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 28.0),
              child: Center(
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
                    onPressed: (() {
                      playLocalAudio();
                    }),
                    child: Text(
                      'Play local audio',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            if (a != '')
              Text(
                'Your audio file is loading!',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800]),
              ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
