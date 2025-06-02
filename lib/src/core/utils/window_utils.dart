import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:window_manager/window_manager.dart';

class WindowUtils {
  ///
  /// Register the WindowManager for Windows
  ///
  /// This function is used to register the window manager for windows
  /// It is used to set the window title and size
  ///
  static Future<void> register() async {
    ///
    /// If the app is running on the web or not on Windows
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

    const mobileSize = Size(380, 700);
    const desktopSize = Size(1000, 800);

    // * Set the window options
    WindowOptions windowOptions = WindowOptions(
      minimumSize: mobileSize, // Set the minimum size of the window
      size: kDebugMode ? mobileSize : desktopSize, // Set the initial size of the window
      backgroundColor:
          Colors.transparent, // Set the background color of the window
      skipTaskbar: false, // Set if the window should be shown in the taskbar
      titleBarStyle: TitleBarStyle.normal, // Set the title bar style
    );

    // * Wait until the window is ready be shown
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      // * Show the window
      await windowManager.show();

      // * Focus the window
      await windowManager.focus();
    });
  }
}
