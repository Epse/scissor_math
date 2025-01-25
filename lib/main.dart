import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:scissor_math/data/database.dart';
import 'package:scissor_math/pages/lutterloh.dart';

void main() {
  runApp(
    Provider<Database>(
      create: (context) => Database(),
      child: const MyApp(),
      dispose: (context, db) => db.close(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) {
        return AppLocalizations.of(context)!.appTitle;
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 255, 221, 86),
            //seedColor: Color.fromARGB(255, 255, 225, 112),
            dynamicSchemeVariant: DynamicSchemeVariant.fidelity),
        useMaterial3: true,
      ),
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        "/": (context) => const LutterlohScreen(),
      },
    );
  }
}
