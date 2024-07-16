import 'channel_model.dart';
import 'episode_model.dart';

class ContentFromSubValue {
  List<Episode>? episodes, songs, stories;
  List<Channel>? channels;

  String? error;

  bool loading = false;

  ContentFromSubValue(
    this.episodes,
    this.songs,
    this.stories,
    this.channels,
    this.error,
  );

  ContentFromSubValue.fromJson(Map<String, dynamic> json) {
    episodes = (json['episode'] as List?) != null
        ? (json['episode'] as List).map((i) => Episode.fromJson(i)).toList()
        : [];
    songs = (json['songs'] as List?) != null
        ? (json['songs'] as List).map((i) => Episode.fromSongJson(i)).toList()
        : [];
    stories = (json['stories'] as List?) != null
        ? (json['stories'] as List)
            .map((i) => Episode.fromStoryJson(i))
            .toList()
        : [];
    channels = ((json['radioChannels'] as List?) ?? [])
        .map((c) => Channel.fromJson(c))
        .toList();
  }
  ContentFromSubValue.withError(String error) {
    error = error;
  }
  ContentFromSubValue.loading() {
    loading = true;
  }

  List<Episode> combineContentInOneList() {
    List<Episode> allInOne = [];
    if (episodes != null) allInOne.addAll(episodes!);
    if (songs != null) allInOne.addAll(songs!);
    if (stories != null) allInOne.addAll(stories!);
    if (channels != null) {
      List<Episode> channelsToEpisodes =
          channels!.map((c) => Episode.fromSChannel(c)).toList();
      allInOne.addAll(channelsToEpisodes);
    }
    return allInOne;
  }
}
