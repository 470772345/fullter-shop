import 'dart:math';
import 'package:flutter/material.dart';

class FloatingHearts extends StatefulWidget {
  const FloatingHearts({Key? key}) : super(key: key);

  @override
  FloatingHeartsState createState() => FloatingHeartsState();
}

class FloatingHeartsState extends State<FloatingHearts> {
  final List<Widget> _hearts = [];

  void addHeart(Offset offset) {
    final key = UniqueKey();
    _hearts.add(
      _AnimatedHeart(
        key: key,
        startX: offset.dx,
        startY: offset.dy,
        onEnd: () {
          setState(() {
            _hearts.removeWhere((h) => (h.key == key));
          });
        },
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: _hearts);
  }
}

class _AnimatedHeart extends StatefulWidget {
  final double startX, startY;
  final VoidCallback onEnd;
  const _AnimatedHeart({
    Key? key,
    required this.startX,
    required this.startY,
    required this.onEnd,
  }) : super(key: key);

  @override
  State<_AnimatedHeart> createState() => _AnimatedHeartState();
}

class _AnimatedHeartState extends State<_AnimatedHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double dx, dy, endX, endY, scale, angle;

  @override
  void initState() {
    super.initState();
    final random = Random();
    dx = widget.startX;
    dy = widget.startY;
    endX = dx + random.nextDouble() * 60 * (random.nextBool() ? 1 : -1);
    endY = dy - 180 - random.nextDouble() * 40;
    scale = 0.8 + random.nextDouble() * 0.6;
    angle = (random.nextDouble() - 0.5) * 0.6;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) widget.onEnd();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        final t = _animation.value;
        // 贝塞尔曲线
        final x = dx + (endX - dx) * t;
        final y = dy + (endY - dy) * t;
        final opacity = 1.0 - t;
        final s = scale + 0.2 * t;

        return Positioned(
          left: x,
          top: y,
          child: Opacity(
            opacity: opacity,
            child: Transform.rotate(
              angle: angle * t,
              child: Transform.scale(
                scale: s,
                child: Icon(
                  Icons.favorite,
                  color:  Theme.of(context).primaryColor,
                  size: 36,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
