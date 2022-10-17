import 'package:app_settings/app_settings.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'global.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({Key? key}) : super(key: key);

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  final assetsAudioPlayer = AssetsAudioPlayer();

  Duration totalDuration = Duration.zero;
  double pitch = 1.1;
  double normal = 1.0;

  MyAudio() async {
    await Global.s['asset audio'].open(
      Audio(Global.s['song']),
      autoStart: false,
    );

    setState(() {
      Global.s['totalDuration'] =
          Global.s['asset audio'].current.value!.audio.duration;
    });
  }

  bool isPlaying = false;
  bool isRandom = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MyAudio();
  }

  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;
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
        leading: IconButton(
          onPressed: () async {
            await res['asset audio'].pause();
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
            size: 30,
          ),
        ),
        title: Text(
          "Music World",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async {
                    await res['asset audio'].setPitch(pitch);
                    setState(() {
                      pitch = pitch + 0.1;
                    });
                  },
                  icon: Icon(
                    Icons.music_note_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    setState(() async {
                      await res['asset audio'].setPitch(normal);
                    });
                  },
                  icon: Icon(
                    Icons.music_off_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
            Text(
              "${res['name']}",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 60,
                color: Colors.white,
              ),
            ),
            Text(
              "${res['singer']}",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage(res['images']),
                ),
                (isPlaying)
                    ? SleekCircularSlider(
                        appearance: CircularSliderAppearance(
                          spinnerMode: true,
                          angleRange: 10,
                          animationEnabled: true,
                          counterClockwise: true,
                          spinnerDuration: Duration.secondsPerHour,
                          size: 220,
                          customWidths: CustomSliderWidths(
                            progressBarWidth: 10,
                            shadowWidth: 10,
                            trackWidth: 10,
                          ),
                          customColors: CustomSliderColors(
                            dotColor: Colors.red,
                            dynamicGradient: true,
                            gradientEndAngle: 50,
                            gradientStartAngle: 50,
                            progressBarColor: Colors.red,
                            trackGradientEndAngle: 180,
                            shadowMaxOpacity: 1,
                            shadowColor: Colors.red,
                            trackColor: Colors.purple,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            SizedBox(height: 30),
            Text(
              "Weekend",
              style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
                  stream: res['asset audio'].currentPosition,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    Duration? currentPosition = snapshot.data;
                    var duration = res['totalDuration'];

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "$currentPosition".split(".")[0].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 200),
                            Text(
                              "$duration".split(".")[0].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 370,
                          child: Slider(
                            activeColor: Colors.red,
                            inactiveColor: Colors.redAccent,
                            thumbColor: Colors.purple,
                            min: 0,
                            max: res['totalDuration'].inSeconds.toDouble(),
                            value: currentPosition!.inSeconds.toDouble(),
                            onChanged: (val) async {
                              await res['asset audio']
                                  .seek(Duration(seconds: val.toInt()));
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isRandom = (isRandom) ? false : true;
                                });
                              },
                              icon: Icon(
                                Icons.sync_alt,
                                size: 30,
                                color: (isRandom) ? Colors.green : Colors.white,
                              ),
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              onPressed: () async {
                                await res['asset audio']
                                    .seekBy(Duration(seconds: -5));
                              },
                              icon: Icon(
                                Icons.skip_previous,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 20),
                            SizedBox(
                              height: 90,
                              width: 80,
                              child: FittedBox(
                                child: FloatingActionButton(
                                  backgroundColor: Colors.red,
                                  elevation: 20,
                                  enableFeedback: true,
                                  highlightElevation: 20,
                                  splashColor: Colors.purple,
                                  isExtended: true,
                                  mini: false,
                                  onPressed: () async {
                                    setState(() {
                                      isPlaying = (isPlaying) ? false : true;
                                    });
                                    (isPlaying)
                                        ? await res['asset audio'].play()
                                        : await res['asset audio'].pause();
                                  },
                                  child: (isPlaying)
                                      ? const Icon(
                                          Icons.pause,
                                          color: Colors.white,
                                          size: 50,
                                        )
                                      : const Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              onPressed: () async {
                                await res['asset audio']
                                    .seekBy(Duration(seconds: 5));
                              },
                              icon: Icon(
                                Icons.skip_next,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              onPressed: () {
                                AppSettings.openBluetoothSettings();
                              },
                              icon: Icon(
                                Icons.bluetooth_audio,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            SizedBox(width: 30),
          ],
        ),
      ),
    );
  }
}
