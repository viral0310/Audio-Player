import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final assetsAudioPlayer = AssetsAudioPlayer();

  Duration totalDuration = Duration.zero;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.red,
                Colors.purple,
              ],
            ),
          ),
        ),
        leading: Icon(
          Icons.queue_music,
          size: 30,
          color: Colors.black,
        ),
        title: Text(
          "Audio Player",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(height: 10),
            ...Global.Songs.map(
              (e) => Column(
                children: [
                  Card(
                    color: Color(0xff252525),
                    surfaceTintColor: Colors.white,
                    semanticContainer: true,
                    shadowColor: Colors.red,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    elevation: 3,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(5),
                      visualDensity: VisualDensity.standard,
                      minVerticalPadding: 10,
                      enableFeedback: true,
                      focusColor: Colors.green,
                      enabled: true,
                      selected: true,
                      onTap: () {
                        setState(() {
                          Global.s = e;
                        });
                        Navigator.of(context).pushNamed('audio', arguments: e);
                      },
                      isThreeLine: true,
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(e['images']),
                            )),
                      ),
                      title: Text(
                        e['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      subtitle: Text(
                        e['singer'],
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ).toList(),
          ],
        ),
      ),
    );
  }
}
