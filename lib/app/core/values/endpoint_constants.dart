
import '../Constants/constants.dart';

class EndPoints {
  const EndPoints._();

  //Parent Section
  static const String getGeneralSettingData =
      "${AppConstants.baseUrl}GeneralSetting/getGeneralSettingData";
  static const String getAllBlogs = "${AppConstants.baseUrl}Blog/getAllBlogs";
  static const String getAllEducationVideos =
      AppConstants.baseUrl + "parentLibrary/getAllActiveParentLibrary";
  static const String createIssue =
      "${AppConstants.baseUrl}Issue/saveIssueWithImages";
  static const String addImageToIssue =
      "${AppConstants.baseUrl}Issue/addimagestoIssue";
  static const String deleteImageFromIssue =
      "${AppConstants.baseUrl}Issue/deleteimagesfromIssue";
  static const String commentOnIssue =
      "${AppConstants.baseUrl}Comment/saveComment";
  static const String getIssueData =
      "${AppConstants.baseUrl}Issue/getIssueData";
  static const String getIssuesByUser =
      "${AppConstants.baseUrl}Issue/getIssuesByUser";
  static const String getAllFAQ = "${AppConstants.baseUrl}FAQ/getAllFAQ";
  static const String getAllTermsAndConditions =
      "${AppConstants.baseUrl}TermsAndConditions/getAllTermsAndconditions";

  //Kid Section
  static const String getActivityDetails =
      "${AppConstants.baseUrl}Activity/getActivityDetails";
  static const String getAllActiveSeries =
      "${AppConstants.baseUrl}Series/getAllActiveSeries";
  static const String getAllActiveDiscoverUsSeries =
      "${AppConstants.baseUrl}DiscoverUs/getAllActiveDiscoverUsSeries";
  static const String getAllActiveSongs =
      "${AppConstants.baseUrl}Song/getAllActiveSongs";
  static const String getAllSongParent =
      "${AppConstants.baseUrl}SongParent/getAllActiveSongParent";
  static const String getAllStoriesParent =
      "${AppConstants.baseUrl}StoryParent/getAllActiveStoryParent";
  static const String getAllActiveStories =
      "${AppConstants.baseUrl}Story/getAllActiveStories";
  static const String getGeneralActivity =
      "${AppConstants.baseUrl}Activity/getGeneralActivity";
  static const String checkActivityTracking =
      "${AppConstants.baseUrl}ActivityTracking/checkActivityTracking";
  static const String getAllActiveBanners =
      "${AppConstants.baseUrl}Banner/getAllActiveBanners";

  //Tracking
  static const String setTrackVideoWatchingTime =
      "${AppConstants.baseUrl}FirstTimeVideoTracking/setFirstTimeUsage";
  static const String setTrackAudioListeningTime =
      "${AppConstants.baseUrl}FirstTimeRadioChannelTracking/setChannelFirstTimeUsage";
  static const String setTrackGame =
      "${AppConstants.baseUrl}FirstTimeGameDataTracking/setGameFirstTimeUsage";
  static const String setActivityTracking =
      "${AppConstants.baseUrl}ActivityTracking/setActivityTracking";
  static const String setAppTimeUsageForKid =
      "${AppConstants.baseUrl}KidTracker/setDailyUsage";
  static const String setAppTimeUsageForParent =
      "${AppConstants.baseUrl}UserTracker/setUserDailyUsage";

  //Auth
  static const String login = "${AppConstants.baseUrl}User/mobileLogin";
  static const String register = "${AppConstants.baseUrl}User/mobileRegister";
  static const String verifyEmail = "${AppConstants.baseUrl}User/verifyEmail";

  //User
  static const String updateUser = "${AppConstants.baseUrl}User/updateUser";
  static const String deleteUser = "${AppConstants.baseUrl}User/deleteUser";
  static const String updateUserFCMToken =
      "${AppConstants.baseUrl}/User/updateFirebaseDeviceToken";
  static const String changingVideosMusicOn =
      "${AppConstants.baseUrl}User/changingVideosMusicOn";
  static const String addChild = "${AppConstants.baseUrl}Child/addChild";
  static const String deleteChild = "${AppConstants.baseUrl}Child/deleteChild";
  static const String suspendChild =
      "${AppConstants.baseUrl}Child/suspendChild";
  static const String updateChild = "${AppConstants.baseUrl}Child/updateChild";

  //Subscription
  static const String getPaymentByCountryMada =
      "${AppConstants.baseUrl}PaymentCountriesPayingMethod/getPaymentPayingMethod";
  static const String getPaymentPackageByCountry =
      "${AppConstants.baseUrl}PaymentHandlingPrices/getPaymentPackageByCountry";
  static const String getPaymentMethodByCountryAndMethod =
      "${AppConstants.baseUrl}PaymentHandlingPrices/getPaymentMethodByCountryAndMethod";
  static const String makeStripePayment =
      "${AppConstants.baseUrl}UserPaymentPlan/addUserPaymentPlan";
  static const String activeQrCodePayment =
      "${AppConstants.baseUrl}PaymentCard/activeQrCodePayment";
  static const String cancelSubscription =
      "${AppConstants.baseUrl}Stripe/cancelSubscription";
  static const String cancelTpaySubscription =
      "${AppConstants.baseUrl}Tpay/cancelSubscriptionAPI";
  static const String getFawryHtmlPageUrl =
      "${AppConstants.baseUrl}FawryOrder/getFawryHtmlPageUrl";
  static const String getAllUserPaymentHistory =
      "${AppConstants.baseUrl}PaymentHistory/getAllUserPaymentHistory";
  static const String hyperPayRequestCheckoutId =
      "${AppConstants.baseUrl}HyperPay/prepareCheckout";
  static const String hyperPayStatus =
      "${AppConstants.baseUrl}HyperPay/getPaymentStatus";

