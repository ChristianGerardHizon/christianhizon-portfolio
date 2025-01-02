import 'package:flutter/material.dart';
import 'package:gym_system/src/features/users/domain/user.dart';
import 'package:gym_system/src/features/users/presentation/controllers/user_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class UserBuilder extends HookConsumerWidget {
  final String id;
  final Widget Function(User) builder;

  const UserBuilder({super.key, required this.id, required this.builder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userControllerProvider(id));
    return state.when(
      data: builder,
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const SizedBox(),
    );
  }
}
