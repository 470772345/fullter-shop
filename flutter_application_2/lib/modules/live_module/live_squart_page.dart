import 'package:flutter/material.dart';
import 'live_mic_page.dart';
import 'live_room_page.dart';
import 'package:flutter_application_2/modules/live_module/models/live_room_info.dart';



class LiveSquarePage extends StatelessWidget {
  final List<LiveRoomInfo> liveRooms;

  const LiveSquarePage({super.key, required this.liveRooms});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: liveRooms.length,
      onPageChanged: (index) {
        // 预加载下一页图片
        if (index + 1 < liveRooms.length) {
          precacheImage(NetworkImage(liveRooms[index + 1].coverUrl), context);
        }
        // 预加载前一页图片
        if (index - 1 >= 0) {
          precacheImage(NetworkImage(liveRooms[index - 1].coverUrl), context);
        }
      },
      itemBuilder: (context, index) {
        final room = liveRooms[index];
        return Stack(
          fit: StackFit.expand,
          children: [
            // 封面大图
            Image.network(room.coverUrl, fit: BoxFit.cover),
            // 半透明遮罩
            Container(color: Colors.black.withOpacity(0.3)),
            // 顶部主播信息
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage(room.coverUrl)),
                    const SizedBox(width: 8),
                    Text(room.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 14),
                  ),
                  child: const Text('进入直播间', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  onPressed: () {
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
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}