import 'package:get/get.dart';

import '../../data/enums/content_type.dart';
import '../../data/models/sections_model.dart';
import '../utils/audio_player_utils.dart';
import '../values/app_assets.dart';
import '../values/localization/local_keys.dart';

class SectionsList {
  String? currentLocale = Get.locale?.languageCode;

  // Sections list
  List<SliderSection> performSectionsList() {
    return [
      SliderSection(
        contentType: ContentType.normalSerial,
        name: LocalKeys.kTheSeries.tr,
        selectedImage: AppAssets.kSeriesSelected,
        voiceName: _changeVoiceLanguage('series'),
        webIcon: AppAssets.kWebSeries,
      ),
      SliderSection(
        contentType: ContentType.song,
        name: AudioPlayerUtil.isMusicAllowed
            ? LocalKeys.kTheSongs.tr
            : LocalKeys.kTheChants.tr,
        selectedImage: AudioPlayerUtil.isMusicAllowed
            ? AppAssets.kSongsSelected
            : AppAssets.kSongsSelected,
        voiceName: _changeVoiceLanguage('songs'),
        webIcon: AppAssets.kWebSong,
      ),
      SliderSection(
        contentType: ContentType.discoverSerial,
        name: LocalKeys.kDiscover.tr,
        selectedImage: AppAssets.kDiscoverSelected,
        voiceName: _changeVoiceLanguage('learningAndSkills'),
        webIcon: AppAssets.kWebSeries,
      ),
      SliderSection(
        contentType: ContentType.game,
        name: LocalKeys.kGames.tr,
        selectedImage: AppAssets.kGamesSelected,
        voiceName: _changeVoiceLanguage('games'),
        webIcon: AppAssets.kWebGame,
      ),
      SliderSection(
        contentType: ContentType.readWithJeel,
        name: LocalKeys.kReadWithJeel.tr,
        selectedImage: AppAssets.kReadSelected,
        voiceName: _changeVoiceLanguage('read'),
        webIcon: AppAssets.kWebRead,
      ),
      SliderSection(
        contentType: ContentType.radio,
        name: LocalKeys.kJeelRadio.tr,
        selectedImage: AppAssets.kRadioSelected,
        voiceName: _changeVoiceLanguage('radios'),
        webIcon: AppAssets.kWebRadio,
      ),

      /// Story Section is commented to be requested from the business
      // SliderSection(
      //     contentType: ContentType.story,
      //     name: LocalKeys.kTheStories.tr,
      //     selectedImage: AppAssets.kStoriesSelected,
      //     unSelectedImage: AppAssets.kStoriesUnSelected,
      //     voiceName: _changeVoiceLanguage('stories')),
    ];
  }

  String _changeVoiceLanguage(voiceName) {
    return currentLocale == "ar" ? '$voiceName' : '${voiceName}_en';
  }
}
