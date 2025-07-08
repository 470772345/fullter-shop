import 'package:flutter/material.dart';
import 'package:flutter_application_2/commom/styles/colors.dart';

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // 主内容
          Column(
            children: [
              // 渐变AppBar
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  top: true,
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onPrimary),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            "Hollywood (8)",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(Icons.search, color: Theme.of(context).colorScheme.onPrimary),
                      ],
                    ),
                  ),
                ),
              ),
              // 歌曲列表
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: songs.length,
                  separatorBuilder: (_, __) => Divider(height: 1, color: Theme.of(context).dividerColor),
                  itemBuilder: (context, index) {
                    final song = songs[index];
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          "https://picsum.photos/seed/$index/400/300",
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 48,
                            height: 48,
                            color: Theme.of(context).dividerColor,
                            child: Icon(Icons.broken_image, color: Theme.of(context).textTheme.bodySmall?.color?.withAlpha((0.5 * 255).toInt())),
                          ),
                        ),
                      ),
                      title: Text(song["title"], style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
                      subtitle: Text(song["artist"], style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
                      trailing: selectedIndexes.contains(index)
                          ? Icon(Icons.check, color: AppColors.primary)
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
                  colors: [AppColors.accent, AppColors.liveBlue],
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
                      icon: Icon(Icons.pause, color: Theme.of(context).colorScheme.onPrimary, size: 22),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Starboy - The Weeknd",
                            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 13),
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
                            activeColor: Theme.of(context).colorScheme.onPrimary,
                            inactiveColor: Theme.of(context).colorScheme.onPrimary.withAlpha((0.24 * 255).toInt()),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("2:24", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary.withAlpha((0.7 * 255).toInt()), fontSize: 10, fontWeight: FontWeight.w400)),
                              Text("-1:14", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary.withAlpha((0.7 * 255).toInt()), fontSize: 10, fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.volume_up, color: Theme.of(context).colorScheme.onPrimary, size: 20),
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