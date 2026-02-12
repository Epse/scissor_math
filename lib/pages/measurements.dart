import 'package:flutter/material.dart';
import 'package:scissor_math/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scissor_math/widgets/app_bar.dart';
import 'package:scissor_math/widgets/drawer.dart';
import 'package:scissor_math/widgets/measurements/new_modal.dart';

import '../data/database.dart';

final _measurementsProvider = StreamProvider((ref) {
  final database = ref.watch(Database.provider);
  return database.all();
});

class MeasurementScreen extends ConsumerWidget {
  const MeasurementScreen({super.key});

  Widget _measurementRow(WidgetRef ref, Measurement measurement) {
    return ListTile(
      title: Text(measurement.name),
      subtitle: Text(measurement.value.toStringAsFixed(1)),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          final database = ref.watch(Database.provider);
          database.deleteMeasurement(measurement.id);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Measurement>> measurements =
        ref.watch(_measurementsProvider);
    return Scaffold(
      appBar: appBar(context),
      drawer: MyDrawer(
        thisRoute: "/measurements",
      ),
      body: SafeArea(
          child: ListView(
              children: measurements.when(
                  data: (measurements) =>
                      measurements.map((m) => _measurementRow(ref, m)).toList(),
                  error: (error, stack) =>
                      [Text("${AppLocalizations.of(context)!.error}: $error")],
                  loading: () =>
                      [Text(AppLocalizations.of(context)!.loading)]))),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            newMeasurement(context);
          },
          child: Icon(Icons.add)),
    );
  }
}
