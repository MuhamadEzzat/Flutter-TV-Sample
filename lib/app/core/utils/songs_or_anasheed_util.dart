
import 'audio_player_utils.dart';

class SongsOrAnasheedUtil {
  static convertSongsToAnasheed(String text) {
    return AudioPlayerUtil.isMusicAllowed
        ? text
        : text.replaceAll("أغاني", "أناشيد").replaceAll("أغنية", "أنشودة");
  }
}
