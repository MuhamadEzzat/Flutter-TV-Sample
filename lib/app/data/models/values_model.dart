import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../enums/content_type.dart';
import 'episode_model.dart';

class MainValues {
  List<MainValue>? mainValues;
  String? error;

  bool loading = false;

  MainValues.fromJson(List? json) {
    // ignore: prefer_null_aware_operators
    mainValues = (json) != null
        ? (json).map((i) => MainValue.fromJson(i)).toList()
        : null;
  }

  MainValues.withError(String error) {
    error = error;
  }

  MainValues.loading() {
    loading = true;
  }
}

class MainValue extends ContentValue {
//  String contentValue;
//  String imageUrl;
  String? description;

//  int id;
//  int number;
  List<ContentValue> subValues;

  MainValue({
    contentValue,
    imageUrl,
    this.description,
    id,
    number,
    this.subValues = const [],
  }) : super(
          contentType: ContentType.subValue,
          id: id,
          contentValue: contentValue,
          imageUrl: imageUrl,
          number: number,
        );

  factory MainValue.fromJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    return MainValue(
      contentValue: isAr
          ? json['contentValue']
          : json['contentValueInEnglish'] ?? json['contentValue'],
      imageUrl: json['imageUrl'],
      description: isAr
          ? json['description']
          : json['descriptionInEnglish'] ?? json['description'],
      id: json['id'],
      number: json['number'],
      subValues: ((json['subValues'] as List<dynamic>?) ?? [])
          .map((i) => ContentValue.fromSubValueJson(i))
          .toList(),
    );
  }
}

class ContentValue {
  String? contentValue;
  String? imageUrl;
  int? id;
  int? number;
  ContentType? contentType;
  Episodes? episodes;
  bool? allPaid;

  ContentValue({
    this.contentValue,
    this.imageUrl,
    this.id,
    this.number,
    this.contentType,
    this.episodes,
    this.allPaid,
  });

  ContentValue.fromSubValueJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    contentType = ContentType.subValue;
    contentValue = isAr
        ? json['contentValue']
        : json['contentValueInEnglish'] ?? json['contentValue'];
    imageUrl = json['imageUrl'];
    id = json['id'];
    number = json['number'];
  }
}
