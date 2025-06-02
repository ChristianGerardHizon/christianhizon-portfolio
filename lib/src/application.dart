import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sannjosevet/src/core/assets/i18n/strings.g.dart';
import 'package:sannjosevet/src/core/packages/file_downloader.dart';
import 'package:sannjosevet/src/core/routing/router.dart';
import 'package:sannjosevet/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:theme_provider/theme_provider.dart';

class Application extends HookConsumerWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authControllerProvider);

    final color = Color.fromARGB(0, 40, 122, 111);

    useEffect(() {
      if (kIsWeb) return;
      ref.watch(fileDownloaderProvider).configureNotification(
            running: TaskNotification('Downloading', 'file: {filename}'),
            progressBar: true,
          );
      return null;
    }, []);

    return ThemeProvider(
      defaultThemeId: 'light',
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: [
        AppTheme(
          id: 'light',
          description: 'Light Theme',
          data: ThemeData(
            brightness: Brightness.light,
            colorSchemeSeed: color,
          ),
        ),
        AppTheme(
          id: 'dark',
          description: 'Dark Theme',
          data: ThemeData(
            brightness: Brightness.dark,
            colorSchemeSeed: color,
          ),
        ),
      ],
      child: ThemeConsumer(
        child: Builder(builder: (context) {
          final theme = ThemeProvider.themeOf(context).data;
          return ResponsiveApp(builder: (context) {
            return MaterialApp.router(
              locale:
                  TranslationProvider.of(context).flutterLocale, // use provider
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: [
                // AppFlowyEditorLocalizations.delegate,
                ...GlobalMaterialLocalizations.delegates,
              ],
              debugShowCheckedModeBanner: false,
              title: context.t.common.appName,
              theme: theme,

              routerConfig: ref.watch(routerProvider),
            );
          });
        }),
      ),
    );
  }
}
