import 'package:flutter/material.dart';

class DanmakuMessage {
  final String id;
  final String userName;
  final String content;
  DanmakuMessage({
    required this.id,
    required this.userName,
    required this.content,
  });
}

class DanmakuView extends StatefulWidget {
  final List<DanmakuMessage> messages;
  final int maxLines;
  final double speed; // 单位：秒
  const DanmakuView({
    super.key,
    required this.messages,
    this.maxLines = 3,
    this.speed = 6.0,
  });

  @override
  State<DanmakuView> createState() => _DanmakuViewState();
}

class _DanmakuViewState extends State<DanmakuView> {
  late List<List<_DanmakuTrackItem>> tracks;

  @override
  void initState() {
    super.initState();
    _assignTracks();
  }

  @override
  void didUpdateWidget(covariant DanmakuView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.messages != widget.messages) {
      _assignTracks();
    }
  }

  void _assignTracks() {
    // 智能轨道分配：每个轨道维护下次可用时间和上一个弹幕宽度
    tracks = List.generate(widget.maxLines, (_) => []);
    final List<DateTime> trackAvailable = List.generate(widget.maxLines, (_) => DateTime(0));
    final List<double> trackPrevWidth = List.generate(widget.maxLines, (_) => 0.0);
    final now = DateTime.now();
    final screenWidth = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width / WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    for (int i = 0; i < widget.messages.length; i++) {
      // 预估弹幕宽度
      final text = widget.messages[i].userName + ': ' + widget.messages[i].content;
      final style = const TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
      final width = _estimateDanmakuWidth(text, style);
      // 找到最早可用的轨道
      int bestTrack = 0;
      DateTime bestTime = trackAvailable[0];
      for (int t = 1; t < widget.maxLines; t++) {
        if (trackAvailable[t].isBefore(bestTime)) {
          bestTrack = t;
          bestTime = trackAvailable[t];
        }
      }
      // 计算 delay，确保前一条弹幕尾部离开屏幕
      final prevWidth = trackPrevWidth[bestTrack];
      final speedPxPerMs = (screenWidth + width) / (widget.speed * 1000);
      final safeGap = 24.0; // px
      final timeToSafe = ((prevWidth + safeGap) / speedPxPerMs).ceil(); // ms
      final delayMs = bestTime.isAfter(now) ? bestTime.difference(now).inMilliseconds : 0;
      final totalDelay = delayMs + timeToSafe;
      tracks[bestTrack].add(_DanmakuTrackItem(
        message: widget.messages[i],
        delay: Duration(milliseconds: totalDelay),
      ));
      // 更新轨道下次可用时间和宽度
      trackAvailable[bestTrack] = now.add(Duration(milliseconds: totalDelay));
      trackPrevWidth[bestTrack] = width;
    }
  }

  double _estimateDanmakuWidth(String text, TextStyle style) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return tp.width;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(widget.maxLines, (trackIndex) {
        final track = tracks[trackIndex];
        return Padding(
          padding: EdgeInsets.only(top: trackIndex * 36.0),
          child: SizedBox(
            height: 36,
            child: Stack(
              children: List.generate(track.length, (msgIndex) {
                final item = track[msgIndex];
                return _AnimatedDanmakuItem(
                  key: ValueKey(item.message.id),
                  message: item.message,
                  duration: Duration(seconds: widget.speed.toInt()),
                  delay: item.delay,
                );
              }),
            ),
          ),
        );
      }),
    );
  }
}

class _DanmakuTrackItem {
  final DanmakuMessage message;
  final Duration delay;
  _DanmakuTrackItem({required this.message, required this.delay});
}

class _AnimatedDanmakuItem extends StatefulWidget {
  final DanmakuMessage message;
  final Duration duration;
  final Duration delay;
  const _AnimatedDanmakuItem({
    Key? key,
    required this.message,
    required this.duration,
    required this.delay,
  }) : super(key: key);

  @override
  State<_AnimatedDanmakuItem> createState() => _AnimatedDanmakuItemState();
}

class _AnimatedDanmakuItemState extends State<_AnimatedDanmakuItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(
      begin: 1.0,
      end: -0.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() => _visible = true);
        _controller.forward();
      }
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) setState(() => _visible = false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) return SizedBox.shrink();
    final width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value * width, 0),
          child: child,
        );
      },
      child: _DanmakuBubble(message: widget.message),
    );
  }
}

class _DanmakuBubble extends StatelessWidget {
  final DanmakuMessage message;
  const _DanmakuBubble({required this.message});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message.userName + ': ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: [Color(0xFFFF4081), Color(0xFFFF0066)],
                ).createShader(Rect.fromLTWH(0, 0, 60, 20)),
            ),
          ),
          Text(message.content, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
