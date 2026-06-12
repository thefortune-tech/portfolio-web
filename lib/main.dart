import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adeyemi Fortune | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0A1628),
        fontFamily: 'Montserrat',
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              HeroSection(),
              SkillsMarqueeSection(), 
              ProjectsSection(), // Upgraded with clear elevated buttons
              ContactSection(),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── URL LAUNCHER ENGINE ──────────────────────────────────────────────────────
Future<void> _launchURL(String urlString) async {
  final Uri url = Uri.parse(urlString);
  try {
    final bool launched = await launchUrl(url, mode: LaunchMode.platformDefault);
    if (!launched && urlString.startsWith('mailto:')) {
      final String webGmail = 'https://mail.google.com/mail/?view=cm&fs=1&to=adeyemifortuneadeboye@gmail.com&su=Project%20Inquiry';
      await launchUrl(Uri.parse(webGmail), mode: LaunchMode.externalApplication);
    }
  } catch (e) {
    if (urlString.startsWith('mailto:')) {
      final String webGmail = 'https://mail.google.com/mail/?view=cm&fs=1&to=adeyemifortuneadeboye@gmail.com&su=Project%20Inquiry';
      await launchUrl(Uri.parse(webGmail), mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $urlString: $e');
    }
  }
}

// ─── OFFICIALLY BRANDED VECTOR PAINT STRUCTURES ──────────────────────────────
class GitHubLogoPainter extends CustomPainter {
  const GitHubLogoPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final path = Path();
    final w = size.width;
    final h = size.height;
    
    path.moveTo(w * 0.5, 0);
    path.cubicTo(w * 0.223, 0, 0, h * 0.223, 0, h * 0.5);
    path.cubicTo(0, h * 0.722, w * 0.147, h * 0.91, w * 0.352, h * 0.978);
    path.cubicTo(w * 0.377, h * 0.983, w * 0.386, h * 0.967, w * 0.386, h * 0.954);
    path.cubicTo(w * 0.386, h * 0.942, w * 0.386, h * 0.906, w * 0.386, h * 0.86);
    path.cubicTo(w * 0.247, h * 0.89, w * 0.218, h * 0.793, w * 0.218, h * 0.793);
    path.cubicTo(w * 0.195, h * 0.736, w * 0.163, h * 0.721, w * 0.163, h * 0.721);
    path.cubicTo(w * 0.118, h * 0.69, w * 0.164, h * 0.69, w * 0.164, h * 0.69);
    path.cubicTo(w * 0.214, h * 0.694, w * 0.24, h * 0.742, w * 0.24, h * 0.742);
    path.cubicTo(w * 0.284, h * 0.817, w * 0.355, h * 0.795, w * 0.383, h * 0.783);
    path.cubicTo(w * 0.387, h * 0.751, w * 0.4, h * 0.729, w * 0.414, h * 0.717);
    path.cubicTo(w * 0.303, h * 0.704, w * 0.186, h * 0.661, w * 0.186, h * 0.47);
    path.cubicTo(w * 0.186, h * 0.415, w * 0.206, h * 0.371, w * 0.238, h * 0.336);
    path.cubicTo(w * 0.233, h * 0.323, w * 0.216, h * 0.272, w * 0.243, h * 0.203);
    path.cubicTo(w * 0.243, h * 0.203, w * 0.285, h * 0.19, w * 0.38, h * 0.254);
    path.cubicTo(w * 0.42, h * 0.243, w * 0.463, h * 0.238, w * 0.5, h * 0.238);
    path.cubicTo(w * 0.537, h * 0.238, w * 0.58, h * 0.243, w * 0.62, h * 0.254);
    path.cubicTo(w * 0.715, h * 0.19, w * 0.757, h * 0.203, w * 0.757, h * 0.203);
    path.cubicTo(w * 0.784, h * 0.272, w * 0.767, h * 0.323, w * 0.762, h * 0.336);
    path.cubicTo(w * 0.794, h * 0.371, w * 0.814, h * 0.415, w * 0.814, h * 0.47);
    path.cubicTo(w * 0.814, h * 0.662, w * 0.697, h * 0.704, w * 0.586, h * 0.716);
    path.cubicTo(w * 0.604, h * 0.732, w * 0.62, h * 0.763, w * 0.62, h * 0.811);
    path.cubicTo(w * 0.62, h * 0.88, w * 0.619, h * 0.936, w * 0.619, h * 0.954);
    path.cubicTo(w * 0.619, h * 0.968, w * 0.628, h * 0.984, w * 0.653, h * 0.978);
    path.cubicTo(w * 0.853, h * 0.91, w * 1, h * 0.722, w * 1, h * 0.5);
    path.cubicTo(w * 1, h * 0.223, w * 0.777, 0, w * 0.5, 0);
    path.close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GitHubLogoPainterBlue extends CustomPainter {
  const GitHubLogoPainterBlue();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF378ADD)
      ..style = PaintingStyle.fill;
    final path = Path();
    final w = size.width;
    final h = size.height;
    
    path.moveTo(w * 0.5, 0);
    path.cubicTo(w * 0.223, 0, 0, h * 0.223, 0, h * 0.5);
    path.cubicTo(0, h * 0.722, w * 0.147, h * 0.91, w * 0.352, h * 0.978);
    path.cubicTo(w * 0.377, h * 0.983, w * 0.386, h * 0.967, w * 0.386, h * 0.954);
    path.cubicTo(w * 0.386, h * 0.942, w * 0.386, h * 0.906, w * 0.386, h * 0.86);
    path.cubicTo(w * 0.247, h * 0.89, w * 0.218, h * 0.793, w * 0.218, h * 0.793);
    path.cubicTo(w * 0.195, h * 0.736, w * 0.163, h * 0.721, w * 0.163, h * 0.721);
    path.cubicTo(w * 0.118, h * 0.69, w * 0.164, h * 0.69, w * 0.164, h * 0.69);
    path.cubicTo(w * 0.214, h * 0.694, w * 0.24, h * 0.742, w * 0.24, h * 0.742);
    path.cubicTo(w * 0.284, h * 0.817, w * 0.355, h * 0.795, w * 0.383, h * 0.783);
    path.cubicTo(w * 0.387, h * 0.751, w * 0.4, h * 0.729, w * 0.414, h * 0.717);
    path.cubicTo(w * 0.303, h * 0.704, w * 0.186, h * 0.661, w * 0.186, h * 0.47);
    path.cubicTo(w * 0.186, h * 0.415, w * 0.206, h * 0.371, w * 0.238, h * 0.336);
    path.cubicTo(w * 0.233, h * 0.323, w * 0.216, h * 0.272, w * 0.243, h * 0.203);
    path.cubicTo(w * 0.243, h * 0.203, w * 0.285, h * 0.19, w * 0.38, h * 0.254);
    path.cubicTo(w * 0.42, h * 0.243, w * 0.463, h * 0.238, w * 0.5, h * 0.238);
    path.cubicTo(w * 0.537, h * 0.238, w * 0.58, h * 0.243, w * 0.62, h * 0.254);
    path.cubicTo(w * 0.715, h * 0.19, w * 0.757, h * 0.203, w * 0.757, h * 0.203);
    path.cubicTo(w * 0.784, h * 0.272, w * 0.767, h * 0.323, w * 0.762, h * 0.336);
    path.cubicTo(w * 0.794, h * 0.371, w * 0.814, h * 0.415, w * 0.814, h * 0.47);
    path.cubicTo(w * 0.814, h * 0.662, w * 0.697, h * 0.704, w * 0.586, h * 0.716);
    path.cubicTo(w * 0.604, h * 0.732, w * 0.62, h * 0.763, w * 0.62, h * 0.811);
    path.cubicTo(w * 0.62, h * 0.88, w * 0.619, h * 0.936, w * 0.619, h * 0.954);
    path.cubicTo(w * 0.619, h * 0.968, w * 0.628, h * 0.984, w * 0.653, h * 0.978);
    path.cubicTo(w * 0.853, h * 0.91, w * 1, h * 0.722, w * 1, h * 0.5);
    path.cubicTo(w * 1, h * 0.223, w * 0.777, 0, w * 0.5, 0);
    path.close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class XLogoPainter extends CustomPainter {
  const XLogoPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF378ADD)
      ..style = PaintingStyle.fill;
    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w * 0.0, 0);
    path.lineTo(w * 0.39, h * 0.55);
    path.lineTo(w * 0.0, h);
    path.lineTo(w * 0.18, h);
    path.lineTo(w * 0.47, h * 0.66);
    path.lineTo(w * 0.78, h);
    path.lineTo(w * 1.0, h);
    path.lineTo(w * 0.59, h * 0.42);
    path.lineTo(w * 0.96, 0);
    path.lineTo(w * 0.78, 0);
    path.lineTo(w * 0.51, h * 0.32);
    path.lineTo(w * 0.22, 0);
    path.close();

    final path2 = Path();
    path2.moveTo(w * 0.15, 0);
    path2.lineTo(w * 0.33, 0);
    path2.lineTo(w * 0.85, h);
    path2.lineTo(w * 0.67, h);
    path2.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class YouTubeLogoPainter extends CustomPainter {
  const YouTubeLogoPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF378ADD)
      ..style = PaintingStyle.fill;
    final w = size.width;
    final h = size.height;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, w, h),
      Radius.circular(w * 0.25),
    );
    canvas.drawRRect(rrect, paint);

    final trianglePaint = Paint()..color = const Color(0xFF0A1628)..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(w * 0.4, h * 0.32);
    path.lineTo(w * 0.68, h * 0.5);
    path.lineTo(w * 0.4, h * 0.68);
    path.close();
    canvas.drawPath(path, trianglePaint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class YouTubeLogoPainterWhite extends CustomPainter {
  const YouTubeLogoPainterWhite();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final w = size.width;
    final h = size.height;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, w, h),
      Radius.circular(w * 0.25),
    );
    canvas.drawRRect(rrect, paint);

    final trianglePaint = Paint()..color = const Color(0xFF0D2137)..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(w * 0.4, h * 0.32);
    path.lineTo(w * 0.68, h * 0.5);
    path.lineTo(w * 0.4, h * 0.68);
    path.close();
    canvas.drawPath(path, trianglePaint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── AMBIENT KINETIC BACKGROUND ENGINE ───────────────────────────────────────
class GlowParticleBackground extends StatefulWidget {
  const GlowParticleBackground({super.key});

  @override
  State<GlowParticleBackground> createState() => _GlowParticleBackgroundState();
}

class _GlowParticleBackgroundState extends State<GlowParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = List.generate(20, (index) => _Particle());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        for (var p in _particles) {
          p.update();
        }
        return CustomPaint(
          painter: _ParticlePainter(_particles),
          child: Container(),
        );
      },
    );
  }
}

