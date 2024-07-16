import 'package:multimedia_tv_sample/app/data/models/sections_model.dart';

class DynamicSectionContent {
  SectionsData? dynamicSectionDataDto;
  int totalPages;
  int totalElements;

  DynamicSectionContent({
    this.dynamicSectionDataDto,
    required this.totalPages,
    required this.totalElements,
  });

  factory DynamicSectionContent.fromJson(Map<String, dynamic> json) =>
      DynamicSectionContent(
        dynamicSectionDataDto: json["dynamicSectionDataDTO"] == null
            ? null
            : SectionsData.fromJson(json["dynamicSectionDataDTO"]),
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
      );
}
