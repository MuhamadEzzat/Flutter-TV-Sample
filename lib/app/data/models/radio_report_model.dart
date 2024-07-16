import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'channel_report_model.dart';

class RadioReport {
  LastListenedRadio? lastListenedRadio;
  MostListenedRadio? mostListenedRadio;
  List<RadiosReport>? radiosReport;
  String? error;
  bool loading = false;

  RadioReport({
    this.lastListenedRadio,
    this.mostListenedRadio,
    this.radiosReport,
    this.error,
  });

  RadioReport.fromJson(Map<String, dynamic> json) {
    lastListenedRadio = json['lastWatchedRadio'] != null
        ? LastListenedRadio.fromJson(json['lastWatchedRadio'])
        : null;
    mostListenedRadio = json['mostWatchedRadio'] != null
        ? MostListenedRadio.fromJson(json['mostWatchedRadio'])
        : null;
    if (json['radioReports'] != null) {
      radiosReport = <RadiosReport>[];
      json['radioReports'].forEach((v) {
        radiosReport?.add(RadiosReport.fromJson(v));
      });
    }
  }

  RadioReport.loading() : loading = true;

  RadioReport.withError(String errorValue)
      : mostListenedRadio = null,
        lastListenedRadio = null,
        radiosReport = null,
        error = errorValue;
}

class LastListenedRadio {
  int? id;
  String? name;
  String? image;

  /*
  String status;
  String createdDate;
  String publishDate;
  String lastModifiedDate;
  List<Episode> episodes;*/

  LastListenedRadio({
    this.id,
    this.name,
    this.image,
    /*
    this.status,
    this.createdDate,
    this.publishDate,
    this.lastModifiedDate,
    this.episodes*/
  });

  LastListenedRadio.fromJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    id = json['id'];
    name = isAr ? json['name'] : json['nameInEnglish'] ?? json['name'];
    image = json['image'] == null ? image = "" : image = json["image"];
    /*status = json['status'];
    createdDate = json['createdDate'];
    publishDate = json['publishDate'];
    lastModifiedDate = json['lastModifiedDate'];
    if (json['episodes'] != null) {
      episodes = new List<Episode>();
      json['episodes'].forEach((v) {
        episodes.add(new Episode.fromJson(v));
      });
    }*/
  }
}

/*class ActivityId {
  int id;
  String name;
  String createdDate;
  String publishDate;
  String lastModifiedDate;
  List<Questions> questions;

  ActivityId({this.id,
    this.name,
    this.createdDate,
    this.publishDate,
    this.lastModifiedDate,
    this.questions});

  ActivityId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdDate = json['createdDate'];
    publishDate = json['publishDate'];
    lastModifiedDate = json['lastModifiedDate'];
    if (json['questions'] != null) {
      questions = new List<Questions>();
      json['questions'].forEach((v) {
        questions.add(new Questions.fromJson(v));
      });
    }
  }
}*/

/*class VideoWithMusicId {
  int id;
  String url;
  double duration;

  VideoWithMusicId({this.id, this.url, this.duration});

  VideoWithMusicId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    duration = json['duration'];
  }
}*/

/*class VideoWithoutMusicId {
  int id;
  String url;
  double duration;

  VideoWithoutMusicId({this.id, this.url, this.duration});

  VideoWithoutMusicId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    duration = json['duration'];
  }
}*/

class MostListenedRadio {
  int? id;
  String? name;
  String? image;

  /*
  String status;
  String createdDate;
  String publishDate;
  String lastModifiedDate;
  List<Episode> episodes;*/

  MostListenedRadio({
    this.id,
    this.name,
    this.image,
    /*
    this.status,
    this.createdDate,
    this.publishDate,
    this.lastModifiedDate,
    this.episodes*/
  });

  MostListenedRadio.fromJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    id = json['id'];
    name = isAr ? json['name'] : json['nameInEnglish'] ?? json['name'];
    image = json['image'] == null ? image = "" : image = json["image"];
    /*status = json['status'];
    createdDate = json['createdDate'];
    publishDate = json['publishDate'];
    lastModifiedDate = json['lastModifiedDate'];
    if (json['episodes'] != null) {
      episodes = new List<Episode>();
      json['episodes'].forEach((v) {
        episodes.add(new Episode.fromJson(v));
      });
    }*/
  }
}

class RadiosReport {
  int? numberOfWatching;
  int? duration;
  String? name;

//  int numberOfEpisodes;
  int? id;

  // ignore: prefer_typing_uninitialized_variables
  var image;
  List<ChannelReport>? channelsInRadio;

  RadiosReport({
    this.numberOfWatching,
    this.duration,
//        this.numberOfEpisodes,
    this.id,
    this.image,
//        this.name,
    this.channelsInRadio,
  });

  RadiosReport.fromJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    numberOfWatching = json['number_of_watching'];
    duration = json['duration'];
//    videoDuration = json['videoDuration'] == null ? 0 : videoDuration = json['videoDuration'];
    id = json['radioId'];
//    numberOfEpisodes = json['numberOfEpisodes'];
    image = json['radioImage'] == null ? "" : image = json['radioImage'];
    name = json['radioName'] == null
        ? ""
        : name = isAr
            ? json['radioName']
            : json['radioNameInEnglish'] ?? json['radioName'];
    if (json['channelsInRadio'] != null) {
      debugPrint(json['channelsInRadio'].toString());
      channelsInRadio = <ChannelReport>[];
      json['channelsInRadio'].forEach((v) {
        channelsInRadio?.add(ChannelReport.fromJson(v));
      });
    }
  }
}
