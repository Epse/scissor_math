import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scissor_math/widgets/app_bar.dart';
import 'package:scissor_math/widgets/drawer.dart';
import 'package:scissor_math/widgets/measurements/measurement_field.dart';

class LutterlohScreen extends StatefulWidget {
  const LutterlohScreen({super.key});

  @override
  State<LutterlohScreen> createState() => _LutterlohScreenState();
}

class _LutterlohScreenState extends State<LutterlohScreen> {
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
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: appBar(context),
        drawer: MyDrawer(
          thisRoute: "/",
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SafeArea(
              child: ListView(children: [
            Text(loc.lSystem, style: Theme.of(context).textTheme.headlineLarge),
            Padding(padding: EdgeInsets.all(16.0)),
            MeasurementField(
                labelText: loc.measurementHipBust,
                onChanged: (String input) {
                  setState(() {
                    measurement = double.tryParse(input) ?? 0;
                  });
                }),
            Padding(padding: EdgeInsets.all(8.0)),
            Text(
                loc.correction(
                    _lutterlohCorrection(measurement).toStringAsFixed(1), "cm"),
                style: Theme.of(context).textTheme.titleMedium),
            Padding(padding: EdgeInsets.all(8.0)),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                helperText: loc.radiusHelper,
                labelText: loc.patternRadius,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (String input) {
                setState(() {
                  radius = double.tryParse(input) ?? 0;
                });
              },
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Text(
                loc.result(
                    "cm", _lutterloh(measurement, radius).toStringAsFixed(1)),
                style: Theme.of(context).textTheme.titleLarge)
          ])),
        ));
  }
}
