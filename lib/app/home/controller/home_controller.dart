import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../contents/html_game/html_game_screen.dart';
import '../../contents/html_game/views/html5_game_screen.dart';
import '../../core/Constants/constants.dart';
import '../../core/utils/audio_handler.dart';
import '../../core/utils/audio_player_utils.dart';
import '../../core/utils/screen_orientation_util.dart';
import '../../core/values/localization/local_keys.dart';
import '../../data/models/book_category_model.dart';
import '../../data/models/book_model.dart';
import '../../data/models/channel_model.dart';
import '../../data/models/child_model.dart';
import '../../data/models/radio_model.dart';
import '../../data/providers/josoor_provider.dart';
import '../../data/providers/read_with_jeel_provider.dart';
import '../../routes/app_pages.dart';

class HomeController extends GetxController with WidgetsBindingObserver {

  final btnNode1 = FocusNode();
  final btnNode2 = FocusNode();
  final btnNode3 = FocusNode();
  final btnNode4 = FocusNode();
  RxBool changeState = false.obs;

  final int KEY_UP = 19;
  final int KEY_DOWN = 20;
  final int KEY_LEFT = 21;
  final int KEY_RIGHT = 22;
  final int KEY_CENTER = 23;
  final int KEY_BACK = 4;

  @override
  void onInit() {
    super.onInit();
    btnNode1.addListener(_listener);
    btnNode2.addListener(_listener);
    btnNode3.addListener(_listener);
    btnNode4.addListener(_listener);
    initRadio();
  }

  _listener() {
    if (btnNode1.hasFocus ||
        btnNode2.hasFocus ||
        btnNode3.hasFocus ||
        btnNode4.hasFocus) {
      changeState.value = !changeState.value;
    }
  }

  ///Video
  void openVideoPage() {
    Get.toNamed(
      Routes.eduVideoList,
    );
  }

  /// HTML
  void openHtmlPage() {
    Navigator.of(Get.context!).push(
      MaterialPageRoute(
        settings: const RouteSettings(name: "/html5Game"),
        builder: (BuildContext context) => const HTML5GameScreen2(
          gameURL: "https://games.jeelapp.com/concetrate-collect-html5/",
          gameName: "ConcentrateCollect",
        ),
      ),
    );
  }

  /// Book

  BooksRepository booksRepository = Get.put(BooksRepository());

  Rxn<List<BooksCategoryModel>> bookCategoriesList = Rxn();
  Rxn<List<Book>> allBooks = Rxn();

  Future<void> getAllBooks(int bookCategoryID) async {
    allBooks.value = [];
    final response =
        await booksRepository.getBookParentWithActiveBooks(bookCategoryID);
    if (response.success) {
      allBooks.value = (response.data as List<dynamic>)
          .map((game) => Book.fromJson(game))
          .toList();
    }
    debugPrint("book id: ${allBooks.value?.first.id}");
  }

  Future<void> navigateToBookDetails() async {
    await getAllBooks(57);

    debugPrint("mybook: ${allBooks.value?.first.id}");
    ScreenOrientationUtil.landscapeFromPortrait();
    Get.toNamed(Routes.BOOK_DETAILS, arguments: {
      "book": allBooks.value?.first,
    });
  }

  ///Radio
  RxInt currentIndex = 0.obs;
  RxInt currentChannelIndex = 0.obs;
  RxBool radioLoading = false.obs;
  AudioPlayer audioPlayer = AudioPlayer();
  Rxn<Radios?> allRadios = Rxn<Radios?>();
  Rxn<RadioModel?> radio = Rxn<RadioModel>(null);
  final JosoorProvider _josoorProvider =
      Get.put<JosoorProvider>(JosoorProvider());

  Future<void> initRadio() async {
    radioLoading.value = true;
    allRadios.value = await _josoorProvider.getRadios();
    radioLoading.value = false;
  }

