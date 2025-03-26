import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/logo.dart';
import 'package:gym_system/src/features/authentication/domain/auth_data.dart';
import 'package:gym_system/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    triggerCheck() async {
      final result = await TaskResult.tryCatch(
        () async {
          await Future.delayed(Duration(seconds: 3));
          final user = await ref.read(authControllerProvider.future);
          return use;
        },
        Failure.presentation,
      ).run();

      result.fold(
        (l) {
          AppSnackBar.rootError(message: 'Failed to validate saved user...');
          const LoginPageRoute().go(context);
        },
        (r) => const RootRoute().go(context),
      );
    }

    ///
    /// redirect to home
    ///
    useEffect(
      () {
        triggerCheck();
        return null;
      },
      [],
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Logo(height: 250, width: 250),
            ],
          ),
        ),
      ),
    );
  }
}
