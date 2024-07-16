import 'package:flutter/cupertino.dart';

class ChildBanners {
  final List<ChildBanner>? banners;
  final String? error;

  ChildBanners({
    this.banners,
    this.error,
  });

  ChildBanners.withError(String errorValue)
      : banners = [],
        error = errorValue;

  factory ChildBanners.fromJson(List<dynamic> parsedJson) {
    var list = parsedJson;
    debugPrint(list.runtimeType.toString());
    List<ChildBanner> blogsList =
        list.map((i) => ChildBanner.fromJson(i)).toList();
    return ChildBanners(banners: blogsList);
  }
}

class ChildBanner {
  final int id;
  final String title;
  final String? titleInEnglish;
  final String? link;
  final String image;
  final String? description;
  final String? status;

  ChildBanner({
    this.id = -1,
    this.title = "",
    this.titleInEnglish = "",
    this.link = "",
    this.image = "",
    this.description = "male",
    this.status = "",
  });
  ChildBanner.withError(String errorValue)
      : id = -1,
        title = "",
        titleInEnglish = "",
        link = "",
        image = "",
        description = "",
        status = "";

  factory ChildBanner.fromJson(Map<String, dynamic> json) {
    return ChildBanner(
        id: json['id'],
        title: json['title'],
        titleInEnglish: json['titleInEnglish'],
        link: json['link'],
        image: json['image'],
        description: json['description'],
        status: json['status']);
  }
}
