import 'package:flutter/material.dart';
import 'package:guatini/pages/about_page.dart';
import 'package:guatini/pages/advancedsearch_page.dart';
import 'package:guatini/pages/settings_page.dart';

class _Route {
  final bool mainPage;
  final IconData icon;
  final String title;
  final Widget page;

  _Route(this.mainPage, this.icon, this.title, this.page);
}

final drawerPagesRoutes = <_Route>[
  _Route(
    false,
    Icons.manage_search_rounded,
    const AdvancedSearchPage().pageTitle,
    const AdvancedSearchPage(),
  ),
  _Route(
    false,
    Icons.settings_rounded,
    const SettingsPage().pageTitle,
    const SettingsPage(),
  ),
  _Route(
    false,
    Icons.info_outline_rounded,
    const AboutPage().pageTitle,
    const AboutPage(),
  ),
];
