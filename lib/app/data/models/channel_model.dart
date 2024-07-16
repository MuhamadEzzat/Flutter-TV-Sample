import 'package:get/get.dart';

import 'episode_model.dart';
import 'subvalue_model.dart';

import 'activities_model.dart';

class Channel {
  final int? id;
  final String? name,
      description,
      image,
      status,
      trackWithMusic,
      trackWithoutMusic,
      creatorUid,
      modifierUid,
      voice,
      uploadedFile,
      articleUrl;
  final DateTime? creationDate, publishDate, lastModifiedDate;
  final Activity? activity;
  final bool isFree;
  final SubValue? subValue;

  Channel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.status,
    this.trackWithMusic,
    this.trackWithoutMusic,
    this.creatorUid,
    this.modifierUid,
    this.voice,
    this.uploadedFile,
    this.articleUrl,
    this.creationDate,
    this.publishDate,
    this.lastModifiedDate,
    this.activity,
    this.isFree = false,
    this.subValue,
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";

    return Channel(
        id: json['id'],
        name: isAr ? json['name'] : json['nameInEnglish'] ?? "",
        description: json['description'],
        image: json['image'],
        status: json['status'],
        trackWithMusic: json['trackWithMusic'],
        trackWithoutMusic: json['trackWithoutMusic'],
        creatorUid: json['createdByUid']['uid'],
        modifierUid:
            json['modifiedByUid'] == null ? null : json['modifiedByUid']['uid'],
        voice: json['voice'],
        uploadedFile: json['uploadedFile'],
        articleUrl: json['articleUrl'],
        creationDate: DateTime.tryParse(json['createdDate']),
        publishDate: DateTime.tryParse(json['publishDate']),
        lastModifiedDate: DateTime.tryParse(json['lastModifiedDate']),
        activity: json['activityId'] == null
            ? null
            : Activity.fromJson(json['activityId']),
        isFree: json['isFree'] == 1,
        subValue: SubValue.fromJson(json['contentSubValue']));
  }

  factory Channel.fromEpisode(Episode episode) {
    return Channel(
        id: episode.id,
        name: episode.name,
        description: episode.description,
        image: episode.image,
        status: episode.status,
        trackWithMusic: episode.videoWithMusic?.url,
        trackWithoutMusic: episode.videoWithoutMusic?.url,
        creatorUid: '',
        modifierUid: '',
        voice: episode.voiceUrl,
        uploadedFile: episode.videoWithMusic?.cloudFrontUrl,
        articleUrl: episode.videoWithoutMusic?.cloudFrontUrl,
        creationDate: DateTime.tryParse(episode.createdDate),
        publishDate: DateTime.tryParse(episode.publishDate),
        lastModifiedDate: DateTime.tryParse(episode.lastModifiedDate),
        activity: episode.activity,
        isFree: episode.isFree ?? false,
        subValue: episode.subValue);
  }
}
