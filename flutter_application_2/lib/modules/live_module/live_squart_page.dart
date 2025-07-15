import 'package:flutter/material.dart';
import 'live_mic_page.dart';
import 'live_room_page.dart';
import 'package:flutter_application_2/modules/live_module/models/live_room_info.dart';
import 'package:video_player/video_player.dart';

class LiveSquarePage extends StatefulWidget {
  final List<LiveRoomInfo> liveRooms;

  const LiveSquarePage({super.key, required this.liveRooms});

  @override
  State<LiveSquarePage> createState() => _LiveSquarePageState();
}

class _LiveSquarePageState extends State<LiveSquarePage> {
  final Map<String, VideoPlayerController> _controllers = {};
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    for (var room in widget.liveRooms) {
      if (room.roomType == 'live_room') {
        final controller = VideoPlayerController.networkUrl(Uri.parse(room.videoUrl));
        controller.setVolume(0);
        controller.initialize().then((_) => controller.play());
        _controllers[room.title] = controller; // 用 title 作为唯一 key，建议实际用 roomId
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 返回广场页时恢复当前可见房间的播放
    if (widget.liveRooms.isNotEmpty && _currentIndex < widget.liveRooms.length) {
      final room = widget.liveRooms[_currentIndex];
      final controller = _controllers[room.title];
      controller?.play();
    }
  }

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.liveRooms.length,
      onPageChanged: (index) {
        _currentIndex = index;
        // 预加载下一页图片
        if (index + 1 < widget.liveRooms.length) {
          precacheImage(NetworkImage(widget.liveRooms[index + 1].coverUrl), context);
        }
        // 预加载前一页图片
        if (index - 1 >= 0) {
          precacheImage(NetworkImage(widget.liveRooms[index - 1].coverUrl), context);
        }
      },
      itemBuilder: (context, index) {
        final room = widget.liveRooms[index];
        final controller = _controllers[room.title];
        return LiveRoomPreviewCard(
          key: PageStorageKey(room.title),
          room: room,
          controller: controller,
          onEnterRoom: () {
            if (room.roomType == 'mic_room') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LiveMicRoomPage(
                    title: room.title,
                    coverUrl: room.coverUrl,
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LivePage(
                    title: room.title,
                    coverUrl: room.coverUrl,
                    videoUrl: room.videoUrl,
                    roomType: room.roomType,
                    controller: controller,
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}

class LiveRoomPreviewCard extends StatefulWidget {
  final LiveRoomInfo room;
  final VideoPlayerController? controller;
  final VoidCallback onEnterRoom;

  const LiveRoomPreviewCard({
    Key? key,
    required this.room,
    required this.controller,
    required this.onEnterRoom,
  }) : super(key: key);

  @override
  State<LiveRoomPreviewCard> createState() => _LiveRoomPreviewCardState();
}

class _LiveRoomPreviewCardState extends State<LiveRoomPreviewCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final room = widget.room;
    final controller = widget.controller;
    return Stack(
      fit: StackFit.expand,
      children: [
        room.roomType == 'live_room'
            ? (controller != null && controller.value.isInitialized
                ? VideoPlayer(controller)
                : Center(child: CircularProgressIndicator()))
            : Image.network(room.coverUrl, fit: BoxFit.cover),
        // 半透明遮罩
        Container(color: Colors.black.withOpacity(0.3)),
        // 顶部主播信息
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 38, left: 8, right: 8),
            child: Row(
              children: [
                CircleAvatar(backgroundImage: NetworkImage(room.coverUrl)),
                const SizedBox(width: 8),
                Text(
                  room.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Icon(Icons.remove_red_eye, color: Colors.white70, size: 18),
                const SizedBox(width: 4),
                Text('129', style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ),
        // 底部"进入直播间"按钮
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.85),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 14,
                ),
              ),
              onPressed: widget.onEnterRoom,
              child: const Text(
                '进入直播间',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