  void toChannel(
      RadioModel radio, int index, int sectionIndex, bool isFromHome) async {
    radioLoading.value = true;
    if (radio.channels?[index].voice != null &&
        radio.channels?[index].voice != "null") {
      AudioPlayerUtil.playUrl(radio.channels![index].voice!);
    }
    currentIndex.value = index;
    AudioPlayerUtil.enterVideoMode();

    List<MediaItem> mediaItems =
        await initQueue(radio.channels!, radio.name ?? '', index);

    if (audioHandler == null || await audioHandler!.queue.isEmpty) {
      debugPrint('initQueue');
      audioHandler = await initAudioService(mediaItems);
    } else {
      debugPrint("updateQueue ${index}");
      await audioHandler!.updateQueue(mediaItems);
      await audioHandler!.addQueueItems(mediaItems);
      await audioHandler?.skipToQueueItem(index);
    }
    audioHandler!.setRepeatMode(AudioServiceRepeatMode.all);
    Get.toNamed(
      Routes.childChannelDetailsNew,
      arguments: [
        {LocalKeys.kContentData: radio},
        {LocalKeys.kIndex: index},
        {LocalKeys.kChild: Child()},
        {LocalKeys.kAudioHandler: audioHandler},
        {'SectionIndex': sectionIndex},
        {'isFromHome': isFromHome}
        // {LocalKeys.kMediaItems: mediaItems},
      ],
    );
    radioLoading.value = false;
  }

  void indexChanged(int index) {
    currentIndex.value = index;
  }

  ///Audio Service
  Future<List<MediaItem>> initQueue(
      List<Channel> channels, String radioName, int index) async {
    List<MediaItem> mediaItems = [];
    const initIndex = 0;
    final lastIndex = index + 2 > channels.length ? channels.length : index + 2;
    final myChannels = [...channels];
    List<Channel> channelsToLoadNow = myChannels.sublist(initIndex, lastIndex);
    myChannels.removeRange(initIndex, lastIndex);
    for (int i = 0; i < channelsToLoadNow.length; i++) {
      if (channelsToLoadNow[i].trackWithoutMusic != null &&
          channelsToLoadNow[i].trackWithMusic != null) {
        MediaItem mediaItem =
            await createMediaItem(channelsToLoadNow[i], radioName);
        mediaItems.add(mediaItem);
        debugPrint('Item Added: ${channelsToLoadNow[i].name}');
      }
    }
    if (myChannels.isNotEmpty) {
      continueLoadingChannels(myChannels, radioName);
    }
    return mediaItems;
  }

  continueLoadingChannels(List<Channel> otherChannels, String radioName) async {
    List<MediaItem> otherMediaItems = [];
    for (int i = 0; i < otherChannels.length; i++) {
      if (otherChannels[i].isFree || AppConstants.isPaidUser) {
        if (otherChannels[i].trackWithoutMusic != null &&
            otherChannels[i].trackWithMusic != null) {
          MediaItem mediaItem =
              await createMediaItem(otherChannels[i], radioName);
          otherMediaItems.add(mediaItem);
          debugPrint('Item Added: ${otherChannels[i].name}');
        }
      }
    }
    await audioHandler!.addQueueItems(otherMediaItems);
    // await audioHandler?.skipToQueueItem(currentChannelIndex.value);
  }

  Future<MediaItem> createMediaItem(Channel channel, String radioName) async =>
      MediaItem(
        // This can be any unique id, but we use the audio URL for convenience.
        id: AudioPlayerUtil.isMusicAllowed
            ? channel.trackWithMusic!
            : channel.trackWithoutMusic!,
        album: radioName,
        title: channel.name ?? '',
        artist: "Jeel",
        artUri: Uri.parse(channel.image ?? AppConstants.errorImage),
        duration: await getFileDuration(AudioPlayerUtil.isMusicAllowed
            ? channel.trackWithMusic
            : channel.trackWithoutMusic),
      );

  Future<Duration?> getFileDuration(url) async {
    final duration = await audioPlayer.setUrl(url);
    debugPrint('Duration of $url: ${duration?.inSeconds}');
    return duration;
  }

  void refreshPage(int index) {
    indexChanged(index);
  }
}
