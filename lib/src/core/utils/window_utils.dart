import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym_system/src/core/strings/strings.dart';

import 'package:window_manager/window_manager.dart';

class WindowUtils {
  ///
  /// Register the WindowManager for Windows
  ///
  static Future<void> register() async {
    /// * If the app is running on the web or not on Windows
    /// just incase so when the the platform is set to other than windows
    /// the WindowManager will not be initialized
    /// not applicable since app is just a mobile app
    ///
    if (kIsWeb ||
        ![
          TargetPlatform.linux,
          TargetPlatform.macOS,
          TargetPlatform.windows,
        ].contains(defaultTargetPlatform)) return;

    // * Initialize the WindowManager
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      title: AppStrings.appName,
      minimumSize: Size(380, 700),
      size: Size(1000, 700),
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );
    // * Wait until the window is ready be shown
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
}
