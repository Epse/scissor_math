import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppBar appBar(BuildContext context, {String? title}) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    title: title != null ? Text(title) : Text(AppLocalizations.of(context)!.appTitle),
  );
}