class _Particle {
  double x = math.Random().nextDouble();
  double y = math.Random().nextDouble();
  double size = math.Random().nextDouble() * 3 + 1;
  double speedY = (math.Random().nextDouble() * 0.001) + 0.0003;
  double alpha = math.Random().nextDouble() * 0.2 + 0.1;

  void update() {
    y -= speedY;
    if (y < 0) {
      y = 1.0;
      x = math.Random().nextDouble();
    }
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  _ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF378ADD);
    for (var p in particles) {
      paint.color = const Color(0xFF378ADD).withValues(alpha: p.alpha);
      canvas.drawCircle(Offset(p.x * size.width, p.y * size.height), p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ─── CUSTOM RESPONSIVE CARD HOVER LAYOUT ─────────────────────────────────────
class HoverCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const HoverCard({super.key, required this.child, this.onTap});

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = isMobile ? false : true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..translate(0, _isHovered ? -6.0 : 0.0)
            ..scale(_isHovered ? 1.02 : 1.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _isHovered 
                    ? const Color(0xFF378ADD).withValues(alpha: 0.2)
                    : Colors.transparent,
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class FadeSlideIn extends StatefulWidget {
  final Widget child;
  final int delayMs;
  const FadeSlideIn({super.key, required this.child, this.delayMs = 0});

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _slide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _fade, child: SlideTransition(position: _slide, child: widget.child));
  }
}

// ─── HERO CANVAS LAYOUT ──────────────────────────────────────────────────────
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;
    final isMobile = width < 600;

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0A1628), Color(0xFF0D2137)],
              ),
            ),
          ),
        ),
        const Positioned.fill(child: GlowParticleBackground()),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 120 : (isMobile ? 24 : 48),
            vertical: isDesktop ? 100 : 60,
          ),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _heroContent(context, true, false),
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(flex: 2, child: _avatar(false)),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _avatar(isMobile),
                    const SizedBox(height: 40),
                    ..._heroContent(context, false, isMobile),
                  ],
                ),
        ),
      ],
    );
  }

  List<Widget> _heroContent(BuildContext context, bool isDesktop, bool isMobile) {
    return [
      FadeSlideIn(
        delayMs: 100,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF378ADD).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xFF378ADD).withValues(alpha: 0.35)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              const Text(
                'AVAILABLE FOR REMOTE WORK',
                style: TextStyle(color: Color(0xFF378ADD), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 24),
      FadeSlideIn(
        delayMs: 250,
        child: Text(
          'Adeyemi Fortune\nAdeboye',
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 36 : (isDesktop ? 54 : 44),
            fontWeight: FontWeight.w800,
            height: 1.15,
            letterSpacing: -1.0,
          ),
        ),
      ),
      const SizedBox(height: 14),
      FadeSlideIn(
        delayMs: 400,
        child: Text(
          'Mobile Software Engineer',
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF378ADD),
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      const SizedBox(height: 18),
      FadeSlideIn(
        delayMs: 550,
        child: Text(
          'Building production-grade Flutter applications with hybrid state management (Riverpod & BLoC), Firebase architecture, and fully automated remote deployment pipelines.',
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.75),
            fontSize: isMobile ? 14 : 15,
            height: 1.6,
          ),
        ),
      ),
      const SizedBox(height: 36),
      FadeSlideIn(
        delayMs: 700,
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            HoverCard(
              onTap: () => _launchURL('mailto:adeyemifortuneadeboye@gmail.com?subject=Project%20Inquiry'),
              child: _button("Let's Talk ✉️", null, const Color(0xFF378ADD), Colors.white, isMobile),
            ),
            HoverCard(
              onTap: () => _launchURL('https://drive.google.com/uc?export=download&id=12FerkMBUIjDo1hCcNy2pD4hezKuhbJzC'),
              child: _button('Resume', Icons.download, Colors.transparent, const Color(0xFF378ADD), isMobile, border: true),
            ),
            HoverCard(
              onTap: () => _launchURL('https://github.com/thefortune-tech'),
              child: _buttonWithPainter('GitHub', const GitHubLogoPainterBlue(), isMobile),
            ),
            HoverCard(
              onTap: () => _launchURL('https://youtube.com/@Fortune_Dev'),
              child: _buttonWithPainter('YouTube', const YouTubeLogoPainter(), isMobile),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _avatar(bool isMobile) {
    return Center(
      child: SizedBox(
        width: isMobile ? 210 : 250,
        height: isMobile ? 230 : 270,
        child: const DynamicProfileAvatar(),
      ),
    );
  }

  Widget _button(String label, IconData? icon, Color bg, Color textColor, bool isMobile, {bool border = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20, vertical: isMobile ? 12 : 14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: border ? Border.all(color: const Color(0xFF378ADD), width: 1.5) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor, size: isMobile ? 14 : 16),
            const SizedBox(width: 8),
          ],
          Text(label, style: TextStyle(color: textColor, fontSize: isMobile ? 12 : 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buttonWithPainter(String label, CustomPainter painter, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20, vertical: isMobile ? 12 : 14),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF378ADD), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: isMobile ? 14 : 16,
            height: isMobile ? 14 : 16,
            child: CustomPaint(painter: painter),
          ),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Color(0xFF378ADD), fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class DynamicProfileAvatar extends StatefulWidget {
  const DynamicProfileAvatar({super.key});

  @override
  State<DynamicProfileAvatar> createState() => _DynamicProfileAvatarState();
}

class _DynamicProfileAvatarState extends State<DynamicProfileAvatar> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = isMobile ? false : true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translate(_isHovered ? -3.0 : 0.0, _isHovered ? -10.0 : 0.0)
          ..scale(_isHovered ? 1.05 : 1.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF378ADD), width: 3),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF378ADD).withValues(alpha: _isHovered ? 0.4 : 0.2),
              blurRadius: _isHovered ? 35 : 25,
              offset: _isHovered ? const Offset(0, 12) : const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: Image.asset(
            'assets/765FC03E-A429-4B36-8C0A-6C95D2C3B148.jpg.PNG',
            fit: BoxFit.cover,
            alignment: const Alignment(0, -0.2),
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Text('AF', style: TextStyle(color: const Color(0xFF0A1628), fontSize: isMobile ? 54 : 64, fontWeight: FontWeight.w800)),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ─── TRUE INFINITE AUTOPLAY MARQUEE ENGINE ───────────────────────────────────
class SkillsMarqueeSection extends StatefulWidget {
  const SkillsMarqueeSection({super.key});

  @override
  State<SkillsMarqueeSection> createState() => _SkillsMarqueeSectionState();
}

class _SkillsMarqueeSectionState extends State<SkillsMarqueeSection> {
  late PageController _pageController;
  Timer? _ticker;
  Timer? _resumeTimer;
  bool _isUserInteracting = false;
  
  final int _virtualCenterIndex = 10000;
  final Duration _scrollSpeedDuration = const Duration(milliseconds: 1400); 

  final List<Map<String, dynamic>> skills = [
    {'icon': Icons.phone_android_rounded, 'isEmoji': false, 'title': 'Flutter & Dart'},
    {'icon': '🧠', 'isEmoji': true, 'title': 'Riverpod & BLoC'},
    {'icon': '🔥', 'isEmoji': true, 'title': 'Firebase Infra'},
    {'icon': Icons.layers_outlined, 'isEmoji': false, 'title': 'Clean Architecture'},
    {'icon': '🧪', 'isEmoji': true, 'title': 'Automated Testing'},
    {'icon': '⚙️', 'isEmoji': true, 'title': 'GitHub CI/CD Pipelines'},
    {'icon': Icons.storage_rounded, 'isEmoji': false, 'title': 'Hive Offline SQL'},
    {'icon': '🌐', 'isEmoji': true, 'title': 'REST APIs & Dio'},
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _virtualCenterIndex,
      viewportFraction: 0.28,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _initiateAutoSlideLoop());
  }

  void _initiateAutoSlideLoop() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(milliseconds: 1600), (timer) {
      if (_isUserInteracting || !_pageController.hasClients) return;
      
      _pageController.nextPage(
        duration: _scrollSpeedDuration,
        curve: Curves.linear,
      );
    });
  }

  void _pauseAutoScroll() {
    if (!_isUserInteracting) {
      setState(() => _isUserInteracting = true);
    }
    _resumeTimer?.cancel();
  }

  void _stageResumeCountdown() {
    _resumeTimer?.cancel();
    _resumeTimer = Timer(const Duration(milliseconds: 1800), () {
      if (mounted) {
        setState(() => _isUserInteracting = false);
      }
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _resumeTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1100;

    final double trackHeight = isMobile ? 120 : 144;
    final double cardHeight = isMobile ? 110 : 134;
    final double titleFontSize = isMobile ? 14 : 16;
    final double iconSize = isMobile ? 24 : 32;

    if (isMobile) {
      _pageController = PageController(initialPage: _pageController.initialPage, viewportFraction: 0.62);
    } else if (isTablet) {
      _pageController = PageController(initialPage: _pageController.initialPage, viewportFraction: 0.30);
    }else {
    // Large Desktop: Shrunk from 0.28 down to 0.18 / 0.20 to pull the containers close together
    _pageController = PageController(initialPage: _pageController.initialPage, viewportFraction: 0.18);
  }

    return MouseRegion(
      onEnter: (_) => _pauseAutoScroll(),
      onExit: (_) => _stageResumeCountdown(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 36),
        color: const Color(0xFF0D2137),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width > 900 ? 120 : 24),
              child: const Text(
                'ENGINEERING ENGINE',
                style: TextStyle(
                  color: Color(0xFF378ADD),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.8,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Listener(
              onPointerDown: (_) => _pauseAutoScroll(),
              onPointerUp: (_) => _stageResumeCountdown(),
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollStartNotification) {
                    _pauseAutoScroll();
                  } else if (notification is ScrollEndNotification) {
                    _stageResumeCountdown();
                  }
                  return true;
                },
                child: SizedBox(
                  height: trackHeight,
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final skill = skills[index % skills.length];
                      
                      return Center(
                        child: Container(
                          height: cardHeight,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A1628),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF378ADD).withValues(alpha: 0.18),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                blurRadius: 12,
                                offset: const Offset(0, 5),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              skill['isEmoji'] as bool
                                  ? Text(skill['icon'] as String, style: TextStyle(fontSize: iconSize - 4))
                                  : Icon(skill['icon'] as IconData, color: const Color(0xFF378ADD), size: iconSize),
                              const SizedBox(height: 14),
                              Text(
                                skill['title'] as String,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.2,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── FEATURED PROJECTS MATRIX WITH ELEVATED LINK BUTTONS ──────────────────────
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    int crossAxisCount = 2;
    double extentHeight = 310; // Tall container format to store stacked action buttons comfortably
    if (width < 600) {
      crossAxisCount = 1;
      extentHeight = 340;
    } else if (width < 900) {
      crossAxisCount = 1;
      extentHeight = 310;
    }

    final projects = [
      {
        'icon': Icons.chat_bubble_outline_rounded, 'isEmoji': false, 'title': 'Real-time Chat App', 'tech': 'BLoC • Firebase • Firestore',
        'desc': 'Multi-user chat with Firebase Auth and Firestore. Messages sync instantly across devices.',
        'github': 'https://github.com/thefortune-tech/chat-app', 'demo': 'https://youtube.com/shorts/3EZWWbwvxlw',
      },
      {
        'icon': Icons.wb_sunny_outlined, 'isEmoji': false, 'title': 'Weather Tracking App', 'tech': 'Riverpod • Dio • Hive',
        'desc': 'Live weather with offline caching. Automatic fallback when network is unavailable.',
        'github': 'https://github.com/thefortune-tech/weather-app', 'demo': 'https://youtube.com/shorts/IJ77pR67duA',
      },
      {
        'icon': '📰', 'isEmoji': true, 'title': 'News Reader App', 'tech': 'Riverpod • BLoC • Hive',
        'desc': 'Dual state management — Riverpod for live feed, BLoC for offline bookmarks.',
        'github': 'https://github.com/thefortune-tech/news-reader', 'demo': 'https://youtube.com/shorts/Omf3iLUEMOY',
      },
      {
        'icon': '📝', 'isEmoji': true, 'title': 'Notes Management App', 'tech': 'BLoC • GoRouter • Hive',
        'desc': 'Full CRUD with Clean Architecture, Dependency Injection and GoRouter navigation.',
        'github': 'https://github.com/thefortune-tech/notes-app', 'demo': 'https://youtube.com/shorts/ofSvlzyPAlY',
      },
      {
        'icon': '🛒', 'isEmoji': true, 'title': 'E-commerce App', 'tech': 'BLoC • Dio • FakeStore API',
        'desc': 'Multi-screen product grid, detail screens and persistent cart with Hive.',
        'github': 'https://github.com/thefortune-tech/ecommerce-app', 'demo': 'https://youtube.com/shorts/_pMOVNx7wGQ',
      },
      {
        'icon': Icons.photo_camera_outlined, 'isEmoji': false, 'title': 'Camera + Map Tracker', 'tech': 'Geolocator • Flutter Map',
        'desc': 'Real device hardware — camera preview, GPS location and live OpenStreetMap display.',
        'github': 'https://github.com/thefortune-tech/camera-map-app', 'demo': 'https://youtube.com/shorts/cCeeJlqDtxg',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: width > 900 ? 120 : 24, vertical: 60),
      color: const Color(0xFF0A1628),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Featured Projects'),
          const SizedBox(height: 36),
          GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: crossAxisCount,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    mainAxisExtent: 250, // Shorter container now that buttons are side-by-side
  ),
  itemCount: projects.length,
  itemBuilder: (context, index) {
    final p = projects[index];
    return FadeSlideIn(
      delayMs: index * 40,
      child: HoverCard(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF0D2137),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF378ADD).withValues(alpha: 0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              p['isEmoji'] as bool
                  ? Text(p['icon'] as String, style: const TextStyle(fontSize: 26))
                  : Icon(p['icon'] as IconData, color: const Color(0xFF378ADD), size: 28),
              const SizedBox(height: 10),
              Text(p['title'] as String, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(p['tech'] as String, style: const TextStyle(color: Color(0xFF378ADD), fontSize: 11, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  p['desc'] as String,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12.5, height: 1.4),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 16),
              
              // Clean Even Row: Buttons side-by-side
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _launchURL(p['github'] as String),
                      icon: SizedBox(
                        width: 12,
                        height: 12,
                        child: CustomPaint(painter: const GitHubLogoPainter()),
                      ),
                      label: const Text('Code', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF378ADD),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8), // Gap between buttons
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _launchURL(p['demo'] as String),
                      icon: SizedBox(
                        width: 12,
                        height: 12,
                        child: CustomPaint(painter: const YouTubeLogoPainterWhite()),
                      ),
                      label: const Text('Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A1628),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: Color(0xFF378ADD), width: 1.2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  },
)
        ],
      ),
    );
  }
}

class _InteractiveIconButton extends StatefulWidget {
  final IconData? icon;
  final CustomPainter? painter;
  final String tooltip;
  final VoidCallback onPressed;

  const _InteractiveIconButton({this.icon, this.painter, required this.tooltip, required this.onPressed});

  @override
  State<_InteractiveIconButton> createState() => _InteractiveIconButtonState();
}

class _InteractiveIconButtonState extends State<_InteractiveIconButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Tooltip(
        message: widget.tooltip,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: Matrix4.identity()..scale(_isHovering ? 1.15 : 1.0),
          decoration: BoxDecoration(
            color: _isHovering ? const Color(0xFF378ADD).withValues(alpha: 0.15) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: widget.painter != null
                ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CustomPaint(
                      painter: widget.painter,
                    ),
                  )
                : Icon(widget.icon, color: _isHovering ? Colors.white : const Color(0xFF378ADD), size: 18),
            onPressed: widget.onPressed,
          ),
        ),
      ),
    );
  }
}

