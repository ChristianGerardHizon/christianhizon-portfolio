import 'package:flutter/material.dart';
import 'package:gym_system/src/application.dart';
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

  ///
  /// Run the application
  /// with the riverpod package root provider
  ///
  runApp(const ProviderScope(child: Application()));
}
