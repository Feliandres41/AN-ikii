import 'package:flutter/material.dart';

class IconoSplash extends StatefulWidget {
  const IconoSplash({super.key, this.size = 220, this.useGif = false});

  final double size;
  final bool useGif;

  @override
  State<IconoSplash> createState() => _IconoSplashState();
}

class _IconoSplashState extends State<IconoSplash>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      // label: 'SENA',
      image: true,
      child: SizedBox.square(
        dimension: widget.size,
        child: widget.useGif
            ? Image.asset(
                'assets/sena_splash.gif',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    _buildCodeFallback(),
              )
            : _buildCodeFallback(),
      ),
    );
  }

  Widget _buildCodeFallback() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _SenaSplashPainter(progress: _controller.value),
          child: child,
        );
      },
      child: Center(
        // child:
        // Text(
        //   'SENA',
        //   style: TextStyle(
        //     color: Colors.white,
        //     fontSize: widget.size * 0.16,
        //     fontWeight: FontWeight.w800,
        //     letterSpacing: widget.size * 0.012,
        //   ),
        // ),
      ),
    );
  }
}

class _SenaSplashPainter extends CustomPainter {
  const _SenaSplashPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide * 0.31;
    final growth = Curves.easeOutCubic.transform(
      ((progress - 0.04) / 0.42).clamp(0.0, 1.0),
    );

    final circlePaint = Paint()..color = const Color(0xFF27B900);
    canvas.drawCircle(center, radius, circlePaint);

    final branchPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.shortestSide * 0.018
      ..strokeCap = StrokeCap.round;
    final base = Offset(center.dx, center.dy + radius * 0.58);
    final branches = [
      Offset(center.dx, center.dy - radius * 0.08),
      Offset(center.dx - radius * 0.32, center.dy + radius * 0.20),
      Offset(center.dx + radius * 0.32, center.dy + radius * 0.20),
      Offset(center.dx - radius * 0.59, center.dy + radius * 0.38),
      Offset(center.dx + radius * 0.59, center.dy + radius * 0.38),
    ];
    for (final branch in branches) {
      canvas.drawLine(base, Offset.lerp(base, branch, growth)!, branchPaint);
    }
    final leafPaint = Paint()..color = Colors.white;
    final leftLeaf = _leafPath(center, radius, left: true);
    final rightLeaf = _leafPath(center, radius, left: false);
    canvas.drawPath(leftLeaf, leafPaint);
    canvas.drawPath(rightLeaf, leafPaint);
  }

  Path _leafPath(Offset center, double radius, {required bool left}) {
    final direction = left ? -1.0 : 1.0;
    final tip = Offset(
      center.dx + direction * radius * 0.16,
      center.dy - radius * 0.58,
    );
    final outer = Offset(
      center.dx + direction * radius * 0.48,
      center.dy - radius * 0.38,
    );
    final bottom = Offset(
      center.dx + direction * radius * 0.16,
      center.dy + radius * 0.06,
    );
    final start = Offset(center.dx, center.dy + radius * 0.06);
    final path = Path()..moveTo(start.dx, start.dy);
    path.cubicTo(outer.dx, outer.dy, tip.dx, tip.dy, tip.dx, tip.dy);
    path.cubicTo(bottom.dx, bottom.dy, start.dx, start.dy, start.dx, start.dy);
    return path..close();
  }

  @override
  bool shouldRepaint(covariant _SenaSplashPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
