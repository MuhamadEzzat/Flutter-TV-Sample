import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:multimedia_tv_sample/app/data/models/video_model.dart';

class GameCategoryModel {
  final int? id;
  final String? name, description, image, status;
  final String? voice;
  final DateTime? creationDate, publishDate, lastModifiedDate;

  //final List<Game>? games;
  final Video? promoWithMusic, promoWithoutMusic;

  GameCategoryModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.status,
    this.creationDate,
    this.publishDate,
    this.lastModifiedDate,
    this.voice,
    //this.games,
    this.promoWithMusic,
    this.promoWithoutMusic,
  });

  factory GameCategoryModel.fromJson(Map<String, dynamic> json) {
    final games = json['games'] as List<dynamic>?;
    debugPrint("game res: $json");
    bool isAr = Get.locale?.languageCode == "ar";

    return GameCategoryModel(
      id: json['id'],
      name: isAr ? json['name'] : json['nameInEnglish'] ?? "",
      description:
          isAr ? json['description'] : json['descriptionInEnglish'] ?? "",
      image: json['image'],
      status: json['status'],
      // creationDate: DateTime.tryParse(json['createdDate']),
      // publishDate: DateTime.tryParse(json['publishDate']),
      // lastModifiedDate: DateTime.tryParse(json['lastModifiedDate'] ?? ''),
      voice: json['voice'],
      // games: (_games??[]).map((game) => Game.fromJson(game)).toList().skipWhile((game) => game.status == 'SUSPENDED').toList( ),
      promoWithMusic: json['promoWithMusicId'] == null
          ? Video(id: -1, duration: 0, url: "Error")
          : Video.fromJson(json['promoWithMusicId']),
      promoWithoutMusic: json['promoWithoutMusicId'] == null
          ? Video(id: -1, duration: 0, url: "Error")
          : Video.fromJson(json['promoWithoutMusicId']),
    );
  }
}
