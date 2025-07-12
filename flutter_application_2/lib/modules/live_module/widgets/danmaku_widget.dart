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
  final double speed; // 全局默认速度（秒）
  final List<double>? trackSpeeds; // 每个轨道的速度（秒）
  const DanmakuView({
    super.key,
    required this.messages,
    this.maxLines = 3,
    this.speed = 6.0,
    this.trackSpeeds,
  });

  @override
  State<DanmakuView> createState() => _DanmakuViewState();
}

class _DanmakuViewState extends State<DanmakuView> {
  late List<List<_DanmakuTrackItem>> tracks;
  Set<String> shownIds = {};
  bool _initialDanmakuShown = false;

  @override
  void initState() {
    super.initState();
    tracks = List.generate(widget.maxLines, (_) => []);
    shownIds = {}; // 让所有初始+新消息都能飞出来
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _appendNewDanmakus(widget.messages, isInitial: true);
      _initialDanmakuShown = true;
    });
  }

  @override
  void didUpdateWidget(covariant DanmakuView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.messages != widget.messages) {
      _appendNewDanmakus(widget.messages, isInitial: !_initialDanmakuShown);
      _initialDanmakuShown = true;
    }
  }

  void _appendNewDanmakus(List<DanmakuMessage> messages, {bool isInitial = false}) {
    final now = DateTime.now();
    final screenWidth = MediaQuery.of(context).size.width;
    final List<DateTime> trackAvailable = List.generate(widget.maxLines, (_) => now);
    final List<double> trackPrevWidth = List.generate(widget.maxLines, (_) => 0.0);

    // 统计每个轨道最后一条弹幕的结束时间和宽度
    for (int t = 0; t < widget.maxLines; t++) {
      if (tracks[t].isNotEmpty) {
        final last = tracks[t].last;
        trackAvailable[t] = last.expectedEndTime;
        final text = last.message.userName + ': ' + last.message.content;
        final style = const TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
        trackPrevWidth[t] = _estimateDanmakuWidth(text, style);
      }
    }

    int initialDelayBase = 0;
    const int initialDelayStep = 300; // 每条初始弹幕多300ms

    for (int i = 0; i < messages.length; i++) {
      final msg = messages[i];
      if (shownIds.contains(msg.id)) continue;
      shownIds.add(msg.id);

      final text = msg.userName + ': ' + msg.content;
      final style = const TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
      final width = _estimateDanmakuWidth(text, style);

      int bestTrack = 0;
      DateTime bestTime = trackAvailable[0];
      for (int t = 1; t < widget.maxLines; t++) {
        if (trackAvailable[t].isBefore(bestTime)) {
          bestTrack = t;
          bestTime = trackAvailable[t];
        }
      }
      final speed = widget.trackSpeeds != null && widget.trackSpeeds!.length > bestTrack
          ? widget.trackSpeeds![bestTrack]
          : widget.speed;
      final prevWidth = trackPrevWidth[bestTrack];
      final speedPxPerMs = (screenWidth + width) / (speed * 1000);
      final safeGap = 24.0;
      final timeToSafe = ((prevWidth + safeGap) / speedPxPerMs).ceil();
      final delayMs = bestTime.isAfter(now) ? bestTime.difference(now).inMilliseconds : 0;
      int totalDelay = delayMs + timeToSafe;
      if (isInitial) {
        totalDelay += initialDelayBase;
        initialDelayBase += initialDelayStep;
      }

      final expectedEndTime = now.add(Duration(milliseconds: totalDelay + (speed * 1000).toInt()));
      tracks[bestTrack].add(_DanmakuTrackItem(
        message: msg,
        delay: Duration(milliseconds: totalDelay),
        duration: Duration(milliseconds: (speed * 1000).toInt()),
        expectedEndTime: expectedEndTime,
      ));
      trackAvailable[bestTrack] = expectedEndTime;
      trackPrevWidth[bestTrack] = width;
    }
    setState(() {});
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
                  key: UniqueKey(),
                  message: item.message,
                  duration: item.duration,
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
  final Duration duration;
  final DateTime expectedEndTime;
  _DanmakuTrackItem({
    required this.message,
    required this.delay,
    required this.duration,
    required this.expectedEndTime,
  });
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
