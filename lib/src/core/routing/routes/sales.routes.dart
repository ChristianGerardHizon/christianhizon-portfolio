import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/pos/presentation/pos_screen.dart';

part 'sales.routes.g.dart';

/// Sales/Cashier page route.
@TypedGoRoute<SalesRoute>(path: SalesRoute.path)
class SalesRoute extends GoRouteData with $SalesRoute {
  const SalesRoute();

  static const path = '/cashier';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PosScreen();
  }
}
