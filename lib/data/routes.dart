import 'package:flutter/material.dart' hide Route;
import 'package:scissor_math/l10n/app_localizations.dart';
import 'package:scissor_math/pages/measurements.dart';
import '../pages/lutterloh.dart';

typedef LocalizedBuilder = String Function(BuildContext context);

class Route {
  final String route;
  final LocalizedBuilder name;
  final WidgetBuilder builder;
  final IconData icon;

  Route(this.route, this.name, this.builder, {this.icon = Icons.question_mark});
}

final List<Route> routes = [
  Route("/", (BuildContext context) => AppLocalizations.of(context)!.lSystem, (_) => const LutterlohScreen(), icon: Icons.home),
  Route("/measurements", (BuildContext context) => AppLocalizations.of(context)!.measurements, (_) => const MeasurementScreen(), icon: Icons.list),
];
final Map<String, WidgetBuilder> routables = { for (var r in routes) r.route : r.builder };
