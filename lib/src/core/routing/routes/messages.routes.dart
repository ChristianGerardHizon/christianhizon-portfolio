import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/messages/presentation/pages/message_detail_page.dart';
import '../../../features/messages/presentation/pages/messages_list_page.dart';
import '../../../features/messages/presentation/pages/messages_shell.dart';
import '../../utils/breakpoints.dart';

part 'messages.routes.g.dart';

/// Messages shell route for master-detail layout.
///
/// On tablet: Shows list and detail side-by-side
/// On mobile: Shows list, then navigates to detail
@TypedShellRoute<MessagesShellRoute>(
  routes: [
    TypedGoRoute<MessagesRoute>(
      path: MessagesRoute.path,
      routes: [
        TypedGoRoute<MessageDetailRoute>(path: ':id'),
      ],
    ),
  ],
)
class MessagesShellRoute extends ShellRouteData {
  const MessagesShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return MessagesShell(child: navigator);
  }
}

/// Messages list page route.
class MessagesRoute extends GoRouteData with $MessagesRoute {
  const MessagesRoute();

  static const path = '/messages';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // On tablet, this is handled by the shell - return empty container
    // On mobile, this shows the list page
    if (Breakpoints.isTabletOrLarger(context)) {
      return const SizedBox.shrink();
    }
    return const MessagesListPage();
  }
}

/// Message detail page route.
class MessageDetailRoute extends GoRouteData with $MessageDetailRoute {
  const MessageDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MessageDetailPage(messageId: id);
  }
}
