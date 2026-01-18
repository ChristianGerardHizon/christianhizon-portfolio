// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $messagesShellRoute,
    ];

RouteBase get $messagesShellRoute => ShellRouteData.$route(
      factory: $MessagesShellRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/messages',
          factory: $MessagesRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: ':id',
              factory: $MessageDetailRoute._fromState,
            ),
          ],
        ),
      ],
    );

extension $MessagesShellRouteExtension on MessagesShellRoute {
  static MessagesShellRoute _fromState(GoRouterState state) =>
      const MessagesShellRoute();
}

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

mixin $MessageDetailRoute on GoRouteData {
  static MessageDetailRoute _fromState(GoRouterState state) =>
      MessageDetailRoute(
        id: state.pathParameters['id']!,
      );

  MessageDetailRoute get _self => this as MessageDetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/messages/${Uri.encodeComponent(_self.id)}',
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
