import 'package:flutter/material.dart';

class LiveDetailPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  const LiveDetailPage({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              radius: 16,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16)),
                Row(
                  children: const [
                    Icon(Icons.remove_red_eye, size: 14, color: Colors.white70),
                    SizedBox(width: 2),
                    Text('129', style: TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        ],
      ),
      body: Stack(
        children: [
          // 背景模糊大图
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.5),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          // 内容
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 8),
                // 公告栏
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
                  child: Row(
                    children: const [
                      Icon(Icons.campaign, color: Colors.white, size: 18),
                      SizedBox(width: 6),
                      Text('Eid Mubarak ', style: TextStyle(color: Colors.white, fontSize: 14)),
                      Icon(Icons.favorite, color: Colors.red, size: 14),
                    ],
                  ),
                ),
                // 9宫格座位
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1,
                      ),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // 占位头像
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Text('YL', style: TextStyle(color: Colors.black)),
                                radius: 24,
                              ),
                              const SizedBox(height: 4),
                              const Icon(Icons.monetization_on, color: Colors.amber, size: 16),
                            ],
                          );
                        } else if (index == 1) {
                          // 有头像
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage('https://randomuser.me/api/portraits/women/2.jpg'),
                                radius: 24,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.monetization_on, color: Colors.amber, size: 16),
                                  SizedBox(width: 2),
                                  Text('2', style: TextStyle(color: Colors.white, fontSize: 12)),
                                ],
                              ),
                            ],
                          );
                        } else {
                          // 加号
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0.2),
                                child: const Icon(Icons.add, color: Colors.white),
                                radius: 24,
                              ),
                              const SizedBox(height: 4),
                              Text('${index + 1}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
                // 底部操作栏
                Padding(
                  padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16, top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.grid_view, color: Colors.white, size: 28),
                          SizedBox(width: 16),
                          Icon(Icons.card_giftcard, color: Colors.white, size: 28),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Icons.favorite, color: Colors.pink, size: 32),
                          SizedBox(width: 16),
                          CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(Icons.call_end, color: Colors.white),
                            radius: 24,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}