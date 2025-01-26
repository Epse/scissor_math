import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scissor_math/widgets/app_bar.dart';
import 'package:scissor_math/widgets/drawer.dart';

import '../data/database.dart';

final _measurementsProvider = StreamProvider((ref) {
  final database = ref.watch(Database.provider);
  return database.all();
});

class MeasurementScreen extends ConsumerWidget {
  const MeasurementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Measurement>> _measurements =
        ref.watch(_measurementsProvider);
    return Scaffold(
      appBar: appBar(context),
      drawer: MyDrawer(thisRoute: "/measurements",),
      body: ListView(
          children: _measurements.when(
              data: (measurements) => measurements.map((m) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(m.name),
                          Text(m.value.toStringAsFixed(1)),
                        ]);
                  }).toList(),
              error: (error, stack) => [Text("Error: $error")],
              loading: () => [Text("Loading...")])),
    );
  }
}
