import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/Constants/constants.dart';
import '../enums/content_type.dart';
import 'activities_model.dart';
import 'channel_model.dart';
import 'subvalue_model.dart';
import 'video_model.dart';

class Episodes {
  List<Episode>? episodes;
  String? error;

  bool loading = false;

  Episodes({
    this.episodes,
    this.error,
  });

  Episodes.withError(String errorValue)
      : episodes = [],
        error = errorValue;

  Episodes.loading() : loading = true;

  factory Episodes.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    debugPrint(list.runtimeType.toString());
    List<Episode> episodesList = list.map((i) => Episode.fromJson(i)).toList();
    return Episodes(episodes: episodesList);
  }

  factory Episodes.fromSongsJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['result'] as List;
    debugPrint(list.runtimeType.toString());
    List<Episode> episodesList =
        list.map((i) => Episode.fromSongJson(i)).toList();
    return Episodes(episodes: episodesList);
  }

  factory Episodes.fromStoriesJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    debugPrint(list.runtimeType.toString());
    List<Episode> episodesList =
        list.map((i) => Episode.fromStoryJson(i)).toList();
    return Episodes(episodes: episodesList);
  }
}

class Episode {
  final int id;
  final String name;
  final String status;
  final String? description;
  final int? episodeNumber;
  final Video? videoWithMusic;
  final Video? videoWithoutMusic;
  final String? voiceUrl;
  final String? image;
  final String createdDate;
  final String publishDate;
  final String lastModifiedDate;
  final Activity? activity;
  final bool? isFree;
  final SubValue? subValue;
  final ContentType? contentType;
  final bool hasPuzzleGame, hasPaintingGame, hasQuestions, hasDragDropGame;

  Episode({
    this.id = -1,
    this.name = "",
    this.status = "",
    this.description = "",
    this.episodeNumber = -1,
    this.videoWithMusic,
    this.videoWithoutMusic,
    this.image = "",
    this.createdDate = "",
    this.publishDate = "",
    this.lastModifiedDate = "",
    this.isFree,
    this.voiceUrl,
    this.activity,
    this.subValue,
    this.contentType,
    required this.hasQuestions,
    required this.hasPuzzleGame,
    required this.hasPaintingGame,
    required this.hasDragDropGame,
  });

  factory Episode.fromJson(Map<String, dynamic> parsedJson) {
    bool isAr = Get.locale?.languageCode == "ar";

    Activity? activity = parsedJson['activityId'] != null
        ? Activity.fromJson(parsedJson['activityId'])
        : null;

    return Episode(
      contentType: ContentType.episode,
      id: parsedJson['id'],
      name: isAr ? parsedJson['name'] : parsedJson['nameInEnglish'] ?? "",
      image: parsedJson['image'],
      videoWithMusic: parsedJson['videoWithMusicId'] != null
          ? Video.fromJson(parsedJson['videoWithMusicId'])
          : Video(id: -1, duration: 0, url: "Error"),
      videoWithoutMusic: parsedJson['videoWithoutMusicId'] != null
          ? Video.fromJson(parsedJson['videoWithoutMusicId'])
          : Video(id: -1, duration: 0, url: "Error"),
      subValue: SubValue.fromJson(parsedJson['contentSubValue']),
      status: parsedJson['status'],
      description: isAr
          ? parsedJson['description']
          : parsedJson['descriptionInEnglish'] ?? "",
      episodeNumber: parsedJson['episodeNumber'],
      createdDate: parsedJson['createdDate'],
      publishDate: parsedJson['publishDate'],
      voiceUrl: parsedJson['voice'],
      isFree: parsedJson['isFree'] != null && parsedJson['isFree'] == 1
          ? true
          : false,
      lastModifiedDate: parsedJson['lastModifiedDate'],
      activity: activity,
      hasQuestions: parsedJson['activityId'] != null &&
          parsedJson['activityId']['questions'].isNotEmpty,
      hasPaintingGame: parsedJson['paintingGames'] != null &&
          parsedJson['paintingGames'].isNotEmpty,
      hasPuzzleGame:
          parsedJson['puzzles'] != null && parsedJson['puzzles'].isNotEmpty,
      hasDragDropGame:
          parsedJson['dragDrops'] != null && parsedJson['dragDrops'].isNotEmpty,
    );
  }

