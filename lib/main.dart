import 'package:adio_player/audio_page.dart';
import 'package:adio_player/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        'audio': (context) => AudioPage(),
      },
    ),
  );
}
