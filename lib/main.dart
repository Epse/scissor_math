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
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 221, 86)),
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
  double measurement = 0.0;
  double radius = 0.0;

  double _lutterlohCorrection(double measurement) {
    return 7 * (measurement - 96.0) / 46.0;
  }

  double _lutterloh(double measurement, double radius) {
    return radius + _lutterlohCorrection(measurement);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(AppLocalizations.of(context)!.appTitle),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(spacing: 16.0, children: [
            Text(AppLocalizations.of(context)!.lSystem,
                style: Theme.of(context).textTheme.headlineLarge),
            Padding(padding: EdgeInsets.all(16.0)),
            TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)!.measurementHipBust,
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (String input) {
                  setState(() {
                    measurement = double.tryParse(input) ?? 0;
                  });
                }),
            Text(
                AppLocalizations.of(context)!.correction(
                    _lutterlohCorrection(measurement).toStringAsFixed(1), "cm"),
                style: Theme.of(context).textTheme.titleMedium),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.patternRadius,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (String input) {
                setState(() {
                  radius = double.tryParse(input) ?? 0;
                });
              },
            ),
            Text(
                AppLocalizations.of(context)!.result(
                    "cm", _lutterloh(measurement, radius).toStringAsFixed(1)),
                style: Theme.of(context).textTheme.titleLarge)
          ]),
        ));
  }
}
