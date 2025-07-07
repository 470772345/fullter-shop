import 'package:flutter/material.dart';
import 'package:flutter_application_2/modules/user_module/me_page.dart';
import 'package:flutter_application_2/modules/home_module/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live App Demo',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: LiveHomePage(),
    );
  }
}

class LiveHomePage extends StatefulWidget {
  const LiveHomePage({super.key}); // 构造函数加 const
  @override
  State<LiveHomePage> createState() => _LiveHomePageState();
}

class _LiveHomePageState extends State<LiveHomePage>
    with SingleTickerProviderStateMixin {
  int _bottomIndex = 0;
  late TabController _tabController;
  late List<Widget> _pages;

  final List<String> tabs = [
    'NEARBY',
    'POPULAR',
    'MULTI GUEST',
    'PK',
    'SUPER STAR',
  ];
  final List<String> subTabs = [
    'All',
    'Education Guest',
    'Game',
    'Fun Entertainment',
    'Super Star',
  ];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: 1,
    );
    _pages = [
      // 首页内容
      HomePage(), 
      // 其他tab可用占位Widget
      Center(child: Text('Live')), // 第二个tab
      Center(child: Text('Mic')),  // 第三个tab
      MyPage(),                   // 第四个tab：Me
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _bottomIndex == 0
          ? AppBar(
              title: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.white,
                tabs: tabs.map((e) => Tab(text: e)).toList(),
              ),
              backgroundColor: Colors.pink,
              actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
            )
          : null,
      body: _pages[_bottomIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        onTap: (i) => setState(() => _bottomIndex = i),
        selectedItemColor: Colors.pink,
        unselectedItemColor: const Color.fromARGB(255, 229, 226, 217),
        unselectedLabelStyle: const TextStyle(
          color: Color.fromARGB(255, 229, 226, 217),
          fontSize: 12,
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'Live'),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Mic'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
        ],
      ),
    );
  }
}
