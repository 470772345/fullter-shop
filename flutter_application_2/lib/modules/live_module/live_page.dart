import 'package:flutter/material.dart';
import 'package:flutter_application_2/commom/styles/colors.dart';

class LivePage extends StatelessWidget {
  const LivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 播放器区域（实际应为视频播放器，这里用Container占位）
          Positioned.fill(
            child: Container(
              color: Colors.black,
              child: Center(
                child: Icon(Icons.live_tv, color: Colors.white24, size: 120),
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
                    backgroundImage: NetworkImage('https://randomuser.me/api/portraits/women/1.jpg'),
                    radius: 20,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Jeanette King', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(width: 4),
                          Icon(Icons.verified, color: AppColors.liveGold, size: 16),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.remove_red_eye, color: Colors.white70, size: 14),
                          const SizedBox(width: 2),
                          Text('139', style: TextStyle(color: Colors.white70, fontSize: 12)),
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
                          backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/${i+10}.jpg'),
                          radius: 16,
                        ),
                      ),
                    ),
                  ),
                  // 关闭按钮
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDanmu('Support the broadcaster by Opening VIP', Colors.pinkAccent),
                  _buildDanmu('Ramesh joined the LIVE', Colors.amber),
                  _buildDanmu('Ankush joined the LIVE 😊', Colors.blueAccent),
                  _buildDanmu('The broadcaster invites you to join a PK', Colors.purpleAccent),
                  _buildDanmu('Sumit joined the LIVE', Colors.greenAccent),
                ],
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
                color: Colors.black.withOpacity(0.2),
                child: Row(
                  children: [
                    // 输入框占位
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerLeft,
                        child: Text('Say hi...', style: TextStyle(color: Colors.white54)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.card_giftcard, color: Colors.pinkAccent),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite, color: Colors.pinkAccent),
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

  Widget _buildDanmu(String text, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
    );
  }
}
