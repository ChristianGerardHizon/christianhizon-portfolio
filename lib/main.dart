import 'package:flutter/material.dart';
import 'package:gym_system/src/application.dart';
import 'package:gym_system/src/core/assets/i18n/strings.g.dart';
import 'package:gym_system/src/core/utils/window_utils.dart';
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

  LocaleSettings.useDeviceLocale(); // and this

  ///
  /// Run the application
  /// with the riverpod package root provider
  ///
  runApp(ProviderScope(child: TranslationProvider(child: Application())));
}
