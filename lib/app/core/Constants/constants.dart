import 'dart:ui';

import 'package:flutter/material.dart';

import '../../data/enums/content_type.dart';

class JeelColors {
  static const Color lightOrange = Color(0xffffad4d);
}

class AppConstants {
  //static String userToken;
  //static User user;
  static int? childId;
  static ContentType? contentType;
  static String childGender = 'boy';
  static bool isAnonymous = false;
  static bool isPaidUser = false;
  static bool isAfterGame = false;
  static var parentMainColor = 0xFFfdebc8;
  static var amber = const Color(0xffffaf43);
  static var parentDarkColor = 0xFFffad4d;
  static var parentTextFieldColor = 0xFF000000;
  static var purple = 0xff6d316b;
  static var lightTan = 0xfffce7bc;
  static var shapesOpacity = 0.3;
  static String suspendStatus = "SUSPENDED";
  static String defaultStatus = "DEFAULT";
  static String zendeskAccountKey = 'rVsdP33FK31Q8eZxdFwegHbpDOk2rzMd';
  static String zendeskAppId =
      '9ab22945dbfffbe104e1db66d53f0a027f92b4d8f4660d43';
  static bool? isExpirationSoon = false;
  static bool? isPaymentExpired = false;
  static bool isOldUser = false;
  static bool showExpirationWarning = true;
  static const int channelAsEpisodeId = -5;
  static const String kLocaleKey = "LOCALE_KEY";

  //TODO: Remember to set this value
  static const errorImage = '';

  static bool hasGooglePlayServices = true;

  static logout() {
    childId = null;
    isPaidUser = false;
    isOldUser = false;
    isExpirationSoon = false;
    isPaymentExpired = false;
    showExpirationWarning = true;
  }

  //BaseUrl
  ///  prod: https://jeelpay.com/
  ///  pre Prod: https://pay-preprod.jeelapp.com/
  ///  dev:  http://jeel-admin-dev.us-east-1.elasticbeanstalk.com/
  ///  staging: http://newgenerest-env.rkhpj2fvru.us-east-1.elasticbeanstalk.com/
  static const String baseUrl = "https://jeelpay.com/";
  static String kAppGalleryUrl = 'https://appgallery.huawei.com/app/C103389579';

  /*static String kStripPublishableKey =
      'pk_test_51FZvbVKwQ0AlKDaJ3kV7FPz5LrKKB5ZZKb36W4zQzRw4QWpU9bWSeRiDLBiEKuBIdJouHQYAxsE0esONuTMKAAQr00L5fDdozZ';*/
  static String kStripPublishableKey =
      'pk_live_HQ94p4ndLTGtaJJf5rOaNxXy005Ai1LEcW';

  /// Twitter Keys
  static String twitterApiKey = "NzxNUGVfLiK5t9b73XSWjtMzm";
  static String twitterApiSecretKey =
      "88YMjQapFKzDSLQp3TK4qQGPF6DuhUDNxJRaqboLswEQAVQ2sD";
  static String twitterRedirectURI = "mobidevlabsgen://";

  static const int kChannelAsEpisodeId = -5;

  static const String madaRegexV =
      "4(0(0861|1757|7(197|395)|9201)|1(0685|7633|9593)|2(281(7|8|9)|8(331|67(1|2|3)))|3(1361|2328|4107|9954)|4(0(533|647|795)|5564|6(393|404|672))|5(5(036|708)|7865|8456)|6(2220|854(0|1|2|3))|8(301(0|1|2)|4783|609(4|5|6)|931(7|8|9))|93428)";
  static const String madaRegexM =
      "5(0(4300|8160)|13213|2(1076|4(130|514)|9(415|741))|3(0906|1095|2013|5(825|989)|6023|7767|9931)|4(3(085|357)|9760)|5(4180|7606|8848)|8(5265|8(8(4(5|6|7|8|9)|5(0|1))|98(2|3))|9(005|206)))|6(0(4906|5141)|36120)|9682(0(1|2|3|4|5|6|7|8|9)|1(0|1))";

  /// FCM web key
  static const String vapidKey =
      'BMuBwaQUrmNcxGb5GMFJcZV4CvLNZI4wp-R6CQQdTi_pcC_vPY4Mgpn0HxpOAcCHbJC_xEN_R0_QwQniqFyrpzg';

  static const String inAppNotificationKey = "in_app_notification";
  static const String addChildForCompleteYourData =
      "addChildForCompleteYourData";

  //Parent Section
  static const String getGeneralSettingData =
      "${baseUrl}GeneralSetting/getGeneralSettingData";

  //Kid Section
  static const String getActivityDetails =
      "${baseUrl}Activity/getActivityDetails";
  static const String getAllActiveSeries =
      "${baseUrl}Series/getAllActiveSeries";
  static const String getAllActiveDiscoverUsSeries =
      "${baseUrl}DiscoverUs/getAllActiveDiscoverUsSeries";
  static const String getAllActiveSongs = "${baseUrl}Song/getAllActiveSongs";
  static const String getAllSongParent =
      "${baseUrl}SongParent/getAllActiveSongParent";
  static const String getAllStoriesParent =
      "${baseUrl}StoryParent/getAllActiveStoryParent";
  static const String getAllActiveStories =
      "${baseUrl}Story/getAllActiveStories";
  static const String getGeneralActivity =
      "${baseUrl}Activity/getGeneralActivity";
  static const String checkActivityTracking =
      "${baseUrl}ActivityTracking/checkActivityTracking";

  //Tracking
  static const String setTrackVideoWatchingTime =
      "${baseUrl}FirstTimeVideoTracking/setFirstTimeUsage";
  static const String setTrackAudioListeningTime =
      "${baseUrl}FirstTimeRadioChannelTracking/setChannelFirstTimeUsage";
  static const String setTrackGame =
      "${baseUrl}FirstTimeGameDataTracking/setGameFirstTimeUsage";
  static const String setActivityTracking =
      "${baseUrl}ActivityTracking/setActivityTracking";
  static const String setAppTimeUsageForKid =
      "${baseUrl}KidTracker/setDailyUsage";
  static const String setAppTimeUsageForParent =
      "${baseUrl}UserTracker/setUserDailyUsage";

  //User
  static const String updateUserFCMToken =
      "$baseUrl/User/updateFirebaseDeviceToken";

  ///Radio End points
  static const String getRadio = '${baseUrl}Radio/getAllActiveRadio';

  ///In-app Notification End points
  static const String getInAppNotifications =
      '${baseUrl}InAppNotification/getAllActiveInAppNotification';
}
