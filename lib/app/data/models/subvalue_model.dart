import 'package:get/get.dart';

class SubValue {
  int id;
  String contentValue;
  String imageUrl;
  int number;

  SubValue({
    this.id = -1,
    this.imageUrl = "",
    this.contentValue = "",
    this.number = 0,
  });

  static fromJson(Map<String, dynamic>? json) {
    bool isAr = Get.locale?.languageCode == "ar";
    if (json == null) return SubValue();
    return SubValue(
      id: json['id'],
      contentValue: isAr
          ? json['contentValue']
          : json['contentValueInEnglish'] ?? json['contentValue'],
      number: json['number'],
      imageUrl: json["imageUrl"],
    );
  }
}
