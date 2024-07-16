
import '../enums/content_type.dart';

class SliderSection {
  final String name;
  final String nameInEnglish;
  final String selectedImage;
  final String voiceName;
  final String webIcon;

  final ContentType contentType;

  const SliderSection(
      {this.name = "",
      this.nameInEnglish = "",
      this.selectedImage = "",
      this.voiceName = "",
      this.webIcon = "",
      required this.contentType});

  factory SliderSection.fromJson(Map<String, dynamic> parsedJson) {
    return SliderSection(
        name: parsedJson['name'] ?? "",
        nameInEnglish: parsedJson['nameInEnglish'] ?? "",
        voiceName: parsedJson['voiceName'] ?? "",
        selectedImage: parsedJson['selectedImage'],
        contentType: parsedJson['contentType']);
  }
}

class AllSectionsData {
  List<SectionsData>? sectionsData;

  AllSectionsData({this.sectionsData});

  AllSectionsData.fromJson(List<dynamic> json) {
    sectionsData = <SectionsData>[];
    json.forEach((v) {
      sectionsData!.add(SectionsData.fromJson(v));
    });
  }
}

class SectionsData {
  DynamicSection dynamicSection;
  List<Section> data;

  SectionsData({
    required this.dynamicSection,
    required this.data,
  });

  factory SectionsData.fromJson(Map<String, dynamic> json) => SectionsData(
        dynamicSection: DynamicSection.fromJson(json["dynamicSection"]),
        data: List<Section>.from(json["data"].map((x) => Section.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dynamicSection": dynamicSection.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Section {
  int id;
  String? nameInArabic;
  String? nameInEnglish;
  String? image;
  String? videoWithMusicId;
  String? videoWithoutMusicId;
  String? audioWithMusicUrl;
  String? audioWithoutMusicUrl;
  String? videoType;
  bool? isFree;
  Section(
      {required this.id,
      this.nameInArabic,
      this.nameInEnglish,
      this.image,
      this.videoWithMusicId,
      this.videoWithoutMusicId,
      this.audioWithMusicUrl,
      this.audioWithoutMusicUrl,
      this.videoType,
      this.isFree});

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        nameInArabic: json["nameInArabic"],
        nameInEnglish: json["nameInEnglish"],
        image: json["image"],
        videoWithMusicId: json["videoWithMusicId"],
        videoWithoutMusicId: json["videoWithoutMusicId"],
        audioWithMusicUrl: json["audioWithMusicUrl"],
        audioWithoutMusicUrl: json["audioWithoutMusicUrl"],
        videoType: json['videoType'],
        isFree: json['isFree'] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameInArabic": nameInArabic,
        "nameInEnglish": nameInEnglish,
        "image": image,
        "videoWithMusicId": videoWithMusicId,
        "videoWithoutMusicId": videoWithoutMusicId,
        "audioWithMusicUrl": audioWithMusicUrl,
        "audioWithoutMusicUrl": audioWithoutMusicUrl,
      };
}

class DynamicSection {
  int id;
  String? titleAr, titleEn;
  String? type;
  String? category;
  bool? active;

  DynamicSection({
    required this.id,
    this.titleAr,
    this.titleEn,
    this.type,
    this.category,
    this.active,
  });

  factory DynamicSection.fromJson(Map<String, dynamic> json) => DynamicSection(
        id: json["id"],
        titleAr: json["title"],
        titleEn: json["titleInEnglish"],
        type: json["type"],
        category: json["category"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "category": category,
        "active": active,
      };
}
