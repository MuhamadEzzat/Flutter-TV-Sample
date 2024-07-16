import 'package:get/get.dart';

import '../values/localization/local_keys.dart';
import 'audio_player_utils.dart';

class SongsOrAnasheedUtil {
  static convertSongsToAnasheed(String text) {
    return AudioPlayerUtil.isMusicAllowed
        ? LocalKeys.kSongs.tr
        : LocalKeys.kTheChants.tr;
    // text.replaceAll("أغاني", "أناشيد").replaceAll("أغنية", "أنشودة");
  }
}
