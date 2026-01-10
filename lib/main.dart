import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/utils/window_utils.dart';
import 'package:sannjosevet/src/application.dart';
import 'package:sannjosevet/src/core/i18n/strings.g.dart';
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

  ///
  /// Set locale for translations
  ///
  LocaleSettings.useDeviceLocale();

  ///
  /// Run the application
  /// with the riverpod package root provider
  ///
  runApp(
    ProviderScope(
      child: TranslationProvider(child: Application()),
    ),
  );
}
