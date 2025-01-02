import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gym_system/src/core/widgets/form_builders/custom_form_field.dart';
import 'package:gym_system/src/features/users/data/user_repository.dart';
import 'package:gym_system/src/features/users/domain/user.dart';
import 'package:gym_system/src/features/users/presentation/widgets/user_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:searchfield/searchfield.dart';

class UserFormField extends HookConsumerWidget {
  final String name;
  final bool enabled;
  final Function(User?)? onChanged;
  final dynamic Function(User)? valueTransformer;

  const UserFormField({
    super.key,
    this.enabled = true,
    required this.name,
    this.onChanged,
    this.valueTransformer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<List<User>> search(String? query) async {
      final repo = ref.read(userRepositoryProvider);
      final result = await repo
          .list(query: 'name ~ "$query"', pageNo: 1, pageSize: 10)
          .run();
      return result.fold(Future.error, (r) => Future.value(r.items));
    }

    return CustomFormField<User>(
      name: name,
      enabled: enabled,
      onChanged: onChanged,
      onSearch: search,
      hint: 'User',
      valueTransformer: (p0) {
        final value = p0;
        if (value is User) return valueTransformer?.call(value);
      },
      selectedBuilder: (p0, controller) => ListTile(
        leading: ClipOval(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 50, maxHeight: 50),
            child: UserImage(user: p0, width: 50),
          ),
        ),
        title: Text(p0.name),
        trailing: !enabled
            ? SizedBox()
            : IconButton(
                onPressed: () {
                  FormBuilder.of(context)?.fields[name]?.didChange(null);
                  controller.clear();
                },
                icon: const Icon(Icons.close),
              ),
      ),
      onChild: (p0) => SearchFieldListItem<User>(
        p0.id,
        item: p0,
        child: Text(p0.name),
      ),
    );
  }
}
