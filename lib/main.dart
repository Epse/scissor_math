import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double correction = 0.0;
  double result = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(AppLocalizations.of(context)!.appTitle),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(spacing: 16.0, children: [
            Text(AppLocalizations.of(context)!.lSystem,
                style: Theme.of(context).textTheme.titleLarge),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.measurementHipBust,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            Text(AppLocalizations.of(context)!
                .correction(correction.toString(), "cm")),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.patternRadius,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            Text(AppLocalizations.of(context)!.result("cm", result.toString()),
                style: Theme.of(context).textTheme.headlineMedium)
          ]),
        ));
  }
}
