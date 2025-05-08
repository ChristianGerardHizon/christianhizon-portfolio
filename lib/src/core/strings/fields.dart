abstract class PbField {
  static const String id = 'id';
  static const String created = 'created';
  static const String updated = 'updated';
  static const String isDeleted = 'isDeleted';
}

class UserField {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String name = 'name';
  static const String email = 'email';
  static const String avatar = 'avatar';
  static const String contactNumber = 'contactNumber';
  static const String password = 'password';
  static const String oldPassword = 'oldPassword';
  static const String passwordConfirm = 'passwordConfirm';
  static const String emailVisibility = 'emailVisibility';
  static const String verified = 'verified';
  static const String branch = 'branch';

  static const String changePassword = 'changePassword';
}

class AdminField {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String name = 'name';
  static const String email = 'email';
  static const String avatar = 'avatar';
  static const String contactNumber = 'contactNumber';
  static const String password = 'password';
  static const String oldPassword = 'oldPassword';
  static const String passwordConfirm = 'passwordConfirm';
  static const String emailVisibility = 'emailVisibility';
  static const String verified = 'verified';

  static const String changePassword = 'changePassword';
}

class PatientField {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String name = 'name';
  static const String address = 'address';
  static const String owner = 'owner';
  static const String contactNumber = 'contactNumber';
  static const String email = 'email';
  static const String species = 'species';
  static const String breed = 'breed';
  static const String color = 'color';
  static const String dateOfBirth = 'dateOfBirth';
  static const String sex = 'sex';
  static const String images = 'images';
  static const String avatar = 'avatar';
  static const String branch = 'branch';
}

class PatientSpeciesField {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String name = 'name';
}

class PatientBreedField {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String name = 'name';
  static const String species = 'species';
}

class TreatmentField {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String name = 'name';
  static const String icon = 'icon';
}

class PatientTreatmentRecordField {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String treatment = 'treatment';
  static const String patient = 'patient';
  static const String date = 'date';
  static const String note = 'notes';
  static const String followUpDate = 'followUpDate';
}

class PatientRecordField {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String patient = 'patient';
  static const String diagnosis = 'diagnosis';
  static const String vistDate = 'visitDate';
  static const String treatment = 'treatment';
  static const String followUpDate = 'followUpDate';
  static const String prescription = 'prescription';
  static const String notes = 'notes';
  static const String user = 'user';
  static const String admin = 'admin';
  static const String branch = 'branch';
  static const String hasTime = 'hasTime';
}

class PatientPrescriptionItemField {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String date = 'date';
  static const String medication = 'medication';
  static const String patientRecord = 'patientRecord';
  static const String dosage = 'dosage';
  static const String instructions = 'instructions';
}

class ProductField {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String name = 'name';
  static const String description = 'description';
  static const String image = 'image';
  static const String category = 'category';
  static const String branch = 'branch';
  static const String stockThreshold = 'stockThreshold';
  static const String forSale = 'forSale';

  static const String expiration = 'expiration';
  static const String quantity = 'quantity';
  static const String trackByLot = 'trackByLot';
}

class BranchField {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String name = 'name';
}

class CategoryField {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String name = 'name';
}

class ProductStockField {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String name = 'name';
  static const String product = 'product';
  static const String expiration = 'expiration';
  static const String lotNo = 'lotNo';
  static const String notes = 'notes';
  static const String quantity = 'quantity';
}

class ProductStockAdjustmentField {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String reason = 'reason';
  static const String oldValue = 'oldValue';
  static const String newValue = 'newValue';
  static const String product = 'product';
  static const String productStock = 'productStock';
}

class ChangeLogField {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String message = 'message';
  static const String user = 'user';
  static const String admin = 'admin';
  static const String type = 'type';
  static const String change = 'changes';
  static const String reference = 'reference';
  static const String collection = 'collection';
}

class ProductCategoryField {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String name = 'name';
  static const String parent = 'parent';
}

class AppointmentScheduleField {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String date = 'date';
  static const String patient = 'patient';
  static const String patientRecord = 'patientRecord';
  static const String notifyWhenNear = 'notifyWhenNear';
  static const String hasNotifiedWhenNear = 'hasNotifiedWhenNear';
  static const String branch = 'branch';
  static const String hasTime = 'hasTime';
  static const String purpose = 'purpose';
  static const String status = 'status';
}

class PatientFileField {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String file = 'file';
  static const String patient = 'patient';
  static const String notes = 'notes';
}
