class ChatMessage {
  final String user;
  final String content;

  ChatMessage(this.user, this.content);

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      ChatMessage(json['user'] as String, json['content'] as String);

  Map<String, dynamic> toJson() => {
        'user': user,
        'content': content,
      };

  static List<ChatMessage> mockList([int count = 5]) {
    final users = ['小明', '小红', '小刚', '小美', '游客'];
    final contents = [
      '欢迎来到直播间！',
      '主播好帅！',
      '送出火箭',
      '关注主播不迷路',
      '来了来了',
    ];
    return List.generate(
      count,
      (i) => ChatMessage(users[i % users.length], contents[i % contents.length]),
    );
  }
}