// ─── CONTACT CANVAS SECTOR ───────────────────────────────────────────────────
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: width > 900 ? 120 : 24, vertical: 60),
      color: const Color(0xFF0D2137),
      child: Column(
        children: [
          _sectionTitle('Get In Touch'),
          const SizedBox(height: 16),
          const Text(
            'Available for high-stakes engineering milestones and premium remote frameworks.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white60, fontSize: 14),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _InteractiveIconButton(icon: null, painter: const XLogoPainter(), tooltip: 'Follow on X', onPressed: () => _launchURL('https://x.com/h_white96312?s=21')),
              const SizedBox(width: 16),
              _InteractiveIconButton(icon: null, painter: const GitHubLogoPainterBlue(), tooltip: 'Review Engineering Engine', onPressed: () => _launchURL('https://github.com/thefortune-tech')),
              const SizedBox(width: 16),
              _InteractiveIconButton(icon: null, painter: const YouTubeLogoPainter(), tooltip: 'Subscribe on YouTube', onPressed: () => _launchURL('https://youtube.com/@Fortune_Dev')),
            ],
          ),
          const SizedBox(height: 36),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              HoverCard(
                onTap: () => _launchURL('mailto:adeyemifortuneadeboye@gmail.com?subject=Project%20Inquiry'),
                child: _contactCard('Official Email', 'adeyemifortuneadeboye@gmail.com', Icons.email_outlined),
              ),
              HoverCard(
                onTap: () => _launchURL('https://github.com/thefortune-tech'),
                child: _contactCard('GitHub Platform', 'github.com/thefortune-tech', null, painter: const GitHubLogoPainterBlue()),
              ),
              HoverCard(
                onTap: () => _launchURL('https://youtube.com/@Fortune_Dev'),
                child: _contactCard('Technical Hub', '@Fortune_Dev', null, painter: const YouTubeLogoPainter()),
              ),
            ],
          ),
          const SizedBox(height: 56),
          const Text(
            '© 2026 Adeyemi Fortune Adeboye — Built with Flutter Web 💙',
            style: TextStyle(color: Colors.white30, fontSize: 12, letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }

  Widget _contactCard(String label, String value, IconData? icon, {CustomPainter? painter}) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1628),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF378ADD).withValues(alpha: 0.12)),
      ),
      child: Column(
        children: [
          if (painter != null)
            SizedBox(width: 30, height: 30, child: CustomPaint(painter: painter))
          else
            Icon(icon, color: const Color(0xFF378ADD), size: 30),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(color: Color(0xFF378ADD), fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(color: Colors.white70, fontSize: 11), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

Widget _sectionTitle(String text) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(text, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
      const SizedBox(height: 8),
      Container(width: 40, height: 4, decoration: BoxDecoration(color: const Color(0xFF378ADD), borderRadius: BorderRadius.circular(2))),
    ],
  );
}