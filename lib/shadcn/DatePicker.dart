import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_flutter;

// ignore: must_be_immutable
class Datepicker extends StatefulWidget {
  DateTime? dateTime;
  final ValueChanged<DateTime?>? onValueChanged;
  Datepicker({super.key, required this.dateTime, this.onValueChanged});

  @override
  State<Datepicker> createState() => _DatapickerState();
}

class _DatapickerState extends State<Datepicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        shadcn_flutter.DatePicker(
          value: widget.dateTime,
          dialogTitle: const shadcn_flutter.Text('Ajouter une date'),
          mode: shadcn_flutter.PromptMode.popover,
          stateBuilder: (date) {
            if (date.isAfter(DateTime.now())) {
              return shadcn_flutter.DateState.disabled;
            }
            return shadcn_flutter.DateState.enabled;
          },
          onChanged: (value) {
            widget.onValueChanged!(value);
          },
        ),
        const shadcn_flutter.Gap(16),
        // shadcn_flutter.DatePicker(
        //   value: _value,
        //   mode: shadcn_flutter.PromptMode.dialog,
        //   dialogTitle: const Text('Select Date'),
        //   stateBuilder: (date) {
        //     if (date.isAfter(DateTime.now())) {
        //       return shadcn_flutter.DateState.disabled;
        //     }
        //     return shadcn_flutter.DateState.enabled;
        //   },
        //   onChanged: (value) {
        //     setState(() {
        //       _value = value;
        //     });
        //   },
        // ),
      ],
    );
  }
}
