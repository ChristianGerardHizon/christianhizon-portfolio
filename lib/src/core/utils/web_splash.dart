import 'web_splash_stub.dart'
    if (dart.library.js_interop) 'web_splash_web.dart';

/// Removes the HTML splash screen defined in web/index.html.
///
/// No-op on non-web platforms.
void removeWebSplash() => removeWebSplashImpl();
