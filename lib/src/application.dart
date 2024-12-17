import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/packages/auth_interceptors.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/strings/strings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// The main application widget
class Application extends HookConsumerWidget {
  /// The constructor of the application widget
  const Application({super.key});

  @override

  /// The build method of the application widget
  Widget build(BuildContext context, WidgetRef ref) {
    /// The effect hook is used to add the auth interceptor to the dio provider
    ///
    /// This is done only once, when the widget is initialized
    ///
    useEffect(() {}, []);

    /// The material app widget is used to create the main app
    ///
    /// The router config is provided by the router provider
    ///

    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Color(0x093e3a)),
      useMaterial3: true,
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: theme.copyWith(
        cardTheme: theme.cardTheme.copyWith(
          color: Colors.white,
          surfaceTintColor: Colors.white,
        ),
      ),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
