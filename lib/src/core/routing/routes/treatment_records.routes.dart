part of '../main.routes.dart';

class TreatmentRecordsBranchData extends StatefulShellBranchData {
  const TreatmentRecordsBranchData();
}

@TypedGoRoute<TreatmentRecordsPageRoute>(path: TreatmentRecordsPageRoute.path)
class TreatmentRecordsPageRoute extends GoRouteData {
  const TreatmentRecordsPageRoute();
  static const path = '/treatment-records';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SizedBox();
  }
}

@TypedGoRoute<TreatmentRecordPageRoute>(path: TreatmentRecordPageRoute.path)
class TreatmentRecordPageRoute extends GoRouteData {
  const TreatmentRecordPageRoute(this.id);
  static const path = '/treatment-record/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TreatmentRecordPage(id);
  }
}
