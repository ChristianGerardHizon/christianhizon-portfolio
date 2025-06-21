part of '../main.routes.dart';

class PatientBreedsBranchData extends StatefulShellBranchData {
  const PatientBreedsBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<PatientBreedFormPageRoute>(
        path: PatientBreedFormPageRoute.path),
  ];
}

@TypedGoRoute<PatientBreedFormPageRoute>(path: PatientBreedFormPageRoute.path)
class PatientBreedFormPageRoute extends GoRouteData with _$PatientBreedFormPageRoute {
  const PatientBreedFormPageRoute({this.id, required this.parentId});
  static const path = '/form/patientBreeds';

  final String? id;
  final String parentId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientBreedFormPage(
      id: id,
      parentId: parentId,
    );
  }
}
