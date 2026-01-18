import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/messages/presentation/pages/messages_page.dart';

part 'messages.routes.g.dart';

/// Messages list page route.
@TypedGoRoute<MessagesRoute>(path: MessagesRoute.path)
class MessagesRoute extends GoRouteData with $MessagesRoute {
  const MessagesRoute();

  static const path = '/messages';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MessagesPage();
  }
}
