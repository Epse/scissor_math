import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scissor_math/data/database.dart';

Future<void> saveMeasurement(BuildContext context, double value) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) => SaveModal(value: value));
}

class SaveModal extends ConsumerStatefulWidget {
  final double value;

  const SaveModal({required this.value, super.key});

  @override
  ConsumerState<SaveModal> createState() => _SaveModalState();
}

class _SaveModalState extends ConsumerState<SaveModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final database = ref.watch(Database.provider);

    return Dialog(
        child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Form(
                key: _formKey,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16.0,
                    children: [
                      Text("Store measurement",
                          style: Theme.of(context).textTheme.headlineMedium),
                      Text(
                        "Store measurement ${widget.value.toStringAsFixed(1)}",
                      ),
                      TextFormField(
                        controller: controller,
                        autofocus: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Name this measurement",
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text("Cancel"),
                            onPressed: () => {Navigator.pop(context)},
                          ),
                          TextButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }

                              database
                                  .addMeasurement(MeasurementsCompanion(
                                      name: Value(controller.value.text),
                                      value: Value(widget.value)))
                                  .then((int saved) {
                                Navigator.pop(context);
                              });
                            },
                            child: Text("Save"),
                          )
                        ],
                      )
                    ]))));
  }
}
