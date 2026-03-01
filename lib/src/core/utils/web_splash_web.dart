import 'package:web/web.dart' as web;

/// Web implementation: removes the HTML splash screen.
void removeWebSplashImpl() {
  final splash = web.document.getElementById('splash-screen');
  if (splash != null) {
    splash.classList.add('fade-out');
    Future<void>.delayed(const Duration(milliseconds: 400), () {
      splash.remove();
    });
  }
}
