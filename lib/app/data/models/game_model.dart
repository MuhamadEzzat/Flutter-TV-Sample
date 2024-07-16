import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class Game {
  final int id;
  final String name, key, image, girlImage;
  final String? voice, url;
  final GameType type;
  final DateTime? creationDate, lastModificationDate;
  final bool free;

  Game({
    required this.id,
    required this.name,
    required this.key,
    required this.image,
    required this.girlImage,
    required this.voice,
    required this.url,
    required this.type,
    required this.creationDate,
    required this.lastModificationDate,
    required this.free,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    debugPrint("GamesssJson $json");
    bool isAr = Get.locale?.languageCode == "ar";

    return Game(
      id: json['id'],
      name: isAr ? json['name'] : json['nameInEnglish'] ?? "",
      key: json['gameKey'],
      image: json['image'],
      girlImage: json['girlImage'] ?? json['image'],
      voice: json['voice'],
      url: json['url'] ?? '',
      type: json['type'] == 'Html5' ? GameType.Html5 : GameType.Unity,
      creationDate: DateTime.tryParse(json['createdDate']),
      lastModificationDate: DateTime.tryParse(json['lastModifiedDate']),
      free: json['free'] ?? (json['isFree'] ?? true),
    );
  }

  factory Game.withError() => Game(
        id: -1,
        name: 'name',
        key: 'key',
        image: 'image',
        girlImage: 'image',
        url: '',
        voice: '',
        type: GameType.Unity,
        creationDate: null,
        lastModificationDate: null,
        free: false,
      );

  @override
  String toString() {
    return 'Game{id: $id, name: $name, key: $key, image: $image, voice: $voice, url: $url, type: $type, free: $free}';
  }
}

enum GameType {
  Html5,
  Unity,
}
