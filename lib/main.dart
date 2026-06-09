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
    // Attempt to launch natively
    final bool launched = await launchUrl(url, mode: LaunchMode.platformDefault);
    
    // Fallback: If native mailto fails, open web-based Gmail composition
    if (!launched && urlString.startsWith('mailto:')) {
      final String webGmail = 'https://mail.google.com/mail/?view=cm&fs=1&to=adeyemifortuneadeboye@gmail.com&su=Project%20Inquiry';
      await launchUrl(Uri.parse(webGmail), mode: LaunchMode.externalApplication);
    }
  } catch (e) {
    // Hard fallback for strict browsers or environments that throw an error
    if (urlString.startsWith('mailto:')) {
      final String webGmail = 'https://mail.google.com/mail/?view=cm&fs=1&to=adeyemifortuneadeboye@gmail.com&su=Project%20Inquiry';
      await launchUrl(Uri.parse(webGmail), mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $urlString: $e');
    }
  }
}

// ─── CUSTOM HOVER AND FLOATING EFFECT WRAPPER ────────────────────────────────
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
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()..translate(0, _isHovered ? -8.0 : 0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _isHovered 
                    ? const Color(0xFF378ADD).withValues(alpha: 0.25)
                    : Colors.transparent,
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

// ─── FADE ANIMATION WRAPPER ───────────────────────────────────────────────────
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
      duration: const Duration(milliseconds: 700),
    );
    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

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

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 120 : 24,
        vertical: isDesktop ? 100 : 60,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A1628), Color(0xFF0D2137)],
        ),
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
    );
  }

  List<Widget> _heroContent(bool isDesktop) {
    return [
      FadeSlideIn(
        delayMs: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF378ADD).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: const Color(0xFF378ADD).withValues(alpha: 0.3)),
          ),
          child: const Text(
            '⚡   AVAILABLE FOR REMOTE WORK',
            style: TextStyle(
              color: Color(0xFF378ADD),
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
      const SizedBox(height: 24),
      FadeSlideIn(
        delayMs: 150,
        child: const Text(
          'Adeyemi Fortune\nAdeboye',
          style: TextStyle(
            color: Colors.white,
            fontSize: 52,
            fontWeight: FontWeight.bold,
            height: 1.2,
            letterSpacing: -1,
          ),
        ),
      ),
      const SizedBox(height: 12),
      FadeSlideIn(
        delayMs: 250,
        child: const Text(
          'Mobile Software Engineer',
          style: TextStyle(
            color: Color(0xFF378ADD),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      const SizedBox(height: 18),
      FadeSlideIn(
        delayMs: 350,
        child: Text(
          'Building production-grade Flutter applications with\nhybrid state management (Riverpod & BLoC),\nFirebase, and automated CI/CD pipelines.',
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 16,
            height: 1.6,
          ),
        ),
      ),
      const SizedBox(height: 36),
      FadeSlideIn(
        delayMs: 450,
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            // 1. PRIMARY BUTTON: Global Market Gold Standard (Email)
            HoverCard(
              onTap: () => _launchURL('mailto:adeyemifortuneadeboye@gmail.com?subject=Project%20Inquiry'),
              child: _button(
                label: "Let's Talk (Email) ✉️",
                icon: Icons.email_outlined,
                bg: const Color(0xFF378ADD),
                textColor: Colors.white,
              ),
            ),
            // 2. SECONDARY BUTTON: Resume Link Restored!
            HoverCard(
              onTap: () => _launchURL(
                  'https://drive.google.com/uc?export=download&id=12FerkMBUIjDo1hCcNy2pD4hezKuhbJzC'),
              child: _button(
                label: 'Download Resume',
                icon: Icons.download,
                bg: Colors.transparent,
                textColor: const Color(0xFF378ADD),
                border: true,
              ),
            ),
            // 3. SECONDARY BUTTON: Instant Messaging Alternative (WhatsApp)
            HoverCard(
              onTap: () => _launchURL('https://wa.me/2347053802331'),
              child: _button(
                label: 'Chat on WhatsApp',
                icon: Icons.chat_bubble_outline_rounded,
                bg: Colors.transparent,
                textColor: const Color(0xFF378ADD),
                border: true,
              ),
            ),
            // 4. SECONDARY BUTTON: Code Portfolio (GitHub)
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
            // 5. SECONDARY BUTTON: Video Demos (YouTube)
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
    return FadeSlideIn(
      delayMs: 200,
      child: Container(
        width: 260,
        height: 260,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFF0F0F0),
          border: Border.all(color: const Color(0xFF378ADD), width: 4),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF378ADD).withValues(alpha: 0.3),
              blurRadius: 40,
              spreadRadius: 8,
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/765FC03E-A429-4B36-8C0A-6C95D2C3B148.jpg.PNG',
            fit: BoxFit.cover,
            // Changed from -0.2 to 0.15 to pull your head down and add space at the top
            alignment: const Alignment(0, -0.5), 
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Text(
                  'AF',
                  style: TextStyle(
                    color: Color(0xFF0A1628),
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: border ? Border.all(color: const Color(0xFF378ADD)) : null,
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
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
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
        vertical: 60,
      ),
      color: const Color(0xFF0D2137),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeSlideIn(
            child: _sectionTitle('Core Expertise'),
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 3 : 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isDesktop ? 1.6 : 1.2,
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              final skill = skills[index];
              final isEmoji = skill['isEmoji'] as bool;

              return FadeSlideIn(
                delayMs: index * 80,
                child: HoverCard(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A1628),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF378ADD).withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isEmoji 
                          ? Text(skill['icon'] as String, style: const TextStyle(fontSize: 28))
                          : Icon(skill['icon'] as IconData, color: const Color(0xFF378ADD), size: 30),
                        const SizedBox(height: 8),
                        Text(
                          skill['title'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          skill['desc'] as String,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 12,
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

// ─── PROJECTS SECTION ─────────────────────────────────────────────────────────
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
        vertical: 60,
      ),
      color: const Color(0xFF0A1628),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeSlideIn(child: _sectionTitle('Featured Projects')),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 2 : 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              mainAxisExtent: 220,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final p = projects[index];
              final isEmoji = p['isEmoji'] as bool;

              return FadeSlideIn(
                delayMs: index * 80,
                child: HoverCard(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D2137),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF378ADD).withValues(alpha: 0.15),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            isEmoji 
                              ? Text(p['icon'] as String, style: const TextStyle(fontSize: 28))
                              : Icon(p['icon'] as IconData, color: const Color(0xFF378ADD), size: 30),
                            const Spacer(),
                            IconButton(
                              tooltip: 'GitHub',
                              icon: const Icon(Icons.code, color: Color(0xFF378ADD), size: 18),
                              onPressed: () => _launchURL(p['github'] as String),
                            ),
                            IconButton(
                              tooltip: 'Demo',
                              icon: const Icon(Icons.play_circle_outline, color: Color(0xFF378ADD), size: 18),
                              onPressed: () => _launchURL(p['demo'] as String),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          p['title'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          p['tech'] as String,
                          style: const TextStyle(
                            color: Color(0xFF378ADD),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            p['desc'] as String,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 13,
                              height: 1.5,
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

// ─── CONTACT SECTION ──────────────────────────────────────────────────────────
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 120 : 24,
        vertical: 60,
      ),
      color: const Color(0xFF0D2137),
      child: Column(
        children: [
          FadeSlideIn(child: _sectionTitle('Get In Touch')),
          const SizedBox(height: 16),
          FadeSlideIn(
            delayMs: 100,
            child: const Text(
              'Available for freelance projects and remote opportunities',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              FadeSlideIn(
                delayMs: 0,
                child: HoverCard(
                  onTap: () => _launchURL('mailto:adeyemifortuneadeboye@gmail.com?subject=Project%20Inquiry'),
                  child: _contactCard(icon: Icons.email_outlined, isEmoji: false, label: 'Email', value: 'adeyemifortuneadeboye@gmail.com'),
                ),
              ),
              FadeSlideIn(
                delayMs: 100,
                child: HoverCard(
                  onTap: () => _launchURL('https://wa.me/2347053802331'),
                  child: _contactCard(icon: Icons.phone_android_rounded, isEmoji: false, label: 'WhatsApp', value: '07053802331'),
                ),
              ),
              FadeSlideIn(
                delayMs: 200,
                child: HoverCard(
                  onTap: () => _launchURL('https://github.com/thefortune-tech'),
                  child: _contactCard(icon: Icons.code_rounded, isEmoji: false, label: 'GitHub', value: 'github.com/thefortune-tech'),
                ),
              ),
              FadeSlideIn(
                delayMs: 300,
                child: HoverCard(
                  onTap: () => _launchURL('https://youtube.com/@Fortune_Dev'),
                  child: _contactCard(icon: Icons.play_circle_fill_rounded, isEmoji: false, label: 'YouTube', value: '@Fortune_Dev'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          FadeSlideIn(
            delayMs: 400,
            child: const Text(
              '© 2026 Adeyemi Fortune Adeboye — Built with Flutter Web 💙',
              style: TextStyle(
                color: Colors.white30,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactCard({
    required dynamic icon, 
    required bool isEmoji, 
    required String label, 
    required String value,
  }) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1628),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF378ADD).withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          isEmoji 
            ? Text(icon as String, style: const TextStyle(fontSize: 28))
            : Icon(icon as IconData, color: const Color(0xFF378ADD), size: 32),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF378ADD),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
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

// ─── HELPER ───────────────────────────────────────────────────────────────────
Widget _sectionTitle(String text) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Container(
        width: 48,
        height: 4,
        decoration: BoxDecoration(
          color: const Color(0xFF378ADD),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    ],
  );
}