class UserField {
  static const String name = 'name';
  static const String email = 'email';
  static const String avatar = 'avatar';
  static const String contactNumber = 'contactNumber';
  static const String password = 'password';
  static const String oldPassword = 'oldPassword';
  static const String passwordConfirm = 'passwordConfirm';
  static const String emailVisibility = 'emailVisibility';
  static const String verified = 'verified';
  static const String isDeleted = 'isDeleted';
}

class AdminField {
  static const String name = 'name';
  static const String profilePhoto = 'profilePhoto';
  static const String contactNumber = 'contactNumber';
  static const String isDeleted = 'isDeleted';
}

class PatientField {
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
  static const String isDeleted = 'isDeleted';
}

class VaccineField {
  static const String id = 'id';
  static const String name = 'name';
  static const String isDeleted = 'isDeleted';
  static const String icon = 'icon';
}

class VaccineRecordField {
  static const String id = 'id';
  static const String type = 'type';
  static const String patient = 'patient';
  static const String date = 'date';
  static const String note = 'note';
  static const String isDeleted = 'isDeleted';
}
