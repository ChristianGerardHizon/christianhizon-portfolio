import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

class FormTypeaheadCustom extends HookWidget {
  final String name;
  final bool allowCustomInput;
  final InputDecoration decoration;
  final Widget Function(BuildContext, String) itemBuilder;
  final FutureOr<List<String>?> Function(String) suggestionsCallback;
  final Function()? onAdd;
  const FormTypeaheadCustom({
    required this.name,
    super.key,
    this.decoration = const InputDecoration(),
    required this.itemBuilder,
    this.allowCustomInput = true,
    this.onAdd,
    required this.suggestionsCallback,
  });
  @override
  Widget build(BuildContext context) {
    return FormBuilderTypeAhead(
      decoration: decoration,
      suggestionsCallback: suggestionsCallback,
      listBuilder: (ctxt, list) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return list[index];
              },
            ),
            ListTile(
              onTap: () => onAdd?.call(),
              trailing: Icon(Icons.add),
              title: Text('Add new item'),
            )
          ],
        );
      },
      itemBuilder: itemBuilder,
      name: name,
    );
  }
}
