// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $messagesRoute,
    ];

RouteBase get $messagesRoute => GoRouteData.$route(
      path: '/messages',
      factory: $MessagesRoute._fromState,
    );

mixin $MessagesRoute on GoRouteData {
  static MessagesRoute _fromState(GoRouterState state) => const MessagesRoute();

  @override
  String get location => GoRouteData.$location(
        '/messages',
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
