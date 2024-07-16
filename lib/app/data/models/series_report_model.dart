import 'package:get/get.dart';

import 'episode_model.dart';
import 'episodes_report_model.dart';
import 'questions_model.dart';

class SeriesReport {
  LastWatchedSeries? lastWatchedSeries;
  MostWatchedSeries? mostWatchedSeries;
  List<SerialReport>? seriesReports;
  String? error;

  //bool loading = false;

  SeriesReport({
    this.lastWatchedSeries,
    this.mostWatchedSeries,
    this.seriesReports,
    this.error,
  });

  SeriesReport.fromJson(Map<String, dynamic> json) {
    lastWatchedSeries = json['lastWatchedSeries'] != null
        ? LastWatchedSeries.fromJson(json['lastWatchedSeries'])
        : null;
    mostWatchedSeries = json['mostWatchedSeries'] != null
        ? MostWatchedSeries.fromJson(json['mostWatchedSeries'])
        : null;
    if (json['seriesReports'] != null) {
      seriesReports = <SerialReport>[];
      json['seriesReports'].forEach((v) {
        seriesReports?.add(SerialReport.fromJson(v));
      });
    }
  }

  // SeriesReport.loading() : loading = true;

  SeriesReport.withError(String errorValue)
      : mostWatchedSeries = null,
        lastWatchedSeries = null,
        seriesReports = null,
        error = errorValue;
}

class LastWatchedSeries {
  int? id;
  String? name;
  String? image;

  // String? status;
  // String? createdDate;
  // String? publishDate;
  // String? lastModifiedDate;
  // List<Episode>? episodes;

  LastWatchedSeries({
    this.id,
    this.name,
    this.image,
    // this.status,
    // this.createdDate,
    // this.publishDate,
    // this.lastModifiedDate,
    // this.episodes,
  });

  LastWatchedSeries.fromJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    id = json['id'];
    name = isAr ? json['name'] : json['nameInEnglish'] ?? json['name'];
    image = json['image'] == null ? image = "" : image = json["image"];
    // status = json['status'];
    // createdDate = json['createdDate'];
    // publishDate = json['publishDate'];
    // lastModifiedDate = json['lastModifiedDate'];
    // if (json['episodes'] != null) {
    //   episodes = <Episode>[];
    //   json['episodes'].forEach((v) {
    //     episodes?.add(Episode.fromJson(v));
    //   });
    // }
  }
}

// class ActivityId {
//   int? id;
//   String? name;
//   String? createdDate;
//   String? publishDate;
//   String? lastModifiedDate;
//   List<Questions>? questions;
//
//   ActivityId({
//     this.id,
//     this.name,
//     this.createdDate,
//     this.publishDate,
//     this.lastModifiedDate,
//     this.questions,
//   });
//
//   ActivityId.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     createdDate = json['createdDate'];
//     publishDate = json['publishDate'];
//     lastModifiedDate = json['lastModifiedDate'];
//     if (json['questions'] != null) {
//       questions = <Questions>[];
//       json['questions'].forEach((v) {
//         questions?.add(Questions.fromJson(v));
//       });
//     }
//   }
// }

// class VideoWithMusicId {
//   int? id;
//   String? url;
//   double? duration;
//
//   VideoWithMusicId({
//     this.id,
//     this.url,
//     this.duration,
//   });
//
//   VideoWithMusicId.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     url = json['url'];
//     duration = json['duration'];
//   }
// }

// class VideoWithoutMusicId {
//   int? id;
//   String? url;
//   double? duration;
//
//   VideoWithoutMusicId({
//     this.id,
//     this.url,
//     this.duration,
//   });
//
//   VideoWithoutMusicId.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     url = json['url'];
//     duration = json['duration'];
//   }
// }

class MostWatchedSeries {
  int? id;
  String? name;
  String? image;

  // String? status;
  // String? createdDate;
  // String? publishDate;
  // String? lastModifiedDate;
  // List<Episode>? episodes;

  MostWatchedSeries({
    this.id,
    this.name,
    this.image,
    // this.status,
    // this.createdDate,
    // this.publishDate,
    // this.lastModifiedDate,
    // this.episodes,
  });

  MostWatchedSeries.fromJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    id = json['id'];
    name = isAr ? json['name'] : json['nameInEnglish'] ?? json['name'];
    image = json['image'] == null ? image = "" : image = json["image"];
    // status = json['status'];
    // createdDate = json['createdDate'];
    // publishDate = json['publishDate'];
    // lastModifiedDate = json['lastModifiedDate'];
    // if (json['episodes'] != null) {
    //   episodes = <Episode>[];
    //   json['episodes'].forEach((v) {
    //     episodes?.add(Episode.fromJson(v));
    //   });
    // }
  }
}

class SerialReport {
  int? numberOfWatching;
  int? duration;
  String? name;

//  int numberOfEpisodes;
  int? id;

// ignore: prefer_typing_uninitialized_variables
  var image;
  List<EpisodesReports>? episodesInSeries;

  SerialReport({
    this.numberOfWatching,
    this.duration,
//        this.numberOfEpisodes,
    this.id,
    this.image,
//        this.name,
    this.episodesInSeries,
  });

  SerialReport.fromJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    numberOfWatching = json['number_of_watching'];
    duration = json['duration'];
//    videoDuration = json['videoDuration'] == null ? 0 : videoDuration = json['videoDuration'];
    id = json['seriesId'];
//    numberOfEpisodes = json['numberOfEpisodes'];
    image = json['seriesImage'] == null ? "" : image = json['seriesImage'];
    name = json['seriesName'] == null
        ? ""
        : name = isAr
            ? json['seriesName']
            : json['seriesNameInEnglish'] ?? json['seriesName'];
    if (json['episodesInSeries'] != null) {
      episodesInSeries = <EpisodesReports>[];
      json['episodesInSeries'].forEach((v) {
        episodesInSeries?.add(EpisodesReports.fromSerialJson(v));
      });
    }
  }
}
