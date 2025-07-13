class GiftItem {
  final String id;
  final String name;
  final String imageUrl;
  final int price;
  final String? tag; // 如“奇遇”“新主播”等

  GiftItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.tag,
  });

  factory GiftItem.fromJson(Map<String, dynamic> json) => GiftItem(
    id: json['id'],
    name: json['name'],
    imageUrl: json['imageUrl'],
    price: json['price'],
    tag: json['tag'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
    'price': price,
    'tag': tag,
  };

  static List<GiftItem> mockList() => [
    GiftItem(id: '1', name: '鱼跃', imageUrl: 'images/gift_001.png', price: 1),
    GiftItem(id: '2', name: '飞天娃', imageUrl: 'images/gift_002.png', price: 1, tag: '人气榜'),
    GiftItem(id: '3', name: '鱼跃', imageUrl: 'images/gift_001.png', price: 50, tag: '新主播'),
    GiftItem(id: '4', name: '飞天娃', imageUrl: 'images/gift_001.png', price: 299, tag: '奇遇'),
    // ... 其它礼物
  ];
}