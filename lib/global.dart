import 'package:assets_audio_player/assets_audio_player.dart';

class Global {
  static Map s = {};
  static List<Map> Songs = [
    {
      'name': 'Baby',
      'song': 'assets/audio/baby.mp3',
      'images': 'assets/images/baby.jpg',
      'singer': "Justin Bieber",
      'asset audio': AssetsAudioPlayer(),
      'totalDuration': Duration.zero,
    },
    {
      'name': 'Closer',
      'song': 'assets/audio/smoker.mp3',
      'images': 'assets/images/closer.jpg',
      'singer': "Chain Smoker",
      'asset audio': AssetsAudioPlayer(),
      'totalDuration': Duration.zero,
    },
    {
      'name': 'Despacito',
      'song': 'assets/audio/despacito.mp3',
      'images': 'assets/images/despacito.jpg',
      'singer': "Luis Fonsi",
      'asset audio': AssetsAudioPlayer(),
      'totalDuration': Duration.zero,
    },
    {
      'name': 'Faded',
      'song': 'assets/audio/faded.mp3',
      'images': 'assets/images/faded.jpg',
      'singer': "Alan Walker",
      'asset audio': AssetsAudioPlayer(),
      'totalDuration': Duration.zero,
    },
    {
      'name': 'Girls like you..',
      'song': 'assets/audio/maroon.mp3',
      'images': 'assets/images/maroon.jpg',
      'singer': "Maroon 5",
      'asset audio': AssetsAudioPlayer(),
      'totalDuration': Duration.zero,
    },
    {
      'name': 'See you again',
      'song': 'assets/audio/see.mp3',
      'images': 'assets/images/see.jpg',
      'singer': "Wiz Khalifa",
      'asset audio': AssetsAudioPlayer(),
      'totalDuration': Duration.zero,
    },
    {
      'name': 'Closer-Indian',
      'song': 'assets/audio/closer.mp3',
      'images': 'assets/images/v.png',
      'singer': "Vidhya Vox",
      'asset audio': AssetsAudioPlayer(),
      'totalDuration': Duration.zero,
    },
  ];
}
