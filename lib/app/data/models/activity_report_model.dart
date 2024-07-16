import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityReport {
  List<ContentActivity>? normalSeriesActivity;
  List<ContentActivity>? discoverSeriesActivity;
  List<ContentActivity>? songsActivity;
  List<ContentActivity>? storiesActivity;
  bool loading = false;
  String? error;

  ActivityReport({
    this.normalSeriesActivity,
    this.discoverSeriesActivity,
    this.songsActivity,
    this.storiesActivity,
  });

  ActivityReport.loading() : loading = true;

  ActivityReport.fromJson(Map<String, dynamic> json) {
    normalSeriesActivity = (json['normalSeriesActivity'] as List?) != null
        ? (json['normalSeriesActivity'] as List)
            .map((i) => ContentActivity.fromJson(i))
            .toList()
        : null;
    discoverSeriesActivity = (json['discoverSeriesActivity'] as List?) != null
        ? (json['discoverSeriesActivity'] as List)
            .map((i) => ContentActivity.fromJson(i))
            .toList()
        : null;
    songsActivity = (json['songsActivity'] as List?) != null
        ? (json['songsActivity'] as List)
            .map((i) => ContentActivity.fromJson(i))
            .toList()
        : null;
    storiesActivity = (json['storiesActivity'] as List?) != null
        ? (json['storiesActivity'] as List)
            .map((i) => ContentActivity.fromJson(i))
            .toList()
        : null;
  }

  ActivityReport.withError(String errorValue) : error = errorValue;
}

class ContentActivity {
  ActivityTracking? activityTracking;
  ActivityWatchingReport? watchingReport;

  ContentActivity({
    this.activityTracking,
    this.watchingReport,
  });

  ContentActivity.fromJson(Map<String, dynamic> json) {
    activityTracking = json['customActivityTrackingDTO'] != null
        ? ActivityTracking.fromJson(json['customActivityTrackingDTO'])
        : null;
    watchingReport = json['watchingReport'] != null
        ? ActivityWatchingReport.fromJson(json['watchingReport'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (activityTracking != null) {
      data['customActivityTrackingDTO'] = activityTracking!.toJson();
    }
    if (watchingReport != null) {
      data['watchingReport'] = watchingReport!.toJson();
    }
    return data;
  }
}

class ActivityTracking {
  String? activityName;
  DateTime? lastDate;
  String? avgScoreText;
  String? lastScoreText;
  String? recommendation;
  String? file;
  String? articleUrl;
  double? avgScore;
  int? activityId;
  int? numberOfSolvingActivity;
  int? lastScore;

  ActivityTracking({
    this.activityName,
    this.lastDate,
    this.avgScoreText,
    this.lastScoreText,
    this.recommendation,
    this.file,
    this.articleUrl,
    this.avgScore,
    this.activityId,
    this.numberOfSolvingActivity,
    this.lastScore,
  });

  ActivityTracking.fromJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    activityName = isAr
        ? json['activityName']
        : json['activityNameInEnglish'] ?? json['activityName'];
    lastDate = json['lastDate'] != null
        ? DateTime.parse(json['lastDate']).toLocal()
        : null;
    avgScoreText = json['avgScoreText'];
    lastScoreText = json['lastScoreText'];
    recommendation = isAr
        ? json['recommendation']
        : json['recommendationInEnglish'] ?? json['recommendation'];
    file = json['file'];
    articleUrl = json['articleUrl'];
    avgScore = json['avgScore'];
    activityId = json['activityId'];
    numberOfSolvingActivity = json['numberOfSolvingActivity'];
    lastScore = json['lastScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['activityName'] = activityName;
    data['lastDate'] = lastDate;
    data['avgScoreText'] = avgScoreText;
    data['lastScoreText'] = lastScoreText;
    data['recommendation'] = recommendation;
    data['file'] = file;
    data['articleUrl'] = articleUrl;
    data['avgScore'] = avgScore;
    data['activityId'] = activityId;
    data['numberOfSolvingActivity'] = numberOfSolvingActivity;
    data['lastScore'] = lastScore;
    return data;
  }
}

class ActivityWatchingReport {
  String? name;
  String? image;
  String? lastWatchingDate;
  int? id;
  int? numberOfWatching;

  ActivityWatchingReport({
    this.name,
    this.image,
    this.lastWatchingDate,
    this.id,
    this.numberOfWatching,
  });

  ActivityWatchingReport.fromJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    name = isAr ? json['name'] : json['nameInEnglish'] ?? json['name'];
    image = json['image'];
    lastWatchingDate = json['lastWatchingDate'];
    id = json['id'];
    numberOfWatching = json['number_of_watching'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['image'] = image;
    data['lastWatchingDate'] = lastWatchingDate;
    data['id'] = id;
    data['number_of_watching'] = numberOfWatching;
    return data;
  }
}
