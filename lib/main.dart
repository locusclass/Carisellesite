import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LiquidGlassWidgets.initialize();
  runApp(LiquidGlassWidgets.wrap(const CariselleApp(), adaptiveQuality: true));
}

class CariselleApp extends StatelessWidget {
  const CariselleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassTheme(
      data: GlassThemeData(
        light: GlassThemeVariant(
          settings: GlassThemeSettings(thickness: 28, blur: 14),
          quality: GlassQuality.standard,
        ),
        dark: GlassThemeVariant(
          settings: GlassThemeSettings(thickness: 48, blur: 20),
          quality: GlassQuality.premium,
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cariselle Technologies',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          fontFamily: 'Arial',
          scaffoldBackgroundColor: const Color(0xFF05060A),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF7C5CFF),
            brightness: Brightness.dark,
          ),
        ),
        home: const CariselleHomePage(),
      ),
    );
  }
}

class CariselleHomePage extends StatefulWidget {
  const CariselleHomePage({super.key});

  @override
  State<CariselleHomePage> createState() => _CariselleHomePageState();
}

class _CariselleHomePageState extends State<CariselleHomePage> {
  final ScrollController _scrollController = ScrollController();

  final sections = const [
    _NavItem('Home', Icons.home_rounded),
    _NavItem('Services', Icons.auto_awesome_rounded),
    _NavItem('Products', Icons.apps_rounded),
    _NavItem('Contact', Icons.call_rounded),
  ];

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return GlassBackdropScope(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: GlassAppBar(
          quality: GlassQuality.premium,
          title: Row(
            children: [
              const _LogoMark(size: 34),
              const SizedBox(width: 12),
              Text(
                'Cariselle Technologies',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
              ),
            ],
          ),
          actions: [
            if (MediaQuery.sizeOf(context).width > 720)
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Row(
                  children: sections
                      .asMap()
                      .entries
                      .map((entry) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: GlassChip(
                              selected: selected == entry.key,
                              label: Text(entry.value.label),
                              onTap: () => setState(() => selected = entry.key),
                            ),
                          ))
                      .toList(),
                ),
              ),
          ],
        ),
        bottomNavigationBar: MediaQuery.sizeOf(context).width <= 720
            ? GlassBottomBar(
                selectedIndex: selected,
                onTabSelected: (index) => setState(() => selected = index),
                tabs: sections
                    .map((item) => GlassBottomBarTab(
                          label: item.label,
                          icon: Icon(item.icon),
                        ))
                    .toList(),
              )
            : null,
        body: Stack(
          children: [
            const _AnimatedAuroraBackground(),
            CustomScrollView(
              controller: _scrollController,
              slivers: const [
                SliverToBoxAdapter(child: SizedBox(height: 96)),
                SliverToBoxAdapter(child: _HeroSection()),
                SliverToBoxAdapter(child: _MetricsRibbon()),
                SliverToBoxAdapter(child: _ServicesSection()),
                SliverToBoxAdapter(child: _ProductSection()),
                SliverToBoxAdapter(child: _WhyCariselleSection()),
                SliverToBoxAdapter(child: _ContactSection()),
                SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width > 900;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: wide
              ? Row(
                  children: const [
                    Expanded(flex: 6, child: _HeroCopy()),
                    SizedBox(width: 28),
                    Expanded(flex: 5, child: _HeroGlassDevice()),
                  ],
                )
              : const Column(
                  children: [
                    _HeroCopy(),
                    SizedBox(height: 24),
                    _HeroGlassDevice(),
                  ],
                ),
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy();

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      quality: GlassQuality.premium,
      settings: const LiquidGlassSettings(
        blur: 22,
        thickness: 54,
        specularSharpness: GlassSpecularSharpness.sharp,
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlassBadge(
              child: const Text('Kampala-based technology firm'),
            ),
            const SizedBox(height: 22),
            Text(
              'Digital products engineered for Africa’s next operating system.',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: MediaQuery.sizeOf(context).width < 600 ? 38 : 58,
                    height: 0.98,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2.5,
                  ),
            ),
            const SizedBox(height: 20),
            Text(
              'Cariselle Technologies builds premium software platforms, business systems, and market-ready digital products for ambitious companies, creators, and institutions.',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white.withOpacity(0.78),
                    height: 1.55,
                  ),
            ),
            const SizedBox(height: 28),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                GlassButton(
                  onTap: () {},
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.rocket_launch_rounded),
                      SizedBox(width: 10),
                      Text('Start a project'),
                    ],
                  ),
                ),
                GlassButton(
                  onTap: () {},
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.explore_rounded),
                      SizedBox(width: 10),
                      Text('Explore services'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroGlassDevice extends StatelessWidget {
  const _HeroGlassDevice();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.72,
      child: GlassContainer(
        quality: GlassQuality.premium,
        settings: const LiquidGlassSettings(
          blur: 24,
          thickness: 60,
          specularSharpness: GlassSpecularSharpness.sharp,
        ),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              Row(
                children: [
                  const _LogoMark(size: 38),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Cariselle Console',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  GlassIconButton(
                    icon: const Icon(Icons.auto_graph_rounded),
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.05,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  children: const [
                    _MiniGlassTile('Apps', 'Multi-platform', Icons.apps_rounded),
                    _MiniGlassTile('Cloud', 'Railway + Firebase', Icons.cloud_done_rounded),
                    _MiniGlassTile('Payments', 'Escrow-ready', Icons.payments_rounded),
                    _MiniGlassTile('AI Ops', 'Human + AI teams', Icons.smart_toy_rounded),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              GlassCard(
                quality: GlassQuality.standard,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.verified_rounded, size: 34),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          'Premium software, product strategy, and scalable digital infrastructure.',
                          style: TextStyle(color: Colors.white.withOpacity(0.82), height: 1.35),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricsRibbon extends StatelessWidget {
  const _MetricsRibbon();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
          child: Wrap(
            spacing: 14,
            runSpacing: 14,
            alignment: WrapAlignment.center,
            children: const [
              _MetricCard('01', 'Product design'),
              _MetricCard('02', 'Web & mobile apps'),
              _MetricCard('03', 'Cloud deployment'),
              _MetricCard('04', 'Business automation'),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServicesSection extends StatelessWidget {
  const _ServicesSection();

  @override
  Widget build(BuildContext context) {
    final services = const [
      _Service('Software Development', 'End-to-end web, mobile, desktop, and backend systems.', Icons.code_rounded),
      _Service('Digital Platforms', 'Marketplaces, dashboards, portals, escrow systems, and admin consoles.', Icons.dashboard_customize_rounded),
      _Service('Cloud & Deployment', 'Firebase, Railway, PostgreSQL, CI/CD, hosting, and production rollout.', Icons.cloud_sync_rounded),
      _Service('Product Strategy', 'From idea shaping to launch architecture, monetization, and growth systems.', Icons.hub_rounded),
    ];

    return _SectionShell(
      eyebrow: 'What we build',
      title: 'Services shaped for serious digital execution.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = constraints.maxWidth > 900 ? 4 : constraints.maxWidth > 560 ? 2 : 1;
          return GridView.count(
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: crossAxisCount == 1 ? 2.8 : 1.05,
            children: services
                .map((service) => GlassCard(
                      quality: GlassQuality.standard,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(service.icon, size: 34),
                            const Spacer(),
                            Text(
                              service.title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              service.description,
                              style: TextStyle(color: Colors.white.withOpacity(0.72), height: 1.35),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}

class _ProductSection extends StatelessWidget {
  const _ProductSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Products & ventures',
      title: 'Built for the next wave of African digital markets.',
      child: GlassPanel(
        quality: GlassQuality.premium,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Wrap(
            spacing: 18,
            runSpacing: 18,
            children: const [
              _ProductPill('Prime Status', 'WhatsApp status marketing with escrow verification.'),
              _ProductPill('Viva', 'Mass community media, collaborative capture, and creator monetization.'),
              _ProductPill('Custom Systems', 'Tailored platforms for enterprises, startups, and institutions.'),
            ],
          ),
        ),
      ),
    );
  }
}

class _WhyCariselleSection extends StatelessWidget {
  const _WhyCariselleSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Why Cariselle',
      title: 'We combine speed, product taste, and operational systems.',
      child: Column(
        children: const [
          _TimelineItem('01', 'Premium UI first', 'Every product starts with trust, clarity, and a polished customer experience.'),
          _TimelineItem('02', 'Launch architecture', 'We design for shipping fast without ignoring scale, security, and maintainability.'),
          _TimelineItem('03', 'Africa-aware systems', 'Payments, admin structures, local markets, and multi-country expansion are built into the thinking.'),
        ],
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  const _ContactSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Contact',
      title: 'Build your next platform with Cariselle Technologies.',
      child: GlassPanel(
        quality: GlassQuality.premium,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Wrap(
            spacing: 18,
            runSpacing: 18,
            children: const [
              _ContactCard(Icons.location_on_rounded, 'Location', 'Kampala, Uganda'),
              _ContactCard(Icons.phone_rounded, 'Phone', '+256 787 157187'),
              _ContactCard(Icons.public_rounded, 'Web', 'cariselle.com'),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.eyebrow,
    required this.title,
    required this.child,
  });

  final String eyebrow;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eyebrow.toUpperCase(),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.58),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.2,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.2,
                    ),
              ),
              const SizedBox(height: 24),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoMark extends StatelessWidget {
  const _LogoMark({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: size,
      height: size,
      radius: size * 0.34,
      quality: GlassQuality.premium,
      child: Center(
        child: Text(
          'C',
          style: TextStyle(
            fontSize: size * 0.52,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.0,
          ),
        ),
      ),
    );
  }
}

class _MiniGlassTile extends StatelessWidget {
  const _MiniGlassTile(this.title, this.subtitle, this.icon);
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      quality: GlassQuality.minimal,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            const Spacer(),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
            Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.64), fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard(this.number, this.label);
  final String number;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      quality: GlassQuality.minimal,
      child: SizedBox(
        width: 250,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Text(number, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 26)),
              const SizedBox(width: 14),
              Expanded(child: Text(label, style: TextStyle(color: Colors.white.withOpacity(0.76)))),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductPill extends StatelessWidget {
  const _ProductPill(this.title, this.description);
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      quality: GlassQuality.standard,
      child: SizedBox(
        width: 330,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
              const SizedBox(height: 10),
              Text(description, style: TextStyle(color: Colors.white.withOpacity(0.74), height: 1.4)),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem(this.number, this.title, this.description);
  final String number;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GlassListTile(
        leading: GlassBadge(child: Text(number)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
        subtitle: Text(description),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard(this.icon, this.title, this.value);
  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      quality: GlassQuality.standard,
      child: SizedBox(
        width: 330,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Icon(icon, size: 32),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(color: Colors.white.withOpacity(0.58), fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(value, style: const TextStyle(fontWeight: FontWeight.w900)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedAuroraBackground extends StatelessWidget {
  const _AnimatedAuroraBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF05060A),
                  Color(0xFF0A1022),
                  Color(0xFF080912),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -140,
          left: -100,
          child: _BlurOrb(size: 360, color: const Color(0xFF3366FF).withOpacity(0.48)),
        ),
        Positioned(
          top: 40,
          right: -150,
          child: _BlurOrb(size: 420, color: const Color(0xFFD65BFF).withOpacity(0.35)),
        ),
        Positioned(
          bottom: 120,
          left: 80,
          child: _BlurOrb(size: 320, color: const Color(0xFF00E5FF).withOpacity(0.18)),
        ),
      ],
    );
  }
}

class _BlurOrb extends StatelessWidget {
  const _BlurOrb({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}

class _Service {
  const _Service(this.title, this.description, this.icon);
  final String title;
  final String description;
  final IconData icon;
}

class _NavItem {
  const _NavItem(this.label, this.icon);
  final String label;
  final IconData icon;
}