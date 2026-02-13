import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:scissor_math/data/database.dart';
import 'package:scissor_math/misc.dart';
import 'package:scissor_math/widgets/measurements/save_modal.dart';
import 'package:scissor_math/l10n/app_localizations.dart';

final _measurements = StreamProvider((ref) {
  final database = ref.watch(Database.provider);
  return database.all();
});

class MeasurementField extends ConsumerStatefulWidget {
  final String? labelText;
  final ValueChanged<String>? onChanged;

  const MeasurementField({this.labelText, super.key, this.onChanged});

  @override
  ConsumerState<MeasurementField> createState() => _MeasurementFieldState();
}

class _MeasurementFieldState extends ConsumerState<MeasurementField> {
  final TextEditingController textController = TextEditingController();
  final MenuController menuController = MenuController();

  List<Widget> _buildChoices(AsyncValue<List<Measurement>> asyncMeasurements,
      ValueChanged<String> onPressed) {
    return asyncMeasurements.when(
        data: (measurements) {
          return measurements
              .map((measurement) => MenuItemButton(
                    closeOnActivate: true,
                    onPressed: () {
                      onPressed(measurement.value.toStringAsFixed(0));
                    },
                    child: Text(
                        "${measurement.name}: ${measurement.value.toStringAsFixed(1)}cm"),
                  ))
              .toList();
        },
        error: (error, stack) {
          debugPrint("Could not load measurements, error $error");
          return [];
        },
        loading: () => []);
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Measurement>> measurements = ref.watch(_measurements);
    final loc = AppLocalizations.of(context)!;

    return Row(children: [
      Expanded(
          child: MenuAnchor(
        controller: menuController,
        menuChildren: _buildChoices(measurements, (String value) {
          textController.value = TextEditingValue(
              text: value,
              selection: TextSelection.collapsed(offset: value.length));
          menuController.close();
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        }),
        builder: (BuildContext context, MenuController menuController,
            Widget? child) {
          final Widget trailingButton = IconButton(
            //isSelected: controller.isOpen,
            //constraints: widget.inputDecorationTheme?.suffixIconConstraints,
            //padding: isCollapsed ? EdgeInsets.zero : null,
            icon: const Icon(Icons.arrow_drop_down),
            selectedIcon: const Icon(Icons.arrow_drop_up),
            onPressed: () {
              if (menuController.isOpen) {
                menuController.close();
              } else {
                menuController.open();
              }
            },
          );
          return TextField(
            controller: textController,
            keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
            onTap: () {
              menuController.open();
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: widget.labelText,
                prefixIcon: Icon(Icons.straighten),
                suffixIcon: trailingButton),
            inputFormatters: [NumberFormatter],
            onChanged: widget.onChanged,
          );
        },
      )),
      IconButton(onPressed: () {
        final parsed = double.tryParse(textController.value.text);
        if (parsed != null) {
          saveMeasurement(context, parsed);
        }
      }, icon: Icon(Icons.save),
        tooltip: loc.saveMeasurement,
      ),
    ]);
  }
}
