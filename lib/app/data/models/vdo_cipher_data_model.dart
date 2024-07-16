class VdoCipherData {
  String? videoUrl;
  String otp;
  String playbackInfo;

  VdoCipherData({
    this.videoUrl,
    required this.otp,
    required this.playbackInfo,
  });

  factory VdoCipherData.fromJson(Map<String, dynamic> json) => VdoCipherData(
        videoUrl: json["videoUrl"],
        otp: json["otp"] ?? '',
        playbackInfo: json["playbackInfo"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "videoUrl": videoUrl,
        "otp": otp,
        "playbackInfo": playbackInfo,
      };
}