  //Reports
  static const String getDailyUsageStatus =
      "${AppConstants.baseUrl}KidTracker/getDailyUsageStatus";
  static const String getChildWatchingsReport =
      "${AppConstants.baseUrl}Tracking/getChildWatchingsReport";
  static const String getChildListeningReport =
      "${AppConstants.baseUrl}Tracking/getRadiosReport";
  static const String getChildGameReport =
      "${AppConstants.baseUrl}Tracking/getAllGameDataReport";
  static const String getActivitiesReport =
      "${AppConstants.baseUrl}ActivityTracking/getActivitiesReport";
  // static const String getNormalSeriesReport =
  //     AppConstants.baseUrl + "Tracking/getNormalSeriesesReport";
  // static const String getDiscoverSeriesReport =
  //     AppConstants.baseUrl + "Tracking/getDiscoverSeriesesReport";
  // static const String getSongsReport =
  //     AppConstants.baseUrl + "Tracking/getSongsReport";
  // static const String getStoriesReport =
  //     AppConstants.baseUrl + "Tracking/getStoriesReport";

  //Josoor
  static const String searchDirectory =
      "${AppConstants.baseUrl}SearchDirectory/searchDirectory";
  // static const String getAllActiveEpisodes =
  //     AppConstants.baseUrl + "Episode/getAllActiveEpisodes";
  static const String getEpisodeDetails =
      "${AppConstants.baseUrl}Episode/getEpisodeDetails";
  static const String getSongDetails =
      "${AppConstants.baseUrl}Song/getSongDetails";
  static const String getStoryDetails =
      "${AppConstants.baseUrl}Story/getStoryDetails";
  static const String getNormalSeriesDetails =
      "${AppConstants.baseUrl}Series/getNormalSeriesDetails";
  static const String getDiscoverUsSeriesDetails =
      "${AppConstants.baseUrl}DiscoverUs/getDiscoverUsSeriesDetails";
  static const String getContentMainValueDetails =
      "${AppConstants.baseUrl}ContentMainValue/getContentMainValueDetails";
  static const String getContentSubValueDetails =
      "${AppConstants.baseUrl}ContentSubValue/getContentSubValueDetails";
  static const String getContentWithSubValue =
      "${AppConstants.baseUrl}ContentSubValue/getContentWithSubValue";
  static const String getAllContentMainValues =
      "${AppConstants.baseUrl}ContentMainValue/getAllcontnetMainValues";

  ///Static Urls for privacy policy, terms&conditions, etc...
  static const String privacyPolicyUrl =
      'https://jeelapp.com/EN/privacypolicy/';
  static const String termsAndConditionsUrl =
      'https://jeelapp.com/EN/terms-of-use/';
  static const String intellectualPropertyNoticeUrl =
      'https://jeelapp.com/EN/intellectual-property-notice/';
  static const String disclaimerOfLiabilityUrl =
      'https://jeelapp.com/EN/disclaimer-of-liability/';
  static const String parentalNoticeUrl =
      'https://jeelapp.com/EN/parental-consent-notice/';

  ///Radio End points
  static const String getRadio =
      '${AppConstants.baseUrl}Radio/getAllActiveRadio';

  ///In-app Notification End points
  static const String getInAppNotification =
      '${AppConstants.baseUrl}InAppNotification/getAllActiveInAppNotification';

  ///Games End points
  static const String GET_ALL_CATEGORIES_OF_GAMES =
      "${AppConstants.baseUrl}GameParent/getAllActiveGameParent";
  static const String GET_GAMES_CHILDS =
      "${AppConstants.baseUrl}GameParent/getGameParentWithActiveGames";
  static const String GET_GAMES =
      "${AppConstants.baseUrl}gameData/activeGameData";

  //books
  static const String GET_ACTIVE_BOOKS =
      "${AppConstants.baseUrl}Book/getAllActiveBooks";

  static const String GET_ALL_CATEGORIES_OF_BOOKS =
      "${AppConstants.baseUrl}BookParent/getAllActiveBookParent";
  static const String GET_BOOKS_CHILDS =
      "${AppConstants.baseUrl}BookParent/getBookParentWithActiveBooks";

  static const String HYPER_PAY_REQUEST_CHECKOUT_ID =
      "${AppConstants.baseUrl}HyperPay/prepareCheckout";

  static const String HYPER_PAY_STATUS =
      "${AppConstants.baseUrl}HyperPay/getPaymentStatus";

  // cipher
  static const String VDOCIPHERURL = "${AppConstants.baseUrl}vdocipher/otp";

  static const String DynamicSection =
      "${AppConstants.baseUrl}DynamicSection/getActiveDynamicSections";
  static const String sectionContent =
      "${AppConstants.baseUrl}DynamicSection/getDynamicSectionContent";

  // get active section episode
  static const String storyActiveEpisodes =
      "${AppConstants.baseUrl}StoryParent/getStoryParentActiveData";
  static const String songActiveEpisodes =
      "${AppConstants.baseUrl}SongParent/getSongParentActiveData";
  static const String gameActiveEpisodes =
      "${AppConstants.baseUrl}GameParent/getGameParentActiveData";
  static const String bookActiveEpisodes =
      "${AppConstants.baseUrl}BookParent/getBookParentActiveData";
  static const String radioActiveEpisodes =
      "${AppConstants.baseUrl}Radio/getRadioActiveData";
  static const String seriesActiveEpisodes =
      "${AppConstants.baseUrl}general-series/getSeriesActiveData";
  static const String getGameData =
      "${AppConstants.baseUrl}gameData/getGameData";
  static const String getBookData =
      "${AppConstants.baseUrl}Book/getBookDetails";
}
