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

  LocaleSettings.useDeviceLocale(); // for translations

  ///
  /// Run the application
  /// with the riverpod package root provider
  ///
  runApp(ProviderScope(
      observers: [RiverpodLogger()],
      child: TranslationProvider(child: Application())));
}

class RiverpodLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    print('''
{
  "provider": "${provider.runtimeType}",
  "value": "$value"
}''');
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    print('''
{
  "provider": "${provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }

  /// A provider was disposed
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    print('''
{
  "provider": "${provider.runtimeType}"
}''');
  }
}
