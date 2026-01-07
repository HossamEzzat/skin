import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skin/features/disease/screens/disease_explorer_screen.dart';
import 'package:skin/features/home/screens/dashboard_screen.dart';
import 'package:skin/features/profile/screens/profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<IconData> _icons = const [
    Icons.house_rounded,
    Icons.search_rounded,
    FontAwesomeIcons.user,
  ];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      const Dashboard(key: PageStorageKey('dashboard')),
      const DiseaseExplorerScreen(key: PageStorageKey('disease_explorer')),
      const ProfileScreen(key: PageStorageKey('profile')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      /// Pages (state preserved)
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: _currentIndex, children: _pages),
      ),

      /// Bottom Navigation
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: _icons,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        iconSize: 24,
        height: 76,
        splashSpeedInMilliseconds: 250,
        activeColor: theme.colorScheme.primary,
        inactiveColor: theme.colorScheme.onSurface.withValues(alpha: 0.45),
        backgroundColor: theme.colorScheme.surface,
        onTap: (index) {
          HapticFeedback.lightImpact();
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
