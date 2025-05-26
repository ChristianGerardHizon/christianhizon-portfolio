import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sannjosevet/src/core/failures/failure.dart';
import 'package:sannjosevet/src/core/routing/router.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/app_version.dart';
import 'package:sannjosevet/src/core/widgets/logo.dart';
import 'package:sannjosevet/src/features/authentication/presentation/controllers/auth_controller.dart';
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
          return user;
        },
        Failure.handle,
      ).run();

      result.match(
        (l) {
          if (l is! NoAuthFailure) AppSnackBar.rootFailure(l);
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
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Logo(height: 250, width: 250),
              ),
            ),
            AppVersion(),
          ],
        ),
      ),
    );
  }
}
