import 'package:flutter/material.dart';
import 'package:repeater/screens/home/home_screen.dart';
import 'package:repeater/screens/notes/notes_screen.dart';
import 'package:repeater/screens/settings/settings_screen.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/l10n/app_localizations.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int index = 0;

  static const _screens = [
    HomeScreen(),
    NotesScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      bottomNavigationBar: (width < Styles.largeBreakpoint)
          ? NavigationBar(
              selectedIndex: index,
              onDestinationSelected: (value) => setState(() => index = value),
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home),
                  label: AppLocalizations.of(context)!.home,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.note_outlined),
                  selectedIcon: const Icon(Icons.note),
                  label: AppLocalizations.of(context)!.notes,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.settings_outlined),
                  selectedIcon: const Icon(Icons.settings),
                  label: AppLocalizations.of(context)!.settings,
                ),
              ],
            )
          : null,
      body: Row(
        children: [
          if (width >= Styles.largeBreakpoint)
            NavigationRail(
              selectedIndex: index,
              onDestinationSelected: (value) => setState(() => index = value),
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              labelType: NavigationRailLabelType.all,
              destinations: [
                NavigationRailDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home),
                  label: Text(AppLocalizations.of(context)!.home),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.note_outlined),
                  selectedIcon: const Icon(Icons.note),
                  label: Text(AppLocalizations.of(context)!.notes),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.settings_outlined),
                  selectedIcon: const Icon(Icons.settings),
                  label: Text(AppLocalizations.of(context)!.settings),
                ),
              ],
            ),
          Expanded(child: _screens[index]),
        ],
      ),
    );
  }
}
