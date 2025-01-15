import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/assets/assets.gen.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    goToRootPage() {
      Future.delayed(const Duration(seconds: 3), () {
        if (context.mounted) const RootRoute().go(context);
      });
    }

    ///
    /// redirect to home
    ///
    useEffect(() {
      goToRootPage();
      return null;
    }, []);

    ref.listen(authControllerProvider, (previous, current) {
      goToRootPage();
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 250,
            height: 250,
            child: Assets.icons.appIconTransparent.image(),
          ),
        ),
      ),
    );
  }
}
