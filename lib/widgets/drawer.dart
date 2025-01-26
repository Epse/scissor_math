import 'package:flutter/material.dart' hide Route;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scissor_math/data/routes.dart' show Route, routes;

class MyDrawer extends StatelessWidget {
  final String? thisRoute;

  const MyDrawer({this.thisRoute, super.key});

  Widget _navTile(BuildContext context, Route route) {
    return NavigationDrawerDestination(
        icon: Icon(route.icon), label: Text(route.name(context)));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> routeTiles =
        routes.map((r) => _navTile(context, r)).toList();

    final int? selectedIndex = thisRoute == null
        ? null
        : routes.indexWhere((r) => r.route == thisRoute);

    return NavigationDrawer(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int sel) {
          Navigator.pushNamed(context, routes[sel].route);
        },
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
              child: Text(AppLocalizations.of(context)!.appTitle,
                  style: Theme.of(context).textTheme.titleMedium)),
          ...routeTiles
        ]);
  }
}
