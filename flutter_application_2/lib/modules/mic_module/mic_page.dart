import 'package:flutter/material.dart';

class MicPage extends StatefulWidget {
  const MicPage({super.key});
  @override
  MicPageState createState() => MicPageState();
}

class MicPageState extends State<MicPage> {
  
  // 示例歌曲数据
  final List<Map<String, dynamic>> songs = [
    {"title": "Starboy", "artist": "Starboy - The Weeknd"},
    {"title": "Party Monster", "artist": "Starboy - The Weeknd"},
    {"title": "False Alarm", "artist": "Starboy - The Weeknd"},
    {"title": "Reminder", "artist": "Starboy - The Weeknd"},
    {"title": "Secrets", "artist": "Starboy - The Weeknd"},
    {"title": "Sidewalks", "artist": "Starboy - The Weeknd"},
    {"title": "A Lonely Night", "artist": "Starboy - The Weeknd"},
    {"title": "Attention", "artist": "Starboy - The Weeknd"},
    {"title": "I Feel It coming", "artist": "Starboy - The Weeknd"},
  ];

  // 选中的歌曲索引
  final Set<int> selectedIndexes = {0, 1, 3};

  static const double kBottomNavBarHeight = 70.0; // Flutter默认BottomNavigationBar高度
  static const double kPlayerHeight = 100.0;
  double _sliderValue = 2.24; 

  @override
  Widget build(BuildContext context) {

    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 主内容
          Column(
            children: [
              // 渐变AppBar
              SafeArea(
                top: true,
                bottom: false,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFEA5C8B), Color(0xFFF9A14A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          "Hollywood (8)",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(Icons.search, color: Colors.white),
                    ],
                  ),
                ),
              ),
              // 歌曲列表
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: songs.length,
                  separatorBuilder: (_, __) => Divider(height: 1),
                  itemBuilder: (context, index) {
                    final song = songs[index];
                    return ListTile(
                      leading: Image.network(
                        "https://upload.wikimedia.org/wikipedia/en/9/9b/The_Weeknd_-_Starboy.png",
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 48,
                          height: 48,
                          color: Colors.grey[200],
                          child: Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                      title: Text(song["title"], style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(song["artist"], style: TextStyle(color: Colors.grey)),
                      trailing: selectedIndexes.contains(index)
                          ? Icon(Icons.check, color: Color(0xFFEA5C8B))
                          : null,
                      onTap: () {
                        setState(() {
                          if (selectedIndexes.contains(index)) {
                            selectedIndexes.remove(index);
                          } else {
                            selectedIndexes.add(index);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          // 悬浮底部播放器
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: kPlayerHeight + bottomPadding,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                top: false,
                left: false,
                right: false,
                bottom: true,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.pause, color: Colors.white, size: 22),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Starboy - The Weeknd",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Slider(
                            value: _sliderValue,
                            min: 0,
                            max: 3.38,
                            onChanged: (v) {
                              setState(() {
                                _sliderValue = v;
                              });
                            },
                            activeColor: Colors.white,
                            inactiveColor: Colors.white24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("2:24", style: TextStyle(color: Colors.white70, fontSize: 10)),
                              Text("-1:14", style: TextStyle(color: Colors.white70, fontSize: 10)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.volume_up, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}