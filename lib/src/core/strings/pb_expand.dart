/// A helper that knows one or more “expand paths” and can format them.
class Expand {
  /// The raw expand paths, e.g. ['species','breed','branch']
  final List<String> paths;

  /// Private constructor
  const Expand._(this.paths);

  /// Combine a root relation with its sub-paths:
  ///   Expand.nested('patient', ['species','breed'])
  ///     → ['patient', 'patient.species', 'patient.breed']
  factory Expand.nested(String root, List<String> subPaths) {
    return Expand._([
      root,
      for (var sub in subPaths) '$root.$sub',
    ]);
  }

  /// Just a flat list of paths:
  ///   Expand(['user','user.branch'])
  factory Expand.flat(List<String> paths) => Expand._(paths);

  /// Get the comma-joined string
  @override
  String toString() => paths.join(', ');
}

class PBExpand {
  /// admin
  static Expand admin = Expand.flat(['branch']);

  /// user
  static Expand user = Expand.flat(['branch']);

  /// change logs
  static Expand changeLogs = Expand.flat(['user', 'user.branch', 'admin']);

  /// branch
  static Expand product = Expand.flat(['branch']);

  /// product inventory
  static Expand productInventory =
      Expand.flat(['product', 'product.branch', 'product.category']);
  static Expand patientTreatmentRecord = Expand.flat(['treatment']);
  static Expand patient = Expand.flat(['species', 'breed', 'branch']);

  /// appointmentSchedule only needs “patient” plus all of patient’s subs:
  static final Expand appointmentSchedule =
      Expand.nested('patient', patient.paths);
}
