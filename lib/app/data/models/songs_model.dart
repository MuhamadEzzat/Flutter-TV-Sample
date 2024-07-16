import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'episode_model.dart';
import 'video_model.dart';

class Songs {
  List<SongCategory>? songsCategories;
  String? error;
  bool loading = false;

  Songs({
    this.songsCategories,
    this.error,
  });

  Songs.withError(String errorValue)
      : songsCategories = [],
        error = errorValue;

  Songs.loading() : loading = true;

  factory Songs.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    List<SongCategory> songsList = list
        .map((i) => SongCategory.fromJson(i))
        .toList()
        .where((songCategory) => songCategory.status == 'DEFAULT')
        .toList();
    return Songs(songsCategories: songsList);
  }
}

class SongCategory {
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

  SongCategory({
    this.id = -1,
    this.name = "",
    this.description,
    this.image = "",
    this.status = "",
    this.createdDate = "",
    this.publishDate = "",
    this.lastModifiedDate = "",
    this.voiceUrl,
    this.episodes,
    this.introWithMusicId,
    this.introWithoutMusicId,
    this.promoWithMusicId,
    this.promoWithoutMusicId,
  });

  factory SongCategory.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['songs'] as List?;
    List<Episode> episodesList =
        list != null ? list.map((i) => Episode.fromSongJson(i)).toList() : [];

    bool isAr = Get.locale?.languageCode == "ar";

    return SongCategory(
        id: parsedJson['id'] ?? -1,
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
