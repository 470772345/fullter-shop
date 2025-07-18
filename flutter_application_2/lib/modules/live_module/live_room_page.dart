import 'package:flutter/material.dart';
import 'package:flutter_application_2/commom/styles/colors.dart';
import 'package:flutter_application_2/modules/live_module/widgets/danmaku_widget.dart';
import 'package:flutter_application_2/modules/live_module/widgets/floarting_hearts_widget.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter_application_2/modules/live_module/widgets/live_chat_area_widget.dart';
import 'package:flutter_application_2/modules/live_module/models/chat_message.dart';
import 'package:flutter_application_2/modules/live_module/widgets/live_chat_input_widget.dart';
import 'package:flutter_application_2/modules/live_module/widgets/gift_panel_widget.dart';
import 'package:flutter_application_2/modules/live_module/models/gift_item.dart';
import 'package:lottie/lottie.dart';

class LivePage extends StatefulWidget {
  final String? title;
  final String? coverUrl;
  final String? videoUrl;
  final String? roomType;
  final VideoPlayerController? controller;
  const LivePage({
    super.key,
    this.title,
    this.coverUrl,
    this.videoUrl,
    this.roomType,
    this.controller,
  });

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  final GlobalKey<FloatingHeartsState> _heartsKey =
      GlobalKey<FloatingHeartsState>();
  final GlobalKey _likeBtnKey = GlobalKey();
  VideoPlayerController? _controller;

  // 聊天消息列表
  final List<ChatMessage> chatMessages = ChatMessage.mockList(15);
  final ScrollController _chatScrollController = ScrollController();

  // 弹幕消息列表
  List<DanmakuMessage> danmakuMessages = [
    DanmakuMessage(id: '1', userName: 'Lee', content: '主播好帅！'),
    DanmakuMessage(id: '2', userName: 'Bruce4code', content: '666666666666666'),
    DanmakuMessage(id: '3', userName: 'Bruce', content: '送出火箭'),
    DanmakuMessage(id: '4', userName: 'Tao', content: '来了来了'),
    DanmakuMessage(id: '5', userName: 'Mac', content: '关注主播不迷路'),
  ];
  int _danmakuId = 6;
  Timer? _danmakuTimer;
  final List<String> _demoUsers = [
    '小明',
    '小红',
    '小刚',
    '小美',
    '游客',
    'Bruce',
    'Lee',
    'Tao',
    'Mac',
  ];
  final List<String> _demoContents = [
    '来了来了',
    '主播666',
    '关注主播不迷路',
    '送出火箭',
    '弹幕走起',
    '哈哈哈',
    '点赞了',
    '太精彩了',
    '求翻牌',
    '加油',
    '好听',
    '互动一下',
  ];

