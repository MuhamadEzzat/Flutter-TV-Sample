class Video {
  String? url;
  String? cloudFrontUrl;
  String? vimeoUrl;
  String? videoCipherId;
  int id;
  double? duration;

  Video(
      {this.url,
      this.id = -1,
      this.duration,
      this.cloudFrontUrl,
      this.vimeoUrl,
      this.videoCipherId});

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        url: json['url'],
        cloudFrontUrl: json['cloudFrontUrl'],
        vimeoUrl: json['vimeoUrl'],
        id: json['id'] ?? -1,
        duration: json['duration'],
        videoCipherId: json['vdocipherId'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['url'] = url;
    data['cloudFrontUrl'] = url;
    data['vdocipherId'] = videoCipherId;

    data['vimeourl'] = vimeoUrl;
    data['id'] = id;
    data['duration'] = duration;
    return data;
  }
}
