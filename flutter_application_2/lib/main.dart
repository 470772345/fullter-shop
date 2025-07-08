import 'package:flutter/material.dart';
import 'package:flutter_application_2/modules/mic_module/mic_page.dart';
import 'package:flutter_application_2/modules/user_module/me_page.dart';
import 'package:flutter_application_2/modules/home_module/home_page.dart';
import 'commom/styles/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live App Demo',
      theme: appTheme,
      home: LiveHomePage(),
    );
  }
}

class LiveHomePage extends StatefulWidget {
  const LiveHomePage({super.key}); // 构造函数加 const
  @override
  State<LiveHomePage> createState() => _LiveHomePageState();
}

class _LiveHomePageState extends State<LiveHomePage> {
  int _bottomIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(),
      Center(child: Text('Live')),
      MicPage(),
      MyPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar 交由各自页面管理，这里不再处理
      body: _pages[_bottomIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        onTap: (i) {
          if (i == 2) { // Mic tab
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => MicPage()),
            );
          } else {
            setState(() => _bottomIndex = i);
          }
        },
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
