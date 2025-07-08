import 'package:flutter/material.dart';
import 'package:flutter_application_2/commom/styles/colors.dart';

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
                Text(title, style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary)),
                Row(
                  children: [
                    Icon(Icons.remove_red_eye, size: 14, color: Theme.of(context).colorScheme.onPrimary),
                    SizedBox(width: 2),
                    Text('129', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onPrimary)),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        ],
      ),
      body: Stack(
        children: [
          // 背景模糊大图
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              color: AppColors.mask,
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
                    children: [
                      Icon(Icons.campaign, color: Theme.of(context).colorScheme.onPrimary, size: 18),
                      SizedBox(width: 6),
                      Text('Eid Mubarak ', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 14)),
                      Icon(Icons.favorite, color: AppColors.liveRed, size: 14),
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
                                backgroundColor: AppColors.card,
                                radius: 24,
                                child: Text('YL', style: TextStyle(color: AppColors.textPrimary)),
                              ),
                              SizedBox(height: 4),
                              Icon(Icons.monetization_on, color: AppColors.liveGold, size: 16),
                            ],
                          );
                        } else if (index == 1) {
                          // 有头像
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage('https://randomuser.me/api/portraits/women/2.jpg'),
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.monetization_on, color: AppColors.liveGold, size: 16),
                                  SizedBox(width: 2),
                                  Text('2', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 12)),
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
                                backgroundColor: AppColors.card.withAlpha((0.2 * 255).toInt()),
                                radius: 24,
                                child: Icon(Icons.add, color: AppColors.textPrimary),
                              ),
                              SizedBox(height: 4),
                              Text('${index + 1}', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary.withAlpha((0.7 * 255).toInt()), fontSize: 12)),
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
                        children: [
                          Icon(Icons.grid_view, color: Theme.of(context).colorScheme.onPrimary, size: 28),
                          SizedBox(width: 16),
                          Icon(Icons.card_giftcard, color: Theme.of(context).colorScheme.onPrimary, size: 28),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.favorite, color: AppColors.primary, size: 32),
                          SizedBox(width: 16),
                          CircleAvatar(
                            backgroundColor: AppColors.liveRed,
                            radius: 24,
                            child: Icon(Icons.call_end, color: Theme.of(context).colorScheme.onPrimary),
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