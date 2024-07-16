import 'package:get/get.dart';

class ChannelReport {
  ListenedChannel? lastListenedChannel;
  ListenedChannel? mostListenedChannel;
  List<ChannelsReport>? channelsReport;
  String? error;

  ChannelReport({
    this.mostListenedChannel,
    this.channelsReport,
    this.lastListenedChannel,
    this.error,
  });

  ChannelReport.withError(String errorValue)
      : mostListenedChannel = null,
        lastListenedChannel = null,
        channelsReport = null,
        error = errorValue;

  ChannelReport.fromJson(Map<String, dynamic> json) {
    lastListenedChannel = json['lastWatchedChannel'] != null
        ? ListenedChannel.fromJson(json['lastWatchedChannel'])
        : null;
    mostListenedChannel = json['mostWatchedChannel'] != null
        ? ListenedChannel.fromJson(json['mostWatchedChannel'])
        : null;
    if (json['radioChannelReport'] != null) {
      channelsReport = <ChannelsReport>[];
      json['radioChannelReport'].forEach((channelReport) {
        channelsReport?.add(ChannelsReport.fromJson(channelReport));
      });
    }
  }
}

class ListenedChannel {
  int? id;
  String? name;
  String? image;

  ListenedChannel({
    this.id,
    this.name,
    this.image,
  });

  ListenedChannel.fromJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    id = json['id'];
    name = isAr ? json['name'] : json['nameInEnglish'] ?? json['name'];
    image = json['image'] == null ? "" : image = json['image'];
  }
}

class ChannelsReport {
  int? numberOfWatching;
  int? duration;
  int? id;
  DateTime? lastWatchingDate;

  // ignore: prefer_typing_uninitialized_variables
  var image;

  // ignore: prefer_typing_uninitialized_variables
  var name;

  ChannelsReport({
    this.numberOfWatching,
    this.duration,
    this.id,
    this.lastWatchingDate,
    this.image,
    this.name,
  });

  ChannelsReport.fromJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    numberOfWatching = json['number_of_watching'];
    duration = json['duration'];
    id = json['channelId'];
    lastWatchingDate = json['lastWatchingDate'] != null
        ? DateTime.parse(json['lastWatchingDate'])
        : null;
    image = json['channelImage'] == null ? "" : image = json['channelImage'];
    name = json['channelName'] == null
        ? ""
        : name = isAr
            ? json['channelName']
            : json['channelNameInEnglish'] ?? json['channelName'];
  }
}
