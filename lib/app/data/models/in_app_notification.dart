class InAppNotification {
  final int id;
  final String mediaUrl, text, actionLink;
  final String? audio;
  final bool once, isVideo;

  InAppNotification({
    required this.id,
    required this.mediaUrl,
    required this.text,
    this.audio,
    required this.actionLink,
    required this.once,
    required this.isVideo,
  });

  factory InAppNotification.fromJson(Map<String, dynamic> json) =>
      InAppNotification(
        id: json['id'],
        mediaUrl: json['contentType'],
        text: json['text'],
        actionLink: json['actionLink'],
        once: !json['isViewsEveryTime'],
        isVideo: json['isVideo'],
        audio: json['audio'],
      );
}
