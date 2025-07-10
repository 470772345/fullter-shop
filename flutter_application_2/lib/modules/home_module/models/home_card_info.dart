class HomeCardInfo {
  final String id;
  final String title;
  final String coverUrl;
  final String tag;
  final int viewers;
  final String roomType;

  HomeCardInfo({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.tag,
    required this.viewers,
    required this.roomType,
  });

  factory HomeCardInfo.fromJson(Map<String, dynamic> json) => HomeCardInfo(
        id: json['id'] as String,
        title: json['title'] as String,
        coverUrl: json['coverUrl'] as String,
        tag: json['tag'] as String,
        viewers: json['viewers'] as int,
        roomType: json['roomType'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'coverUrl': coverUrl,
        'tag': tag,
        'viewers': viewers,
        'roomType': roomType,
      };

  static List<HomeCardInfo> mockList([int count = 16]) {
    return List.generate(count, (i) => HomeCardInfo(
      id: '${i + 1}',
      title: i % 2 == 0 ? 'Lets Join' : 'Bring music to Live',
      coverUrl: 'https://picsum.photos/seed/${i + 1}/400/300',
      tag: i % 2 == 0 ? 'Mic Room' : 'Live Room',
      viewers: 384 + i * 3,
      roomType: i % 2 == 0 ? 'mic_room' : 'live_room',
    ));
  }
} 