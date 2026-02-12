import 'package:drift/drift.dart' show Value;
import 'package:scissor_math/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scissor_math/data/database.dart';

Future<void> newMeasurement(BuildContext context) {
  return showDialog<void>(
      context: context, builder: (BuildContext context) => NewModal());
}

class NewModal extends ConsumerStatefulWidget {
  const NewModal({super.key});

  @override
  ConsumerState<NewModal> createState() => _NewModalState();
}

class _NewModalState extends ConsumerState<NewModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final database = ref.watch(Database.provider);
    final loc = AppLocalizations.of(context)!;

    return Dialog(
        child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Form(
                key: _formKey,
                child: ListView(
                    children: [
                      Text(loc.saveMeasurement,
                          style: Theme.of(context).textTheme.headlineMedium),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: numberController,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: loc.measurement,
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return loc.errorEnterText;
                          }
                          if (double.tryParse(value) == null) {
                            return loc.errorEnterNumber;
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: loc.nameThisMeasurement,
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return loc.errorEnterText;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text(loc.cancel),
                            onPressed: () => {Navigator.pop(context)},
                          ),
                          TextButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }

                              final parsed =
                                  double.parse(numberController.value.text);

                              database
                                  .addMeasurement(MeasurementsCompanion(
                                      name: Value(controller.value.text),
                                      value: Value(parsed)))
                                  .then((int saved) {
                                Navigator.pop(context);
                              });
                            },
                            child: Text(loc.save),
                          )
                        ],
                      )
                    ]))));
  }
}
