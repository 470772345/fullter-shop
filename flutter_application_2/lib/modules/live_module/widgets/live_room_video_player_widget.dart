import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LiveRoomVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const LiveRoomVideoPlayer({super.key, required this.videoUrl});

  @override
  State<LiveRoomVideoPlayer> createState() => _LiveRoomVideoPlayerState();
}

class _LiveRoomVideoPlayerState extends State<LiveRoomVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
    ..initialize().then((_) {
      setState(() {
        _isInitialized = true;
      });
      _controller.play();
      _controller.setLooping(true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: _controller.value.size.width,
        height: _controller.value.size.height,
        child: VideoPlayer(_controller),
      ),
    );
  }
}
