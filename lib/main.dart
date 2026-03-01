import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:christianhizon/src/core/utils/window_utils.dart';
import 'package:christianhizon/src/application.dart';
import 'package:christianhizon/src/core/i18n/strings.g.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/core/utils/web_splash.dart';

Future<void> main() async {
  ///
  /// Ensure the WidgetsBinding is initialized
  ///
  WidgetsFlutterBinding.ensureInitialized();

  ///
  /// Set window initial settings (fire-and-forget to avoid blocking app start)
  ///
  WindowUtils.register();

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

  // Remove the HTML splash screen after the first frame renders
  if (kIsWeb) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      removeWebSplash();
    });
  }
}
