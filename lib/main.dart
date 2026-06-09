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
        fontFamily: 'Montserrat', // Clean, modern developer typeface
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
              SkillsSection(),
              ProjectsSection(),
              ContactSection(),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── FAIL-SAFE URL LAUNCHER ──────────────────────────────────────────────────
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

// ─── AMBIENT BACKGROUND PARTICLES (ALIVE FX) ──────────────────────────────────
class GlowParticleBackground extends StatefulWidget {
  const GlowParticleBackground({super.key});

  @override
  State<GlowParticleBackground> createState() => _GlowParticleBackgroundState();
}

class _GlowParticleBackgroundState extends State<GlowParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = List.generate(25, (index) => _Particle());

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
  double alpha = math.Random().nextDouble() * 0.3 + 0.1;

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
      canvas.drawCircle(
        Offset(p.x * size.width, p.y * size.height),
        p.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ─── UPGRADED INTERACTIVE HOVER WRAPPER ───────────────────────────────────────
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
    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack, // Creates a snappy dynamic elastic pop
          transform: Matrix4.identity()
            ..translate(0, _isHovered ? -10.0 : 0.0)
            ..scale(_isHovered ? 1.04 : 1.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _isHovered 
                    ? const Color(0xFF378ADD).withValues(alpha: 0.3)
                    : Colors.transparent,
                blurRadius: 25,
                spreadRadius: 3,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

// ─── FADE & SLIDE ANIMATION WRAPPER ───────────────────────────────────────────
class FadeSlideIn extends StatefulWidget {
  final Widget child;
  final int delayMs;
  const FadeSlideIn({super.key, required this.child, this.delayMs = 0});

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

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
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

// ─── HERO SECTION ─────────────────────────────────────────────────────────────
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 800;

    return Stack(
      children: [
        // Ambient background glow layer
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
        // Active dynamic particle system layer
        const Positioned.fill(child: GlowParticleBackground()),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 120 : 24,
            vertical: isDesktop ? 120 : 60,
          ),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _heroContent(isDesktop),
                      ),
                    ),
                    const SizedBox(width: 60),
                    Expanded(flex: 2, child: _avatar()),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _avatar(),
                    const SizedBox(height: 40),
                    ..._heroContent(isDesktop),
                  ],
                ),
        ),
      ],
    );
  }

  List<Widget> _heroContent(bool isDesktop) {
    return [
      FadeSlideIn(
        delayMs: 100,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF378ADD).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xFF378ADD).withValues(alpha: 0.35)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'AVAILABLE FOR REMOTE WORK',
                style: TextStyle(
                  color: Color(0xFF378ADD),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 24),
      FadeSlideIn(
        delayMs: 250,
        child: const Text(
          'Adeyemi Fortune\nAdeboye',
          style: TextStyle(
            color: Colors.white,
            fontSize: 56,
            fontWeight: FontWeight.w800,
            height: 1.15,
            letterSpacing: -1.5,
          ),
        ),
      ),
      const SizedBox(height: 16),
      FadeSlideIn(
        delayMs: 400,
        child: const Text(
          'Mobile Software Engineer',
          style: TextStyle(
            color: Color(0xFF378ADD),
            fontSize: 26,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      const SizedBox(height: 20),
      FadeSlideIn(
        delayMs: 550,
        child: Text(
          'Building production-grade Flutter applications with hybrid state management (Riverpod & BLoC), Firebase architecture, and fully automated remote deployment pipelines.',
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.75),
            fontSize: 16,
            height: 1.65,
          ),
        ),
      ),
      const SizedBox(height: 40),
      FadeSlideIn(
        delayMs: 700,
        child: Wrap(
          spacing: 14,
          runSpacing: 14,
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            HoverCard(
              onTap: () => _launchURL('mailto:adeyemifortuneadeboye@gmail.com?subject=Project%20Inquiry'),
              child: _button(
                label: "Let's Talk (Email) ✉️",
                icon: Icons.email_outlined,
                bg: const Color(0xFF378ADD),
                textColor: Colors.white,
              ),
            ),
            HoverCard(
              onTap: () => _launchURL('https://drive.google.com/uc?export=download&id=12FerkMBUIjDo1hCcNy2pD4hezKuhbJzC'),
              child: _button(
                label: 'Resume',
                icon: Icons.download,
                bg: Colors.transparent,
                textColor: const Color(0xFF378ADD),
                border: true,
              ),
            ),
            HoverCard(
              onTap: () => _launchURL('https://wa.me/2347053802331'),
              child: _button(
                label: 'WhatsApp',
                icon: Icons.chat_bubble_outline_rounded,
                bg: Colors.transparent,
                textColor: const Color(0xFF378ADD),
                border: true,
              ),
            ),
            HoverCard(
              onTap: () => _launchURL('https://github.com/thefortune-tech'),
              child: _button(
                label: 'GitHub',
                icon: Icons.code,
                bg: Colors.transparent,
                textColor: const Color(0xFF378ADD),
                border: true,
              ),
            ),
            HoverCard(
              onTap: () => _launchURL('https://youtube.com/@Fortune_Dev'),
              child: _button(
                label: 'YouTube',
                icon: Icons.play_circle_outline,
                bg: Colors.transparent,
                textColor: const Color(0xFF378ADD),
                border: true,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _avatar() {
    return const FadeSlideIn(
      delayMs: 350,
      child: Center(
        child: DynamicProfileAvatar(),
      ),
    );
  }

  Widget _button({
    required String label,
    required IconData icon,
    required Color bg,
    required Color textColor,
    bool border = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: border ? Border.all(color: const Color(0xFF378ADD), width: 1.5) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── NEW DYNAMIC PROFILE AVATAR WIDGET ───────────────────────────────────────
class DynamicProfileAvatar extends StatefulWidget {
  const DynamicProfileAvatar({super.key});

  @override
  State<DynamicProfileAvatar> createState() => _DynamicProfileAvatarState();
}

class _DynamicProfileAvatarState extends State<DynamicProfileAvatar> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutBack, // Premium, snappy elastic pop effect
        transform: Matrix4.identity()
          ..translate(_isHovered ? -4.0 : 0.0, _isHovered ? -12.0 : 0.0) // Shifts up and left
          ..scale(_isHovered ? 1.06 : 1.0) // Handles physical scaling expansion
          ..rotateZ(_isHovered ? 0.02 : 0.0), // Adds a fine micro 3D-tilt angle
        width: 260,
        height: 280,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered ? const Color(0xFF378ADD) : const Color(0xFF378ADD).withValues(alpha: 0.7), 
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF378ADD).withValues(alpha: _isHovered ? 0.45 : 0.25),
              blurRadius: _isHovered ? 45 : 30,
              spreadRadius: _isHovered ? 8 : 3,
              offset: _isHovered ? const Offset(0, 16) : const Offset(0, 10),
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
                child: Text(
                  'AF',
                  style: TextStyle(
                    color: const Color(0xFF0A1628),
                    fontSize: _isHovered ? 68 : 64,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ─── SKILLS SECTION ───────────────────────────────────────────────────────────
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    final skills = [
      {'icon': Icons.phone_android_rounded, 'isEmoji': false, 'title': 'Flutter & Dart', 'desc': 'Cross-platform mobile development'},
      {'icon': '🧠', 'isEmoji': true, 'title': 'State Management', 'desc': 'Riverpod & BLoC hybrid architecture'},
      {'icon': '🔥', 'isEmoji': true, 'title': 'Firebase', 'desc': 'Auth, Firestore, real-time sync'},
      {'icon': Icons.layers_outlined, 'isEmoji': false, 'title': 'Clean Architecture', 'desc': 'MVVM, DI, Repository Pattern'},
      {'icon': '🧪', 'isEmoji': true, 'title': 'Testing', 'desc': 'Unit, Widget, Integration tests'},
      {'icon': '⚙️', 'isEmoji': true, 'title': 'CI/CD', 'desc': 'GitHub Actions, APK automation'},
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 120 : 24,
        vertical: 80,
      ),
      color: const Color(0xFF0D2137),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeSlideIn(
            child: _sectionTitle('Core Expertise'),
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 3 : 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: isDesktop ? 1.5 : 1.15,
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              final skill = skills[index];
              final isEmoji = skill['isEmoji'] as bool;

              return FadeSlideIn(
                delayMs: index * 60,
                child: HoverCard(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A1628),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF378ADD).withValues(alpha: 0.15),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isEmoji 
                          ? Text(skill['icon'] as String, style: const TextStyle(fontSize: 32))
                          : Icon(skill['icon'] as IconData, color: const Color(0xFF378ADD), size: 34),
                        const SizedBox(height: 12),
                        Text(
                          skill['title'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          skill['desc'] as String,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.55),
                            fontSize: 12.5,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─── PROJECTS SECTION WITH ACTIVE INTERACTIVE ACTIONS ────────────────────────
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    final projects = [
      {
        'icon': Icons.chat_bubble_outline_rounded,
        'isEmoji': false,
        'title': 'Real-time Chat App',
        'tech': 'BLoC • Firebase • Firestore',
        'desc': 'Multi-user chat with Firebase Auth and Firestore. Messages sync instantly across devices.',
        'github': 'https://github.com/thefortune-tech/chat-app',
        'demo': 'https://youtube.com/shorts/3EZWWbwvxlw',
      },
      {
        'icon': Icons.wb_sunny_outlined,
        'isEmoji': false,
        'title': 'Weather Tracking App',
        'tech': 'Riverpod • Dio • Hive',
        'desc': 'Live weather with offline caching. Automatic fallback when network is unavailable.',
        'github': 'https://github.com/thefortune-tech/weather-app',
        'demo': 'https://youtube.com/shorts/IJ77pR67duA',
      },
      {
        'icon': '📰',
        'isEmoji': true,
        'title': 'News Reader App',
        'tech': 'Riverpod • BLoC • Hive',
        'desc': 'Dual state management — Riverpod for live feed, BLoC for offline bookmarks.',
        'github': 'https://github.com/thefortune-tech/news-reader',
        'demo': 'https://youtube.com/shorts/Omf3iLUEMOY',
      },
      {
        'icon': '📝',
        'isEmoji': true,
        'title': 'Notes Management App',
        'tech': 'BLoC • GoRouter • Hive',
        'desc': 'Full CRUD with Clean Architecture, Dependency Injection and GoRouter navigation.',
        'github': 'https://github.com/thefortune-tech/notes-app',
        'demo': 'https://youtube.com/shorts/ofSvlzyPAlY',
      },
      {
        'icon': '🛒',
        'isEmoji': true,
        'title': 'E-commerce App',
        'tech': 'BLoC • Dio • FakeStore API',
        'desc': 'Multi-screen product grid, detail screens and persistent cart with Hive.',
        'github': 'https://github.com/thefortune-tech/ecommerce-app',
        'demo': 'https://youtube.com/shorts/_pMOVNx7wGQ',
      },
      {
        'icon': Icons.photo_camera_outlined,
        'isEmoji': false,
        'title': 'Camera + Map Tracker',
        'tech': 'Geolocator • Flutter Map',
        'desc': 'Real device hardware — camera preview, GPS location and live OpenStreetMap display.',
        'github': 'https://github.com/thefortune-tech/camera-map-app',
        'demo': 'https://youtube.com/shorts/cCeeJlqDtxg',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 120 : 24,
        vertical: 80,
      ),
      color: const Color(0xFF0A1628),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeSlideIn(child: _sectionTitle('Featured Projects')),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 2 : 1,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              mainAxisExtent: 230,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final p = projects[index];
              final isEmoji = p['isEmoji'] as bool;

              return FadeSlideIn(
                delayMs: index * 60,
                child: HoverCard(
                  child: Container(
                    padding: const EdgeInsets.all(26),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D2137),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF378ADD).withValues(alpha: 0.12),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            isEmoji 
                              ? Text(p['icon'] as String, style: const TextStyle(fontSize: 30))
                              : Icon(p['icon'] as IconData, color: const Color(0xFF378ADD), size: 32),
                            const Spacer(),
                            _InteractiveIconButton(
                              icon: Icons.code,
                              tooltip: 'Source Code',
                              onPressed: () => _launchURL(p['github'] as String),
                            ),
                            const SizedBox(width: 8),
                            _InteractiveIconButton(
                              icon: Icons.play_circle_outline,
                              tooltip: 'Video Demo',
                              onPressed: () => _launchURL(p['demo'] as String),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          p['title'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          p['tech'] as String,
                          style: const TextStyle(
                            color: Color(0xFF378ADD),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Text(
                            p['desc'] as String,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.65),
                              fontSize: 13,
                              height: 1.55,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─── ACTION ICON HOPPERS ──────────────────────────────────────────────────────
class _InteractiveIconButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const _InteractiveIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

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
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_isHovering ? 1.2 : 1.0),
          decoration: BoxDecoration(
            color: _isHovering ? const Color(0xFF378ADD).withValues(alpha: 0.15) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(widget.icon, color: _isHovering ? Colors.white : const Color(0xFF378ADD), size: 20),
            onPressed: widget.onPressed,
          ),
        ),
      ),
    );
  }
}

// ─── CONTACT SECTION WITH INTEGRATED SOCIAL LINKS ─────────────────────────────
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 120 : 24,
        vertical: 80,
      ),
      color: const Color(0xFF0D2137),
      child: Column(
        children: [
          FadeSlideIn(child: _sectionTitle('Get In Touch')),
          const SizedBox(height: 20),
          FadeSlideIn(
            delayMs: 100,
            child: const Text(
              'Available for freelance development profiles and global remote engineering tracks',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white60,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 32),
          FadeSlideIn(
            delayMs: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _InteractiveIconButton(
                  icon: Icons.close,
                  tooltip: 'Follow on X',
                  onPressed: () => _launchURL('https://x.com/fortune_techdev'),
                ),
                const SizedBox(width: 16),
                _InteractiveIconButton(
                  icon: Icons.camera_alt_outlined,
                  tooltip: 'Follow on Instagram',
                  onPressed: () => _launchURL('https://www.instagram.com/fortune.tech_dev'),
                ),
                const SizedBox(width: 16),
                _InteractiveIconButton(
                  icon: Icons.facebook,
                  tooltip: 'Connect on Facebook',
                  onPressed: () => _launchURL('https://www.facebook.com/share/1KfzMjxfeX/'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              FadeSlideIn(
                delayMs: 100,
                child: HoverCard(
                  onTap: () => _launchURL('mailto:adeyemifortuneadeboye@gmail.com?subject=Project%20Inquiry'),
                  child: _contactCard(icon: Icons.email_outlined, label: 'Email', value: 'adeyemifortuneadeboye@gmail.com'),
                ),
              ),
              FadeSlideIn(
                delayMs: 200,
                child: HoverCard(
                  onTap: () => _launchURL('https://wa.me/2347053802331'),
                  child: _contactCard(icon: Icons.phone_android_rounded, label: 'WhatsApp', value: '07053802331'),
                ),
              ),
              FadeSlideIn(
                delayMs: 300,
                child: HoverCard(
                  onTap: () => _launchURL('https://github.com/thefortune-tech'),
                  child: _contactCard(icon: Icons.code_rounded, label: 'GitHub', value: 'github.com/thefortune-tech'),
                ),
              ),
              FadeSlideIn(
                delayMs: 400,
                child: HoverCard(
                  onTap: () => _launchURL('https://youtube.com/@Fortune_Dev'),
                  child: _contactCard(icon: Icons.play_circle_fill_rounded, label: 'YouTube', value: '@Fortune_Dev'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 64),
          FadeSlideIn(
            delayMs: 500,
            child: const Text(
              '© 2026 Adeyemi Fortune Adeboye — Built with Flutter Web 💙',
              style: TextStyle(
                color: Colors.white30,
                fontSize: 13,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactCard({
    required IconData icon, 
    required String label, 
    required String value,
  }) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1628),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF378ADD).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF378ADD), size: 34),
          const SizedBox(height: 14),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF378ADD),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─── HELPER TITLE ─────────────────────────────────────────────────────────────
Widget _sectionTitle(String text) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 34,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
      ),
      const SizedBox(height: 10),
      Container(
        width: 54,
        height: 4,
        decoration: BoxDecoration(
          color: const Color(0xFF378ADD),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    ],
  );
}