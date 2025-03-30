class UserField {
  static const String id = 'id';
  static const String name = 'name';
  static const String email = 'email';
  static const String avatar = 'avatar';
  static const String contactNumber = 'contactNumber';
  static const String password = 'password';
  static const String oldPassword = 'oldPassword';
  static const String passwordConfirm = 'passwordConfirm';
  static const String emailVisibility = 'emailVisibility';
  static const String verified = 'verified';
  static const String created = 'created';
  static const String updated = 'updated';
  static const String isDeleted = 'isDeleted';
}

class AdminField {
  static const String id = 'id';
  static const String name = 'name';
  static const String email = 'email';
  static const String avatar = 'avatar';
  static const String contactNumber = 'contactNumber';
  static const String password = 'password';
  static const String oldPassword = 'oldPassword';
  static const String passwordConfirm = 'passwordConfirm';
  static const String emailVisibility = 'emailVisibility';
  static const String verified = 'verified';
  static const String created = 'created';
  static const String updated = 'updated';
  static const String isDeleted = 'isDeleted';
}

class PatientField {
  static const String id = 'id';
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
  static const String created = 'created';
  static const String updated = 'updated';
  static const String isDeleted = 'isDeleted';
}

class PatientSpeciesField {
  static const String id = 'id';
  static const String name = 'name';
  static const String created = 'created';
  static const String updated = 'updated';
  static const String isDeleted = 'isDeleted';
}

class PatientBreedField {
  static const String id = 'id';
  static const String name = 'name';
  static const String species = 'species';
  static const String created = 'created';
  static const String updated = 'updated';
  static const String isDeleted = 'isDeleted';
}

class TreatmentField {
  static const String id = 'id';
  static const String name = 'name';
  static const String icon = 'icon';
  static const String created = 'created';
  static const String updated = 'updated';
  static const String isDeleted = 'isDeleted';
}

class TreatmentRecordField {
  static const String id = 'id';
  static const String type = 'type';
  static const String patient = 'patient';
  static const String date = 'date';
  static const String note = 'notes';
  static const String followUpDate = 'followUpDate';
  static const String created = 'created';
  static const String updated = 'updated';
  static const String isDeleted = 'isDeleted';
}

class MedicalRecordField {
  static const String id = 'id';
  static const String patient = 'patient';
  static const String diagnosis = 'diagnosis';
  static const String vistDate = 'visitDate';
  static const String treatment = 'treatment';
  static const String followUpDate = 'followUpDate';
  static const String prescription = 'prescription';
  static const String user = 'user';
  static const String admin = 'admin';
  static const String created = 'created';
  static const String updated = 'updated';
  static const String isDeleted = 'isDeleted';
}

class PrescriptionItemField {
  static const String id = 'id';
  static const String medication = 'medication';
  static const String medicalRecord = 'medicalRecord';
  static const String dosage = 'dosage';
  static const String instructions = 'instructions';
  static const String created = 'created';
  static const String updated = 'updated';
  static const String isDeleted = 'isDeleted';
}

class ProductField {
  static const String id = 'id';
  static const String name = 'name';
  static const String category = 'category';
  static const String created = 'created';
  static const String updated = 'updated';
  static const String isDeleted = 'isDeleted';
}

class CategoryField {
  static const String id = 'id';
  static const String name = 'name';
  static const String created = 'created';
  static const String updated = 'updated';
  static const String isDeleted = 'isDeleted';
}
