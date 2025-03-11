import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gym_system/src/core/widgets/form_builders/custom_form_field.dart';
import 'package:gym_system/src/core/widgets/form_builders/toggle_field_item.dart';
import 'package:gym_system/src/features/treatments/data/treatment/treatment_repository.dart';
import 'package:gym_system/src/features/treatments/domain/treatment.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TreatmentFormField extends HookConsumerWidget {
  final String name;
  final Function(Treatment?)? onChanged;
  final dynamic Function(Treatment)? valueTransformer;
  final String? Function(Treatment?)? validator;

  final bool readOnly;

  const TreatmentFormField({
    super.key,
    required this.name,
    this.onChanged,
    this.valueTransformer,
    this.readOnly = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<List<Treatment>> search(String? query) async {
      if (query == null) return [];
      if (query.isEmpty) return [];
      final repo = ref.read(historyTypeRepositoryProvider);
      final result = await repo
          .list(
              pageNo: 1,
              pageSize: 5,
              filter: 'name ~ "$query" && isDeleted = false')
          .map((x) => x.items)
          .run();
      return result.fold(Future.error, Future.value);
    }

    return CustomSearchFormField<Treatment>(
      name: name,
      enabled: readOnly,
      validator: validator,
      onChanged: onChanged,
      onSearch: search,
      onChild: (item) {
        return (item.name, Text(item.name));
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      valueTransformer: (p0) {
        final value = p0;
        if (value is Treatment) return valueTransformer?.call(value);
      },
      selectedBuilder: (p0, controller, widget) => ToggleFieldItem.card(
        readOnly: readOnly,
        padding: EdgeInsets.only(top: 8, bottom: 8),
        leading: CircleAvatar(),
        title: Text(
          p0.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        onCancel: () {
          FormBuilder.of(context)?.fields[name]?.didChange(null);
          controller.clear();
        },
      ),
    );
  }
}
