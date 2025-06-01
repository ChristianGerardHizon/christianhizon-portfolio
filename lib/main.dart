import 'package:flutter/material.dart';
import 'package:sannjosevet/src/application.dart';
import 'package:sannjosevet/src/core/assets/i18n/strings.g.dart';
import 'package:sannjosevet/src/core/loggers/riverpod_logger.dart';
import 'package:sannjosevet/src/core/utils/window_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  ///
  /// Ensure the WidgetsBinding is initialized
  ///
  WidgetsFlutterBinding.ensureInitialized();

  ///
  /// Set window initial settings
  ///
  await WindowUtils.register();

  LocaleSettings.useDeviceLocale(); // for translations

  ///
  /// Run the application
  /// with the riverpod package root provider
  ///
  runApp(
    ProviderScope(
      observers: [RiverpodLogger()],
      child: TranslationProvider(child: Application()),
    ),
  );
}
