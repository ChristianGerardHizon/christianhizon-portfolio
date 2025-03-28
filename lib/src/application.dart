import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/strings/strings.dart';
import 'package:gym_system/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Application extends HookConsumerWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authControllerProvider);

    useEffect(() {
      return null;
    }, []);

    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Color(0x2F887C)),
      useMaterial3: true,
    );

    return ResponsiveApp(builder: (context) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: theme.copyWith(
          appBarTheme:
              theme.appBarTheme.copyWith(backgroundColor: Colors.white),
          cardTheme: theme.cardTheme.copyWith(
            color: Colors.white,
            surfaceTintColor: Colors.white,
          ),
        ),
        routerConfig: ref.watch(routerProvider),
        localizationsDelegates: [
          AppFlowyEditorLocalizations.delegate,
        ],
      );
    });
  }
}
