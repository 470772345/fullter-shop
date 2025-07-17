import 'package:flutter/material.dart';
import 'package:flutter_application_2/modules/mic_module/mic_page.dart';
import 'package:flutter_application_2/modules/user_module/me_page.dart';
import 'package:flutter_application_2/modules/home_module/home_page.dart';
import 'package:flutter_application_2/modules/live_module/live_squart_page.dart';
import 'package:flutter_application_2/modules/live_module/live_room_page.dart';
import 'package:flutter_application_2/modules/notification_module/notifications_page.dart';
import 'package:flutter_application_2/widgets/custom_bottom_navigation_bar.dart';

import 'commom/styles/theme.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_2/modules/live_module/models/live_room_info.dart';

void main() => runApp(
  ChangeNotifierProvider(create: (_) => ThemeProvider(), child: const MyApp()),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Live App Demo',
      theme: appTheme,
      darkTheme: appDarkTheme,
      themeMode: themeProvider.themeMode,
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
  late List<LiveRoomInfo> liveRooms = [];
  List<Widget>? _pages;

  Future<List<LiveRoomInfo>> fetchMockLiveRooms() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return LiveRoomInfo.mockList(8); // 直接用 model 的 mockList
  }

  @override
  void initState() {
    super.initState();
    fetchMockLiveRooms().then((rooms) {
      setState(() {
        liveRooms = rooms;
        _pages = [
          HomePage(), 
          LiveSquarePage(liveRooms: liveRooms), 
          // 不再需要占位页面，我们会在构建时处理索引映射
          const NotificationsPage(), 
          MyPage()
        ];
      });
    });
  }
  
  void _showCreateOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCreateOption(
              icon: Icons.videocam,
              label: '开始直播',
              onTap: () {
                Navigator.pop(context);
                _startLiveStream();
              },
            ),
            const SizedBox(height: 20),
            _buildCreateOption(
              icon: Icons.mic,
              label: '语音直播',
              onTap: () {
                Navigator.pop(context);
                _startVoiceLive();
              },
            ),
            const SizedBox(height: 20),
            _buildCreateOption(
              icon: Icons.upload,
              label: '上传视频',
              onTap: () {
                Navigator.pop(context);
                _uploadVideo();
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.pink.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.pink),
          ),
          const SizedBox(width: 15),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _startLiveStream() {
    // 实现开始直播的逻辑
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LivePage(
          title: '我的直播',
          roomType: 'live_room',
        ),
      ),
    );
  }

  void _startVoiceLive() {
    // 实现语音直播的逻辑
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LivePage(
          title: '我的语音直播',
          roomType: 'mic_room',
        ),
      ),
    );
  }

  void _uploadVideo() {
    // 实现上传视频的逻辑
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('视频上传功能即将上线')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_pages == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    // 计算正确的页面索引
    // 导航栏索引: 0(首页), 1(直播), 2(创建按钮), 3(消息), 4(我的)
    // 页面数组索引: 0(首页), 1(直播), 2(消息), 3(我的)
    int pageIndex;
    
    switch (_bottomIndex) {
      case 0: // 首页
        pageIndex = 0;
        break;
      case 1: // 直播
        pageIndex = 1;
        break;
      case 3: // 消息
        pageIndex = 2;
        break;
      case 4: // 我的
        pageIndex = 3;
        break;
      default: // 创建按钮或其他情况，显示首页
        pageIndex = 0;
    }
    
    return Scaffold(
      // AppBar 交由各自页面管理
      body: _pages![pageIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _bottomIndex,
        onTap: (index) {
          // 如果点击的是中间按钮(索引2)，不改变当前页面
          if (index != 2) {
            setState(() {
              _bottomIndex = index;
            });
          }
        },
        onCreateTap: _showCreateOptions,
      ),
    );
  }
}
