import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'episode_model.dart';
import 'video_model.dart';

class Stories {
  List<StoriesCategory>? storiesCategories;
  String? error;
  bool loading = false;

  Stories({
    this.storiesCategories,
    this.error,
  });

  Stories.withError(String errorValue)
      : storiesCategories = [],
        error = errorValue;

  Stories.loading() : loading = true;

  factory Stories.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    List<StoriesCategory> storiesList = list
        .map((i) => StoriesCategory.fromJson(i))
        .toList()
        .where((storyCategory) => storyCategory.status == 'DEFAULT')
        .toList();
    return Stories(storiesCategories: storiesList);
  }
}

class StoriesCategory {
  final int id;
  final String name;
  final String? image;
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

  StoriesCategory({
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

  factory StoriesCategory.fromJson(Map<String, dynamic> parsedJson) {
    List? list = parsedJson['storys'] as List?;
    List<Episode>? episodesList =
        // ignore: prefer_null_aware_operators
        list != null
            ? list.map((i) => Episode.fromStoryJson(i)).toList()
            : null;
    bool isAr = Get.locale?.languageCode == "ar";

    return StoriesCategory(
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