  void addChatMessage(ChatMessage msg) {
    setState(() {
      chatMessages.add(msg);
    });
    // 动画滚动到底部
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_chatScrollController.hasClients) {
        _chatScrollController.animateTo(
          _chatScrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void addDanmaku(String user, String content) {
    // print('addDanmaku: $user $content');
    setState(() {
      danmakuMessages.add(
        DanmakuMessage(
          id: (_danmakuId++).toString(),
          userName: user,
          content: content,
        ),
      );
      if (danmakuMessages.length > 50) {
        danmakuMessages.removeAt(0);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.roomType != 'mic_room') {
      if (widget.controller != null) {
        _controller = widget.controller;
      } else {
        _controller = VideoPlayerController.networkUrl(
          Uri.parse(
            widget.videoUrl ??
                'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
          ),
        )
        ..initialize().then((_) {
          setState(() {});
          _controller?.play();
        });
      }
    }
    // 自动弹幕流
    _danmakuTimer = Timer.periodic(Duration(seconds: 20), (_) {
      final rand = Random();
      final user = _demoUsers[rand.nextInt(_demoUsers.length)];
      final content = _demoContents[rand.nextInt(_demoContents.length)];
      addDanmaku(user, content);
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller?.dispose();
    }
    _chatScrollController.dispose();
    _danmakuTimer?.cancel();
    super.dispose();
  }

  // Lottie 礼物动画
  void showGiftAnimation(GiftItem gift) {
    String lottieAsset;
    if (gift.name == '鱼跃') {
      lottieAsset = 'lottie/fish.json';
    } else if (gift.name == '飞天娃') {
      lottieAsset = 'lottie/flying_man.json';
    } else {
      // 默认动画或直接 return
      return;
    }
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Center(
        child: Lottie.asset(
          lottieAsset,
          width: 200,
          height: 200,
          repeat: false,
          onLoaded: (composition) {
            Future.delayed(composition.duration, () {
              entry.remove();
            });
          },
        ),
      ),
    );
    overlay.insert(entry);
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            // 播放器区域
            Positioned.fill(
              child: widget.roomType == 'mic_room'
                  ? Center(
                      child: Text(
                        'WebRTC/连麦房占位（flutter_webrtc集成）',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  : (_controller != null)
                  ? (_controller!.value.hasError)
                        ? Center(
                            child: Text(
                              '视频加载失败: ${_controller!.value.errorDescription}',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : (_controller!.value.isInitialized)
                        ? AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: VideoPlayer(_controller!),
                          )
                        : Center(child: CircularProgressIndicator())
                  : Center(child: CircularProgressIndicator()),
            ),
            // 顶部信息栏
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 主播头像+昵称
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://picsum.photos/seed/host/400/300',
                      ),
                      radius: 20,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Jeanette King',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.verified,
                              color: AppColors.liveGold,
                              size: 16,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.remove_red_eye,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color
                                  ?.withAlpha((0.7 * 255).toInt()),
                              size: 14,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '139',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color
                                    ?.withAlpha((0.7 * 255).toInt()),
                                fontSize: 12,
                              ),
                            ),
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
                          separatorBuilder: (_, __) => SizedBox(width: 10),
                          itemBuilder: (context, i) => CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://picsum.photos/seed/$i/48/48',
                            ),
                            radius: 16,
                          ),
                        ),
                      ),
                    ),
                    // 关闭按钮
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),
            // 弹幕区，放在聊天消息区域上方
            Positioned(
              left: 0,
              right: 0,
              bottom: 90 + 4 * 36, // 聊天消息区高度+间距
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: DanmakuView(
                  messages: danmakuMessages,
                  maxLines: 2, // 2个弹幕轨道
                  trackSpeeds: [4.0, 6.0],
                ),
              ),
            ),
            // 聊天消息区域，放在输入框上方
            Positioned(
              left: 12,
              right: 12,
              bottom: 90, // 输入框高度+间距
              child: LiveChatArea(
                messages: chatMessages,
                controller: _chatScrollController,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                top: false,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  color: Theme.of(
                    context,
                  ).scaffoldBackgroundColor.withAlpha((0.2 * 255).toInt()),
                  child: Row(
                    children: [
                      // 输入框占位
                      Expanded(
                        child: LiveChatInput(
                          onSend: (text) {
                            addChatMessage(ChatMessage('我', text));
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Icon(
                          Icons.card_giftcard,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => GiftPanel(
                              gifts: GiftItem.mockList(),
                              onSend: (gift) {
                                Navigator.pop(context); // 关闭面板
                                showGiftAnimation(gift);    // 根据礼物名播放动画
                                // 可弹toast/动画等其他赠送逻辑
                              },
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        key: _likeBtnKey,
                        icon: Icon(
                          Icons.favorite,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            final RenderBox? btnBox =
                                _likeBtnKey.currentContext?.findRenderObject()
                                    as RenderBox?;
                            final RenderBox? stackBox =
                                context.findRenderObject() as RenderBox?;
                            if (btnBox != null && stackBox != null) {
                              final btnOffset = btnBox.localToGlobal(
                                btnBox.size.center(Offset.zero),
                              );
                              final stackOffset = stackBox.globalToLocal(
                                btnOffset,
                              );
                              print(stackOffset);
                              final adjustedOffset = stackOffset.translate(
                                -14,
                                -20,
                              );
                              _heartsKey.currentState?.addHeart(adjustedOffset);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // 飘心动画层，放在Stack最上层
            Positioned.fill(child: FloatingHearts(key: _heartsKey)),
          ],
        ),
      );
    } catch (e, stack) {
      print('LivePage build error: $e\n$stack');
      return Scaffold(
        body: Center(
          child: Text(
            'LivePage build error:\n\n${e.toString()}',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }
}
