import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'channel_model.dart';
import 'video_model.dart';

class Radios {
  List<RadioModel>? radiosCategories;
  String? error;
  bool loading = false;

  Radios({
    this.radiosCategories,
    this.error,
  });

  Radios.withError(String errorValue)
      : radiosCategories = [],
        error = errorValue;

  Radios.loading() : loading = true;

  factory Radios.fromJson(Map<String, dynamic> parsedJson) {
    debugPrint("RadioModelll Json $parsedJson");
    var list = parsedJson['results'] as List;
    List<RadioModel> storiesList = list
        .map((i) => RadioModel.fromJson(i))
        .toList()
        .where((storyCategory) => storyCategory.status == 'DEFAULT')
        .toList();
    return Radios(radiosCategories: storiesList);
  }
}

class RadioModel {
  final int? id;
  final String? name, description, image, status;
  final String? voice;
  final DateTime? creationDate, publishDate, lastModifiedDate;
  final List<Channel>? channels;
  final Video? promoWithMusic,
      promoWithoutMusic,
      introWithMusic,
      introWithoutMusic;

  RadioModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.status,
    this.creationDate,
    this.publishDate,
    this.lastModifiedDate,
    this.voice,
    this.channels,
    this.promoWithMusic,
    this.promoWithoutMusic,
    this.introWithMusic,
    this.introWithoutMusic,
  });

  factory RadioModel.fromJson(Map<String, dynamic> json) {
    debugPrint("RadioModelll Json $json");
    bool isAr = Get.locale?.languageCode == "ar";
    final _channels = json['channels'] as List<dynamic>?;
    return RadioModel(
      id: json['id'],
      name: isAr ? json['name'] : json['nameInEnglish'] ?? "",
      description:
          isAr ? json['description'] : json['descriptionInEnglish'] ?? "",
      image: json['image'],
      status: json['status'],
      creationDate: DateTime.tryParse(json['createdDate']),
      publishDate: DateTime.tryParse(json['publishDate']),
      lastModifiedDate: DateTime.tryParse(json['lastModifiedDate']),
      voice: json['voice'],
      channels: (_channels ?? [])
          .map((channel) => Channel.fromJson(channel))
          .toList()
          .skipWhile((channel) => channel.status == 'SUSPENDED')
          .toList(),
      promoWithMusic: json['promoWithMusicId'] == null
          ? Video(id: -1, duration: 0, url: "Error")
          : Video.fromJson(json['promoWithMusicId']),
      promoWithoutMusic: json['promoWithoutMusicId'] == null
          ? Video(id: -1, duration: 0, url: "Error")
          : Video.fromJson(json['promoWithoutMusicId']),
      introWithMusic: json['introWithMusicId'] == null
          ? Video(id: -1, duration: 0, url: "Error")
          : Video.fromJson(json['introWithMusicId']),
      introWithoutMusic: json['introWithoutMusicId'] == null
          ? Video(id: -1, duration: 0, url: "Error")
          : Video.fromJson(json['introWithoutMusicId']),
    );
  }
}