  factory Episode.fromSongJson(Map<String, dynamic> parsedJson) {
    Activity? activity = parsedJson['activityId'] != null
        ? Activity.fromJson(parsedJson['activityId'])
        : null;

    bool isAr = Get.locale?.languageCode == "ar";

    return Episode(
      contentType: ContentType.song,
      id: parsedJson['id'],
      status: parsedJson['status'],
      name: isAr ? parsedJson['name'] : parsedJson['nameInEnglish'] ?? "",
      image: parsedJson['image'],
      videoWithMusic: parsedJson['videoWithMusicId'] == null
          ? null
          : Video.fromJson(parsedJson['videoWithMusicId']),
      videoWithoutMusic: parsedJson['videoWithoutMusicId'] == null
          ? null
          : Video.fromJson(parsedJson['videoWithoutMusicId']),
      subValue: SubValue.fromJson(parsedJson['contentSubValue']),
      createdDate: parsedJson['createdDate'],
      publishDate: parsedJson['publishDate'],
      lastModifiedDate: parsedJson['lastModifiedDate'],
      voiceUrl: parsedJson['voice'],
      isFree: parsedJson['isFree'] != null && parsedJson['isFree'] == 1
          ? true
          : false,
      activity: activity,
      description: isAr
          ? parsedJson['description']
          : parsedJson['descriptionInEnglish'] ?? "",
      episodeNumber: parsedJson['episodeNumber'],
      hasQuestions: parsedJson['activityId'] != null &&
          parsedJson['activityId']['questions'].isNotEmpty,
      hasPaintingGame: parsedJson['paintingGames'] != null &&
          parsedJson['paintingGames'].isNotEmpty,
      hasPuzzleGame:
          parsedJson['puzzles'] != null && parsedJson['puzzles'].isNotEmpty,
      hasDragDropGame:
          parsedJson['dragDrops'] != null && parsedJson['dragDrops'].isNotEmpty,
    );
  }

  factory Episode.fromStoryJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";

    return Episode(
      contentType: ContentType.story,
      id: json['id'],
      status: json['status'],
      name: isAr ? json['name'] : json['nameInEnglish'] ?? "",
      image: json['iconImage'] == null ? "" : json["iconImage"],
      videoWithMusic: Video.fromJson(json['videoWithMusicId']),
      videoWithoutMusic: Video.fromJson(json['videoWithoutMusicId']),
      subValue: SubValue.fromJson(json['contentSubValue']),
      createdDate: json['createdDate'],
      publishDate: json['publishDate'],
      voiceUrl: json['voice'],
      lastModifiedDate: json['lastModifiedDate'],
      isFree: json['isFree'] != null && json['isFree'] == 1 ? true : false,
      activity: json['activityId'] != null
          ? Activity.fromJson(json['activityId'])
          : null,
      description:
          isAr ? json['description'] : json['descriptionInEnglish'] ?? "",
      episodeNumber: json['episodeNumber'],
      hasQuestions: json['activityId'] != null &&
          json['activityId']['questions'].isNotEmpty,
      hasPaintingGame: json['storyPaintingGames'] != null &&
          json['storyPaintingGames'].isNotEmpty,
      hasPuzzleGame:
          json['storyPuzzle'] != null && json['storyPuzzle'].isNotEmpty,
      hasDragDropGame:
          json['storyDragDrop'] != null && json['storyDragDrop'].isNotEmpty,
    );
  }

  factory Episode.fromSChannel(Channel channel) {
    return Episode(
      contentType: ContentType.story,
      id: channel.id ?? -1,
      status: channel.status ?? '',
      name: channel.name ?? '',
      image: channel.image ?? '',
      videoWithMusic: Video(
          url: channel.trackWithMusic, cloudFrontUrl: channel.uploadedFile),
      videoWithoutMusic: Video(
          url: channel.trackWithoutMusic, cloudFrontUrl: channel.articleUrl),
      subValue: channel.subValue,
      createdDate: channel.creationDate?.toIso8601String() ?? '',
      publishDate: channel.publishDate?.toIso8601String() ?? '',
      voiceUrl: channel.voice,
      lastModifiedDate: channel.lastModifiedDate?.toIso8601String() ?? '',
      isFree: channel.isFree,
      activity: channel.activity,
      description: channel.description,
      episodeNumber: AppConstants.kChannelAsEpisodeId,
      hasQuestions: false,
      hasPaintingGame: false,
      hasPuzzleGame: false,
      hasDragDropGame: false,
    );
  }
}
/*
"id": 1,
"status": "SUSPENDED",
"name": "episode1",
"description": "firstEpisode",
"episodeNumber": 1,
"videoURL": "http://192.168.1.39:8080/C:UsersMy Lapeclipse-workspace\new_gene_backend_testsrcmain\resourcesimgsepisode BG v1.jpg",
"image": "http://192.168.1.39:8080/C:UsersMy Lapeclipse-workspace\new_gene_backend_testsrcmain\resourcesimgsepisode BG v1.jpg",
"createdDate": "26-2-2019",
"publishDate": "26-2-2019",
"lastModifiedDate": "26-2-2019"
 */
