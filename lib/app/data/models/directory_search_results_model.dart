import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/utils/songs_anasheed_util.dart';
import '../enums/content_type.dart';

class DirectorySearchResult {
  List<DirectoryContent>? contentMainValues;
  List<DirectoryContent>? contentSubValue;
  List<DirectoryContent>? discoverWithUs;
  List<DirectoryContent>? episodes;
  List<DirectoryContent>? series;
  List<DirectoryContent>? songs;
  List<DirectoryContent>? stories;
  bool loading = false;
  String? error;

  DirectorySearchResult({
    this.contentMainValues,
    this.contentSubValue,
    this.discoverWithUs,
    this.episodes,
    this.series,
    this.songs,
    this.stories,
  });

  DirectorySearchResult.fromJson(Map<String, dynamic> json) {
    contentMainValues = (json['contentMainValues'] as List?) != null
        ? (json['contentMainValues'] as List)
            .map((i) => DirectoryContent.fromJson(
                i, ContentType.mainValue, "قيمة رئيسية"))
            .toList()
        : null;
    contentSubValue = (json['contentSubValue'] as List?) != null
        ? (json['contentSubValue'] as List)
            .map((i) => DirectoryContent.fromJson(
                i, ContentType.subValue, "قيمة فرعية"))
            .toList()
        : null;
    discoverWithUs = (json['discoverWithUs'] as List?) != null
        ? (json['discoverWithUs'] as List)
            .map((i) => DirectoryContent.fromJson(
                i, ContentType.discoverSerial, "مسلسل"))
            .toList()
        : null;
    episodes = (json['episodes'] as List?) != null
        ? (json['episodes'] as List)
            .map((i) =>
                DirectoryContent.fromJson(i, ContentType.episode, "حلقة"))
            .toList()
        : null;
    series = (json['series'] as List?) != null
        ? (json['series'] as List)
            .map((i) =>
                DirectoryContent.fromJson(i, ContentType.normalSerial, "مسلسل"))
            .toList()
        : null;
    songs = (json['songs'] as List?) != null
        ? (json['songs'] as List)
            .map((i) => DirectoryContent.fromJson(i, ContentType.song,
                SongsOrAnasheedUtil.convertSongsToAnasheed("أغنية")))
            .toList()
        : null;
    stories = (json['stories'] as List?) != null
        ? (json['stories'] as List)
            .map(
                (i) => DirectoryContent.fromJson(i, ContentType.story, "حكاية"))
            .toList()
        : null;
  }

  DirectorySearchResult.withError(String error) {
    error = error;
  }

  DirectorySearchResult.loading() {
    loading = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['contentMainValues'] =
        contentMainValues?.map((i) => i.toJson()).toList();
    data['contentSubValue'] = contentSubValue?.map((i) => i.toJson()).toList();
    data['discoverWithUs'] = discoverWithUs?.map((i) => i.toJson()).toList();
    data['episodes'] = episodes?.map((i) => i.toJson()).toList();
    data['series'] = series?.map((i) => i.toJson()).toList();
    data['songs'] = songs?.map((i) => i.toJson()).toList();
    data['stories'] = stories?.map((i) => i.toJson()).toList();
    return data;
  }

  List<DirectoryContent> toAllContentList() {
    return [
      ...(contentMainValues ?? []),
      ...(contentSubValue ?? []),
      ...(series ?? []),
      ...(songs ?? []),
      ...(discoverWithUs ?? []),
      ...(stories ?? []),
      ...(episodes ?? []),
    ];
  }
}

//enum DirectoryContentType {MAIN_VALUE,SUB_VALUE,EPISODE,SERIES}
class DirectoryContent {
  String? name;
  int? id;
  ContentType? contentType;

  DirectoryContent({this.name, this.id, this.contentType});

  DirectoryContent.fromJson(
      Map<String, dynamic> json, ContentType type, String preName) {
    bool isAr = Get.locale?.languageCode == "ar";

    debugPrint("DirectoryContent json $json");

    name = "$preName: " + json['name'];
    // isAr
    //     ? "$preName: " + json['name']
    //     : "$preName: " + json['nameInEnglish'];
    id = json['id'];
    contentType = type;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
