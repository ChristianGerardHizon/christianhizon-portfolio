// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system.routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $systemShellRoute,
    ];

RouteBase get $systemShellRoute => ShellRouteData.$route(
      factory: $SystemShellRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/system',
          factory: $SystemRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'species',
              factory: $SpeciesRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':id',
                  factory: $SpeciesDetailRoute._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'product-categories',
              factory: $ProductCategoriesRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':id',
                  factory: $ProductCategoryDetailRoute._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'message-templates',
              factory: $MessageTemplatesRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':id',
                  factory: $MessageTemplateDetailRoute._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'treatment-types',
              factory: $TreatmentTypesRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':id',
                  factory: $TreatmentTypeDetailRoute._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'printers',
              factory: $PrinterSettingsRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':id',
                  factory: $PrinterDetailRoute._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'appearance',
              factory: $AppearanceRoute._fromState,
            ),
          ],
        ),
      ],
    );

extension $SystemShellRouteExtension on SystemShellRoute {
  static SystemShellRoute _fromState(GoRouterState state) =>
      const SystemShellRoute();
}

mixin $SystemRoute on GoRouteData {
  static SystemRoute _fromState(GoRouterState state) => const SystemRoute();

  @override
  String get location => GoRouteData.$location(
        '/system',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SpeciesRoute on GoRouteData {
  static SpeciesRoute _fromState(GoRouterState state) => const SpeciesRoute();

  @override
  String get location => GoRouteData.$location(
        '/system/species',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SpeciesDetailRoute on GoRouteData {
  static SpeciesDetailRoute _fromState(GoRouterState state) =>
      SpeciesDetailRoute(
        id: state.pathParameters['id']!,
      );

  SpeciesDetailRoute get _self => this as SpeciesDetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/system/species/${Uri.encodeComponent(_self.id)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProductCategoriesRoute on GoRouteData {
  static ProductCategoriesRoute _fromState(GoRouterState state) =>
      const ProductCategoriesRoute();

  @override
  String get location => GoRouteData.$location(
        '/system/product-categories',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProductCategoryDetailRoute on GoRouteData {
  static ProductCategoryDetailRoute _fromState(GoRouterState state) =>
      ProductCategoryDetailRoute(
        id: state.pathParameters['id']!,
      );

  ProductCategoryDetailRoute get _self => this as ProductCategoryDetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/system/product-categories/${Uri.encodeComponent(_self.id)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $MessageTemplatesRoute on GoRouteData {
  static MessageTemplatesRoute _fromState(GoRouterState state) =>
      const MessageTemplatesRoute();

  @override
  String get location => GoRouteData.$location(
        '/system/message-templates',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $MessageTemplateDetailRoute on GoRouteData {
  static MessageTemplateDetailRoute _fromState(GoRouterState state) =>
      MessageTemplateDetailRoute(
        id: state.pathParameters['id']!,
      );

  MessageTemplateDetailRoute get _self => this as MessageTemplateDetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/system/message-templates/${Uri.encodeComponent(_self.id)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $TreatmentTypesRoute on GoRouteData {
  static TreatmentTypesRoute _fromState(GoRouterState state) =>
      const TreatmentTypesRoute();

  @override
  String get location => GoRouteData.$location(
        '/system/treatment-types',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $TreatmentTypeDetailRoute on GoRouteData {
  static TreatmentTypeDetailRoute _fromState(GoRouterState state) =>
      TreatmentTypeDetailRoute(
        id: state.pathParameters['id']!,
      );

  TreatmentTypeDetailRoute get _self => this as TreatmentTypeDetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/system/treatment-types/${Uri.encodeComponent(_self.id)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PrinterSettingsRoute on GoRouteData {
  static PrinterSettingsRoute _fromState(GoRouterState state) =>
      const PrinterSettingsRoute();

  @override
  String get location => GoRouteData.$location(
        '/system/printers',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PrinterDetailRoute on GoRouteData {
  static PrinterDetailRoute _fromState(GoRouterState state) =>
      PrinterDetailRoute(
        id: state.pathParameters['id']!,
      );

  PrinterDetailRoute get _self => this as PrinterDetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/system/printers/${Uri.encodeComponent(_self.id)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AppearanceRoute on GoRouteData {
  static AppearanceRoute _fromState(GoRouterState state) =>
      const AppearanceRoute();

  @override
  String get location => GoRouteData.$location(
        '/system/appearance',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
