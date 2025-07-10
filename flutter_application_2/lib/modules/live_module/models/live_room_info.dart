class LiveRoomInfo {
  final String id;
  final String title;
  final String coverUrl;
  final String anchorName;
  final int onlineCount;
  final String roomType;

  LiveRoomInfo({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.anchorName,
    required this.onlineCount,
    required this.roomType,
  });

  // 可选：fromJson/toJson、copyWith、==/hashCode等
}