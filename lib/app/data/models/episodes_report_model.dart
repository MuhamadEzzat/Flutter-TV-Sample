import 'package:get/get.dart';

class EpisodesReports {
  List<EpisodeReport>? episodesReports;
  WatchedEpisode? mostWatchedEpisode;
  WatchedEpisode? lastWatchedEpisode;
  String? error;

  EpisodesReports({
    this.mostWatchedEpisode,
    this.episodesReports,
    this.lastWatchedEpisode,
    this.error,
  });

  EpisodesReports.withError(String errorValue)
      : mostWatchedEpisode = null,
        lastWatchedEpisode = null,
        episodesReports = null,
        error = errorValue;

  EpisodesReports.fromSerialJson(Map<String, dynamic> json) {
    lastWatchedEpisode = json['lastWatchedEpisode'] != null
        ? WatchedEpisode.fromJson(json['lastWatchedEpisode'])
        : null;
    mostWatchedEpisode = json['mostWatchedEpisode'] != null
        ? WatchedEpisode.fromJson(json['mostWatchedEpisode'])
        : null;
    if (json['episodesReport'] != null) {
      episodesReports = <EpisodeReport>[];
      json['episodesReport'].forEach((episodeReport) {
        episodesReports?.add(EpisodeReport.fromEpisodeJson(episodeReport));
      });
    }
  }

  EpisodesReports.fromStoriesJson(Map<String, dynamic> json) {
    mostWatchedEpisode = json['mostWatchedStory'] != null
        ? WatchedEpisode.fromJson(json['mostWatchedStory'])
        : null;
    if (json['storyReports'] != null) {
      episodesReports = <EpisodeReport>[];
      json['storyReports'].forEach((story) {
        episodesReports?.add(EpisodeReport.fromStoryJson(story));
      });
    }
    lastWatchedEpisode = json['lastWatchedStory'] != null
        ? WatchedEpisode.fromJson(json['lastWatchedStory'])
        : null;
  }

  EpisodesReports.fromSongsJson(Map<String, dynamic> json) {
    mostWatchedEpisode = json['mostWatchedSong'] != null
        ? WatchedEpisode.fromJson(json['mostWatchedSong'])
        : null;
    if (json['songsReports'] != null) {
      episodesReports = <EpisodeReport>[];
      json['songsReports'].forEach((songReport) {
        episodesReports?.add(EpisodeReport.fromSongJson(songReport));
      });
    }
    lastWatchedEpisode = json['lastWatchedSong'] != null
        ? WatchedEpisode.fromJson(json['lastWatchedSong'])
        : null;
  }
}

class WatchedEpisode {
  int? id;
  String? name;
  String? image;

  WatchedEpisode({
    this.id,
    this.name,
    this.image,
  });

  WatchedEpisode.fromJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    id = json['id'];
    name = isAr ? json['name'] : json['nameInEnglish'] ?? json['name'];
    image = json['image'] == null ? "" : image = json['image'];
  }
}

class EpisodeReport {
  int? numberOfWatching;
  int? duration;
  int? id;
  DateTime? lastWatchingDate;

  // ignore: prefer_typing_uninitialized_variables
  var image;

  // ignore: prefer_typing_uninitialized_variables
  var name;

  EpisodeReport(
      {this.numberOfWatching,
      this.duration,
      this.id,
      this.lastWatchingDate,
      this.image,
      this.name});

  EpisodeReport.fromStoryJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    numberOfWatching = json['number_of_watching'];
    duration = json['duration'];
    id = json['storyId'];
    lastWatchingDate = json['lastWatchingDate'] != null
        ? DateTime.parse(json['lastWatchingDate'])
        : null;
    image = json['storyImage'] == null ? "" : image = json['storyImage'];
    name = json['storyName'] == null
        ? ""
        : name = isAr
            ? json['storyName']
            : json['storyNameInEnglish'] ?? json['storyName'];
  }

  EpisodeReport.fromSongJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    numberOfWatching = json['number_of_watching'];
    duration = json['duration'];
    id = json['songId'];
    lastWatchingDate = json['lastWatchingDate'] != null
        ? DateTime.parse(json['lastWatchingDate'])
        : null;
    name =
        isAr ? json['songName'] : json['songNameInEnglish'] ?? json['songName'];
    image = json['songImage'] == null ? "" : image = json["songImage"];
  }

  EpisodeReport.fromEpisodeJson(Map<String, dynamic> json) {
    bool isAr = Get.locale?.languageCode == "ar";
    numberOfWatching = json['number_of_watching'];
    duration = json['duration'];
    id = json['episodeId'];
    lastWatchingDate = json['lastWatchingDate'] != null
        ? DateTime.parse(json['lastWatchingDate'])
        : null;
    image = json['episodeImage'] == null ? "" : image = json['episodeImage'];
    name = json['episodeName'] == null
        ? ""
        : name = isAr
            ? json['episodeName']
            : json['episodeNameInEnglish'] ?? json['episodeName'];
  }
}
