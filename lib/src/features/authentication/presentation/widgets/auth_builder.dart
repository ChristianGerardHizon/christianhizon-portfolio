import 'package:flutter/material.dart';
import 'package:gym_system/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:gym_system/src/features/user/domain/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class AuthBuilder extends HookConsumerWidget {
  final Widget Function(User) builder;

  const AuthBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);
    return state.when(
      data: builder,
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const SizedBox(),
    );
  }
}
