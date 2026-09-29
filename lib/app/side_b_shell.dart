import 'package:flutter/material.dart';
import 'package:side_b/core/localization/app_localizations.dart';
import 'package:side_b/features/discover/presentation/discover_screen.dart';
import 'package:side_b/features/map/presentation/map_screen.dart';
import 'package:side_b/features/saved/application/saved_venues_controller.dart';
import 'package:side_b/features/saved/presentation/saved_screen.dart';

class SideBShell extends StatefulWidget {
  const SideBShell({
    required this.savedVenues,
    required this.locale,
    required this.onLocaleChanged,
    super.key,
  });

  final SavedVenuesController savedVenues;
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  State<SideBShell> createState() => _SideBShellState();
}

class _SideBShellState extends State<SideBShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: _index,
          children: [
            DiscoverScreen(
              savedVenues: widget.savedVenues,
              locale: widget.locale,
              onLocaleChanged: widget.onLocaleChanged,
              onOpenMap: () => setState(() => _index = 1),
            ),
            MapScreen(
              savedVenues: widget.savedVenues,
              locale: widget.locale,
              onLocaleChanged: widget.onLocaleChanged,
            ),
            SavedScreen(
              savedVenues: widget.savedVenues,
              locale: widget.locale,
              onLocaleChanged: widget.onLocaleChanged,
              onBrowse: () => setState(() => _index = 0),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ColoredBox(
        color: Theme.of(context).navigationBarTheme.backgroundColor!,
        child: SafeArea(
          top: false,
          child: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (index) => setState(() => _index = index),
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.explore_outlined),
                selectedIcon: const Icon(Icons.explore),
                label: copy.t('discover'),
              ),
              NavigationDestination(
                icon: const Icon(Icons.map_outlined),
                selectedIcon: const Icon(Icons.map),
                label: copy.t('map'),
              ),
              NavigationDestination(
                icon: const Icon(Icons.bookmark_border),
                selectedIcon: const Icon(Icons.bookmark),
                label: copy.t('saved'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
