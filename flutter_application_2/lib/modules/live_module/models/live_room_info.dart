class LiveRoomInfo {
  final String id;
  final String title;
  final String coverUrl;
  final String anchorName;
  final int onlineCount;
  final String roomType;
  final String videoUrl;

  LiveRoomInfo({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.anchorName,
    required this.onlineCount,
    required this.roomType,
    required this.videoUrl,
  });

  factory LiveRoomInfo.fromJson(Map<String, dynamic> json) => LiveRoomInfo(
        id: json['id'] as String,
        title: json['title'] as String,
        coverUrl: json['coverUrl'] as String,
        anchorName: json['anchorName'] as String,
        onlineCount: json['onlineCount'] as int,
        roomType: json['roomType'] as String,
        videoUrl: json['videoUrl'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'coverUrl': coverUrl,
        'anchorName': anchorName,
        'onlineCount': onlineCount,
        'roomType': roomType,
        'videoUrl': videoUrl,
      };

  LiveRoomInfo copyWith({
    String? id,
    String? title,
    String? coverUrl,
    String? anchorName,
    int? onlineCount,
    String? roomType,
    String? videoUrl,
  }) {
    return LiveRoomInfo(
      id: id ?? this.id,
      title: title ?? this.title,
      coverUrl: coverUrl ?? this.coverUrl,
      anchorName: anchorName ?? this.anchorName,
      onlineCount: onlineCount ?? this.onlineCount,
      roomType: roomType ?? this.roomType,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LiveRoomInfo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          coverUrl == other.coverUrl &&
          anchorName == other.anchorName &&
          onlineCount == other.onlineCount &&
          roomType == other.roomType &&
          videoUrl == other.videoUrl;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      coverUrl.hashCode ^
      anchorName.hashCode ^
      onlineCount.hashCode ^
      roomType.hashCode ^
      videoUrl.hashCode;

  static List<LiveRoomInfo> mockList([int count = 5]) {
    return List.generate(count, (i) => LiveRoomInfo(
      id: '${i + 1}',
      title: 'Live Room ${i + 1}',
      coverUrl: 'https://picsum.photos/seed/${i + 1}/400/700',
      anchorName: 'Anchor ${i + 1}',
      onlineCount: 100 + i * 10,
      roomType: i % 2 == 0 ? 'mic_room' : 'live_room',
      videoUrl: i % 2 == 0
        ? ''
        : 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    ));
  }
}