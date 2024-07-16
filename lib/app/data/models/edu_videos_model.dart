import 'package:flutter/material.dart';

class EduVideos {
  final List<EduVideo>? eduVideos;
  // final String? error;

  EduVideos({
    this.eduVideos,
    // this.error,
  });

  EduVideos.withError(String errorValue) : eduVideos = [];
  // error = errorValue;

  factory EduVideos.fromJson(List<dynamic> parsedJson) {
    var list = parsedJson;
    debugPrint(list.runtimeType.toString());
    List<EduVideo> eduVideosList =
        list.map((i) => EduVideo.fromJson(i)).toList();
    return EduVideos(eduVideos: eduVideosList);
  }
}

class EduVideo {
  int? id;
  String? itemName;
  String? itemNameInEnglish;
  String? itemStatus;
  String? itemDescription;
  String? itemDescriptionInEnglish;
  String? itemImage;
  String? itemUrl;
  String? itemType;

  EduVideo({
    this.id,
    this.itemName,
    this.itemNameInEnglish,
    this.itemStatus,
    this.itemDescription,
    this.itemDescriptionInEnglish,
    this.itemImage,
    this.itemUrl,
    this.itemType,
  });

  EduVideo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['itemName'];
    itemNameInEnglish = json['itemNameInEnglish'];
    itemStatus = json['itemStatus'];
    itemDescription = json['itemDescription'];
    itemDescriptionInEnglish = json['itemDescriptionInEnglish'];
    itemImage = json['itemImage'];
    itemUrl = json['itemUrl'];
    itemType = json['itemType'];
  }
}
