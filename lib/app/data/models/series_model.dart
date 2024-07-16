import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'episode_model.dart';
import 'video_model.dart';

class Series {
  List<Serial>? series;
  String? error;
  bool loading = false;

  Series({
    this.series,
    this.error,
  });

  Series.withError(String errorValue)
      : series = [],
        error = errorValue;

  Series.loading() : loading = true;

  factory Series.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    List<Serial> serialsList = list.map((i) => Serial.fromJson(i)).toList();
    return Series(series: serialsList);
  }
}

class Serial {
  final int id;
  final String name;
  final String image;
  final String status;
  final String createdDate;
  final String publishDate;
  final String lastModifiedDate;
  final String? description;
  final Video? promoWithMusicId;
  final Video? promoWithoutMusicId;
  final Video? introWithMusicId;
  final Video? introWithoutMusicId;
  final String? voiceUrl;
  final List<Episode>? episodes;
  bool? isSerial = true;

  Serial({
    this.id = -1,
    this.name = "",
    this.image = "",
    this.status = "",
    this.createdDate = "",
    this.publishDate = "",
    this.lastModifiedDate = "",
    this.voiceUrl,
    this.episodes,
    this.description,
    this.introWithMusicId,
    this.introWithoutMusicId,
    this.promoWithMusicId,
    this.promoWithoutMusicId,
    this.isSerial,
  });

  factory Serial.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['episodes'] as List?;
    List<Episode> episodesList =
        list != null ? list.map((i) => Episode.fromJson(i)).toList() : [];

    bool isAr = Get.locale?.languageCode == "ar";

    return Serial(
        id: parsedJson['id'],
        name: isAr ? parsedJson['name'] : parsedJson['nameInEnglish'] ?? "",
        image: parsedJson['image'],
        status: parsedJson['status'],
        createdDate: parsedJson['createdDate'],
        publishDate: parsedJson['publishDate'],
        description: isAr
            ? parsedJson['description']
            : parsedJson['descriptionInEnglish'] ?? "",
        lastModifiedDate: parsedJson['lastModifiedDate'],
        promoWithMusicId: parsedJson['promoWithMusicId'] != null
            ? Video.fromJson(parsedJson['promoWithMusicId'])
            : Video(id: -1, duration: 0, url: "Error"),
        promoWithoutMusicId: parsedJson['promoWithoutMusicId'] != null
            ? Video.fromJson(parsedJson['promoWithoutMusicId'])
            : Video(id: -1, duration: 0, url: "Error"),
        introWithMusicId: parsedJson['introWithMusicId'] != null
            ? Video.fromJson(parsedJson['introWithMusicId'])
            : Video(id: -1, duration: 0, url: "Error"),
        introWithoutMusicId: parsedJson['introWithoutMusicId'] != null
            ? Video.fromJson(parsedJson['introWithoutMusicId'])
            : Video(id: -1, duration: 0, url: "Error"),
        voiceUrl: parsedJson['voice'] != null && parsedJson['voice'] != "null"
            ? parsedJson['voice']
            : null,
        episodes: episodesList);
  }
}
