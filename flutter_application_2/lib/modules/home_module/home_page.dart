import 'package:flutter/material.dart';
import 'package:flutter_application_2/modules/live_module/live_detail_page.dart';
import 'package:flutter_application_2/commom/styles/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabs = const [
    'NEARBY',
    'POPULAR',
    'MULTI GUEST',
    'PK',
    'SUPER STAR',
  ];
  final List<String> subTabs = const [
    'All',
    'Education Guest',
    'Game',
    'Fun Entertainment',
    'Super Star',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Theme.of(context).colorScheme.onPrimary,
          unselectedLabelColor: Theme.of(context).colorScheme.onPrimary.withAlpha((0.7 * 255).toInt()),
          indicatorColor: Theme.of(context).colorScheme.onPrimary,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
        backgroundColor: AppColors.primary,
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Column(
        children: [
          // 二级Tab
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: subTabs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Chip(
                    label: Text(subTabs[index]),
                    backgroundColor: index == 0
                        ? AppColors.primary.withAlpha((0.15 * 255).toInt())
                        : Theme.of(context).dividerColor,
                  ),
                );
              },
            ),
          ),
          // 卡片瀑布流
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: 16,
              itemBuilder: (context, index) {
                final imageUrl = 'https://picsum.photos/seed/$index/400/300';
                final title = index % 2 == 0 ? 'Lets Join' : 'Bring music to Live';
                final tag = index % 2 == 0 ? 'Super Star' : 'LIVE HOUSE';
                if (tag == 'LIVE HOUSE') {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LiveDetailPage(
                            title: title,
                            imageUrl: imageUrl,
                          ),
                        ),
                      );
                    },
                    child: LiveCard(
                      imageUrl: imageUrl,
                      title: title,
                      tag: tag,
                      viewers: 384,
                    ),
                  );
                } else {
                  return LiveCard(
                    imageUrl: imageUrl,
                    title: title,
                    tag: tag,
                    viewers: 384,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LiveCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String tag;
  final int viewers;
  const LiveCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.tag,
    required this.viewers,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // 背景图片
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(color: Theme.of(context).dividerColor),
            ),
          ),
          // 顶部标签
          Positioned(
            left: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: tag == 'Super Star' ? AppColors.primary : AppColors.accent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                tag,
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 12),
              ),
            ),
          ),
          // 右上角观众数
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$viewers',
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 12),
              ),
            ),
          ),
          // 底部标题
          Positioned(
            left: 8,
            bottom: 8,
            child: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
