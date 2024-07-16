import 'package:get/get.dart';

class GameReport {
  LastGamePlayed? lasGamePlayed;
  MostGamePlayed? mostGamePlayed;
  List<GamesReport>? gamesReport;
  String? error;
  bool loading = false;

  GameReport({
    this.lasGamePlayed,
    this.mostGamePlayed,
    this.gamesReport,
    this.error,
  });

  GameReport.fromJson(Map<String, dynamic> json) {
    lasGamePlayed = json['lastWatchedGame'] != null
        ? LastGamePlayed.fromJson(json['lastWatchedGame'])
        : null;
    mostGamePlayed = json['mostWatchedGame'] != null
        ? MostGamePlayed.fromJson(json['mostWatchedGame'])
        : null;
    if (json['gameDataReports'] != null) {
      gamesReport = <GamesReport>[];
      json['gameDataReports'].forEach((v) {
        gamesReport?.add(GamesReport.fromJson(v));
      });
    }
  }

  GameReport.loading() : loading = true;

  GameReport.withError(String errorValue)
      : mostGamePlayed = null,
        lasGamePlayed = null,
        gamesReport = null,
        error = errorValue;
}

class LastGamePlayed {
  int? id;
  String? name;
  String? image;

  LastGamePlayed({
    this.id,
    this.name,
    this.image,
  });

  LastGamePlayed.fromJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    id = json['id'];
    name = isAr ? json['name'] : json['nameInEnglish'] ?? json['name'];
    image = json['image'] == null ? image = "" : image = json["image"];
  }
}

class MostGamePlayed {
  int? id;
  String? name;
  String? image;

  MostGamePlayed({
    this.id,
    this.name,
    this.image,
  });

  MostGamePlayed.fromJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    id = json['id'];
    name = isAr ? json['name'] : json['nameEnglish'];
    image = json['image'] == null ? image = "" : image = json["image"];
  }
}

class GamesReport {
  int? id, numberOfWatching, duration;
  String? name, image, key;
  DateTime? lastWatchingDate;

  GamesReport({
    this.numberOfWatching,
    this.duration,
    this.id,
    this.image,
    this.name,
    this.key,
    this.lastWatchingDate,
  });

  factory GamesReport.fromJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    return GamesReport(
      numberOfWatching: json['number_of_watching'],
      duration: json['duration'],
      id: json['gameDataId'],
      image: json['gameDataImage'] ?? "",
      name: json['gameDataName'] == null
          ? ""
          : isAr
              ? json['gameDataName']
              : json['gameDataNameInEnglish'] ?? json['gameDataName'],
      key: json['gameDataKey'] ?? "",
      lastWatchingDate: json['lastWatchingDate'] == null
          ? DateTime.now()
          : DateTime.parse(json['lastWatchingDate']),
    );
  }
}
