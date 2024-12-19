import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:intl/intl.dart';

class DateTimeFormField extends HookConsumerWidget {
  final String startName;
  final String endName;
  final bool enabled;
  final InputDecoration durationDecoration;
  final InputDecoration startDecoration;
  final InputDecoration endDecoration;
  final dynamic Function(DateTime?)? startValueTransformer;
  final dynamic Function(DateTime?)? endValueTransformer;
  final String? Function(DateTime?)? startValidator;
  final String? Function(DateTime?)? endValidator;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String duration;

  const DateTimeFormField({
    super.key,
    required this.startName,
    required this.endName,
    required this.duration,
    this.enabled = true,
    this.startValueTransformer,
    this.endValueTransformer,
    this.firstDate,
    this.lastDate,
    this.startValidator,
    this.endValidator,
    this.durationDecoration = const InputDecoration(),
    this.startDecoration = const InputDecoration(),
    this.endDecoration = const InputDecoration(),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // onChange() {
    //   final form = FormBuilder.of(context);
    //   var start = form?.instantValue[startName];
    //   if (start is String) {
    //     try {
    //       start = DateTime.tryParse(start);
    //     } catch (e) {
    //       AppSnackBar.root(message: 'Failed to parse start date');
    //     }
    //   }
    //   final duration = form?.instantValue['_duration'];
    //   if (start is DateTime && duration is int) {
    //     final startCopy = start.copyWith();
    //     startCopy.add(Duration(days: 1));
    //     final end = startCopy
    //         .add(Duration(hours: duration));
    //     form?.fields[endName]?.didChange(end);
    //   } else {
    //     AppSnackBar.root(message: 'Something went wrong...');
    //   }
    // }

    final startFoucs = useFocusNode();
    final endFoucs = useFocusNode();

    return Column(
      children: [
        FormBuilderDateTimePicker(
          autofocus: false,
          focusNode: startFoucs,
          name: startName,
          enabled: enabled,
          decoration: startDecoration.copyWith(
            suffix: IconButton(
              icon: Icon(MIcons.calendar),
              onPressed: () {
                startFoucs.requestFocus();
              },
            ),
          ),
          valueTransformer: startValueTransformer,
          validator: startValidator,
          format: DateFormat('MMM d, yyyy h:mm a'),
          // onChanged: (x) => onChange(),
          firstDate: firstDate,
          lastDate: lastDate,
          currentDate: DateTime.now(),
        ),
        SizedBox(height: 16),
        FormBuilderDateTimePicker(
          name: endName,
          focusNode: endFoucs,
          autofocus: false,
          enabled: true,
          decoration: endDecoration.copyWith(
            suffix: IconButton(
              icon: Icon(MIcons.calendar),
              onPressed: () {
                endFoucs.requestFocus();
              },
            ),
          ),
          valueTransformer: endValueTransformer,

          // validator: endValidator,
          format: DateFormat('MMM d, yyyy h:mm a'),
        ),
        // FormBuilderDropdown<int>(
        //   name: duration,
        //   onChanged: (x) => onChange(),
        //   decoration: durationDecoration.copyWith(
        //     labelText: 'Duration',
        //   ),
        //   items: List.generate(24, (index) => index + 1)
        //       .map((e) => DropdownMenuItem<int>(
        //             value: e,
        //             child: Text('$e hour${e > 1 ? 's' : ''}'),
        //           ))
        //       .toList(),
        // ),
      ],
    );
  }
}
