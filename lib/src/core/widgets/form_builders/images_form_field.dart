import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImagesFormField extends HookConsumerWidget {
  const ImagesFormField({
    super.key,
    required this.name,
    required this.domain,
    this.onDelete,
  });

  final String name;
  final String domain;
  final Function(int)? onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormBuilderField(
        name: name,
        builder: (field) {
          final value = field.value;

          if (value is List) {
            final widgets = value.mapWithIndex((fieldValue, index) {
              if (fieldValue is String) {
                return Stack(
                  children: [
                    ///
                    /// Image
                    ///
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.network(
                        '$domain/$fieldValue',
                        height: 100,
                      ),
                    ),

                    ///
                    /// Delete Icon
                    ///
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          onDelete?.call(index);
                        },
                      ),
                    ),
                  ],
                );
              }
              return SizedBox();
            }).toList();
            return Row(children: widgets);
          }

          return SizedBox();
        });
  }
}
