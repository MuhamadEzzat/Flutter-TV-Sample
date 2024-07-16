import 'package:get/get.dart';
import 'package:multimedia_tv_sample/app/data/models/video_model.dart';

class BooksCategoryModel {
  final int? id;
  final String? name, description, image, status;
  final String? voice;
  final DateTime? creationDate, publishDate, lastModifiedDate;
  final Video? promoWithMusic, promoWithoutMusic;

  BooksCategoryModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.status,
    this.creationDate,
    this.publishDate,
    this.lastModifiedDate,
    this.voice,
    this.promoWithMusic,
    this.promoWithoutMusic,
  });

  factory BooksCategoryModel.fromJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    return BooksCategoryModel(
      id: json['id'],
      name: isAr ? json['name'] : json['nameInEnglish'] ?? "",
      description:
          isAr ? json['description'] : json['descriptionInEnglish'] ?? "",
      image: json['image'],
      status: json['status'],
      creationDate: DateTime.tryParse(json['createdDate']),
      publishDate: DateTime.tryParse(json['publishDate']),
      lastModifiedDate: DateTime.tryParse(json['lastModifiedDate'] ?? ''),
      voice: json['voice'],
      promoWithMusic: json['promoWithMusicId'] == null
          ? Video(id: -1, duration: 0, url: "Error")
          : Video.fromJson(json['promoWithMusicId']),
      promoWithoutMusic: json['promoWithoutMusicId'] == null
          ? Video(id: -1, duration: 0, url: "Error")
          : Video.fromJson(json['promoWithoutMusicId']),
    );
  }
}
