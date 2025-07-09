import 'package:flutter/material.dart';
import 'package:flutter_application_2/commom/styles/colors.dart';
import 'package:flutter_application_2/modules/live_module/widgets/danmaku_widget.dart';

class LivePage extends StatelessWidget {
  const LivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // 播放器区域（实际应为视频播放器，这里用Container占位）
          Positioned.fill(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: Icon(Icons.live_tv, color: Theme.of(context).dividerColor.withAlpha((0.24 * 255).toInt()), size: 120),
              ),
            ),
          ),
          // 顶部信息栏
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 主播头像+昵称
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://picsum.photos/seed/host/400/300'),
                    radius: 20,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Jeanette King', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(width: 4),
                          Icon(Icons.verified, color: AppColors.liveGold, size: 16),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.remove_red_eye, color: Theme.of(context).textTheme.bodyMedium?.color?.withAlpha((0.7 * 255).toInt()), size: 14),
                          const SizedBox(width: 2),
                          Text('139', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withAlpha((0.7 * 255).toInt()), fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  // 观众头像横排
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        separatorBuilder: (_, __) => SizedBox(width: -10),
                        itemBuilder: (context, i) => CircleAvatar(
                          backgroundImage: NetworkImage('https://picsum.photos/seed/$i/400/300'),
                          radius: 16,
                        ),
                      ),
                    ),
                  ),
                  // 关闭按钮
                  IconButton(
                    icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
          // 底部弹幕区
          Positioned(
            left: 0,
            right: 0,
            bottom: 90,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: DanmakuView(
                messages: [
                  DanmakuMessage(id: '1', userName: '小明', content: '主播好帅！'),
                  DanmakuMessage(id: '2', userName: '小红', content: '666666'),
                  DanmakuMessage(id: '3', userName: '小刚', content: '送出火箭'),
                  DanmakuMessage(id: '4', userName: '小美', content: '来了来了'),
                  DanmakuMessage(id: '5', userName: '小王', content: '关注主播不迷路'),
                ],
                maxLines: 3,
                speed: 6.0,
              ),
            ),
          ),
          // 底部操作栏
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                color: Theme.of(context).scaffoldBackgroundColor.withAlpha((0.2 * 255).toInt()),
                child: Row(
                  children: [
                    // 输入框占位
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).dividerColor.withAlpha((0.08 * 255).toInt()),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerLeft,
                        child: Text('Say hi...', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withAlpha((0.5 * 255).toInt()))),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.card_giftcard, color: AppColors.primary),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.onPrimary),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite, color: AppColors.primary),
                      onPressed: () {},
                    ),
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
