
import 'package:multimedia_tv_sample/app/data/models/vdo_cipher_data_model.dart';

class GeneralSettings {
  int? id;
  String? aboutUs;
  String? aboutUsEng;
  String? contactUs;
  String? facebookPage;
  String? instagramPage;
  String? twitterAccount;
  VdoCipherData? introVideoWithMusic;
  VdoCipherData? introVideoWithoutMusic;
  String? mainBannerImage;
  String? mainBannerAction;
  String? error;
  bool loading = false;

  GeneralSettings(
      {this.id,
      this.aboutUs,
      this.contactUs,
      this.facebookPage,
      this.instagramPage,
      this.introVideoWithMusic,
      this.introVideoWithoutMusic,
      this.twitterAccount,
      this.mainBannerImage,
      this.mainBannerAction,
      this.error});

  GeneralSettings.withError(String errorValue)
      : id = -1,
        aboutUs = "",
        contactUs = "",
        facebookPage = "",
        instagramPage = "",
        twitterAccount = "",
        introVideoWithMusic = null,
        introVideoWithoutMusic = null,
        error = errorValue;

  GeneralSettings.loading() : loading = true;

  GeneralSettings.fromJson(Map<String, dynamic> json) {
    id = json['generalSetting']['id'];
    aboutUs = json['generalSetting']['aboutUs'];
    aboutUsEng = json['generalSetting']['aboutUsEng'];
    contactUs = json['generalSetting']['contactUs'];
    facebookPage = json['generalSetting']['facebookPage'];
    instagramPage = json['generalSetting']['instagramPage'];
    introVideoWithMusic = json['introwithMusic'] == null
        ? null
        : VdoCipherData.fromJson(json['introwithMusic']);
    introVideoWithoutMusic = json['introwithoutMusic'] == null
        ? null
        : VdoCipherData.fromJson(json['introwithoutMusic']);
    twitterAccount = json['twitterAccount'];
    mainBannerImage = json['mainBannerImage'];
    mainBannerAction = json['mainBannerAction'];
  }
}
