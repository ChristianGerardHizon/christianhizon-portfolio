// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'profile.dart';

class SkillMapper extends ClassMapperBase<Skill> {
  SkillMapper._();

  static SkillMapper? _instance;
  static SkillMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SkillMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Skill';

  static String _$name(Skill v) => v.name;
  static const Field<Skill, String> _f$name = Field('name', _$name);
  static String _$category(Skill v) => v.category;
  static const Field<Skill, String> _f$category = Field('category', _$category);

  @override
  final MappableFields<Skill> fields = const {
    #name: _f$name,
    #category: _f$category,
  };

  static Skill _instantiate(DecodingData data) {
    return Skill(name: data.dec(_f$name), category: data.dec(_f$category));
  }

  @override
  final Function instantiate = _instantiate;

  static Skill fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Skill>(map);
  }

  static Skill fromJson(String json) {
    return ensureInitialized().decodeJson<Skill>(json);
  }
}

mixin SkillMappable {
  String toJson() {
    return SkillMapper.ensureInitialized().encodeJson<Skill>(this as Skill);
  }

  Map<String, dynamic> toMap() {
    return SkillMapper.ensureInitialized().encodeMap<Skill>(this as Skill);
  }

  SkillCopyWith<Skill, Skill, Skill> get copyWith =>
      _SkillCopyWithImpl<Skill, Skill>(this as Skill, $identity, $identity);
  @override
  String toString() {
    return SkillMapper.ensureInitialized().stringifyValue(this as Skill);
  }

  @override
  bool operator ==(Object other) {
    return SkillMapper.ensureInitialized().equalsValue(this as Skill, other);
  }

  @override
  int get hashCode {
    return SkillMapper.ensureInitialized().hashValue(this as Skill);
  }
}

extension SkillValueCopy<$R, $Out> on ObjectCopyWith<$R, Skill, $Out> {
  SkillCopyWith<$R, Skill, $Out> get $asSkill =>
      $base.as((v, t, t2) => _SkillCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SkillCopyWith<$R, $In extends Skill, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? category});
  SkillCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SkillCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Skill, $Out>
    implements SkillCopyWith<$R, Skill, $Out> {
  _SkillCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Skill> $mapper = SkillMapper.ensureInitialized();
  @override
  $R call({String? name, String? category}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (category != null) #category: category,
    }),
  );
  @override
  Skill $make(CopyWithData data) => Skill(
    name: data.get(#name, or: $value.name),
    category: data.get(#category, or: $value.category),
  );

  @override
  SkillCopyWith<$R2, Skill, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SkillCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ExperienceMapper extends ClassMapperBase<Experience> {
  ExperienceMapper._();

  static ExperienceMapper? _instance;
  static ExperienceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ExperienceMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Experience';

  static String _$company(Experience v) => v.company;
  static const Field<Experience, String> _f$company = Field(
    'company',
    _$company,
  );
  static String _$role(Experience v) => v.role;
  static const Field<Experience, String> _f$role = Field('role', _$role);
  static String _$startDate(Experience v) => v.startDate;
  static const Field<Experience, String> _f$startDate = Field(
    'startDate',
    _$startDate,
  );
  static String? _$endDate(Experience v) => v.endDate;
  static const Field<Experience, String> _f$endDate = Field(
    'endDate',
    _$endDate,
    opt: true,
  );
  static String _$description(Experience v) => v.description;
  static const Field<Experience, String> _f$description = Field(
    'description',
    _$description,
  );

  @override
  final MappableFields<Experience> fields = const {
    #company: _f$company,
    #role: _f$role,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #description: _f$description,
  };

  static Experience _instantiate(DecodingData data) {
    return Experience(
      company: data.dec(_f$company),
      role: data.dec(_f$role),
      startDate: data.dec(_f$startDate),
      endDate: data.dec(_f$endDate),
      description: data.dec(_f$description),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Experience fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Experience>(map);
  }

  static Experience fromJson(String json) {
    return ensureInitialized().decodeJson<Experience>(json);
  }
}

mixin ExperienceMappable {
  String toJson() {
    return ExperienceMapper.ensureInitialized().encodeJson<Experience>(
      this as Experience,
    );
  }

  Map<String, dynamic> toMap() {
    return ExperienceMapper.ensureInitialized().encodeMap<Experience>(
      this as Experience,
    );
  }

  ExperienceCopyWith<Experience, Experience, Experience> get copyWith =>
      _ExperienceCopyWithImpl<Experience, Experience>(
        this as Experience,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ExperienceMapper.ensureInitialized().stringifyValue(
      this as Experience,
    );
  }

  @override
  bool operator ==(Object other) {
    return ExperienceMapper.ensureInitialized().equalsValue(
      this as Experience,
      other,
    );
  }

  @override
  int get hashCode {
    return ExperienceMapper.ensureInitialized().hashValue(this as Experience);
  }
}

extension ExperienceValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Experience, $Out> {
  ExperienceCopyWith<$R, Experience, $Out> get $asExperience =>
      $base.as((v, t, t2) => _ExperienceCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ExperienceCopyWith<$R, $In extends Experience, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? company,
    String? role,
    String? startDate,
    String? endDate,
    String? description,
  });
  ExperienceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ExperienceCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Experience, $Out>
    implements ExperienceCopyWith<$R, Experience, $Out> {
  _ExperienceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Experience> $mapper =
      ExperienceMapper.ensureInitialized();
  @override
  $R call({
    String? company,
    String? role,
    String? startDate,
    Object? endDate = $none,
    String? description,
  }) => $apply(
    FieldCopyWithData({
      if (company != null) #company: company,
      if (role != null) #role: role,
      if (startDate != null) #startDate: startDate,
      if (endDate != $none) #endDate: endDate,
      if (description != null) #description: description,
    }),
  );
  @override
  Experience $make(CopyWithData data) => Experience(
    company: data.get(#company, or: $value.company),
    role: data.get(#role, or: $value.role),
    startDate: data.get(#startDate, or: $value.startDate),
    endDate: data.get(#endDate, or: $value.endDate),
    description: data.get(#description, or: $value.description),
  );

  @override
  ExperienceCopyWith<$R2, Experience, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ExperienceCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ProfileStatMapper extends ClassMapperBase<ProfileStat> {
  ProfileStatMapper._();

  static ProfileStatMapper? _instance;
  static ProfileStatMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileStatMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProfileStat';

  static String _$value(ProfileStat v) => v.value;
  static const Field<ProfileStat, String> _f$value = Field('value', _$value);
  static String _$label(ProfileStat v) => v.label;
  static const Field<ProfileStat, String> _f$label = Field('label', _$label);

  @override
  final MappableFields<ProfileStat> fields = const {
    #value: _f$value,
    #label: _f$label,
  };

  static ProfileStat _instantiate(DecodingData data) {
    return ProfileStat(value: data.dec(_f$value), label: data.dec(_f$label));
  }

  @override
  final Function instantiate = _instantiate;

  static ProfileStat fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProfileStat>(map);
  }

  static ProfileStat fromJson(String json) {
    return ensureInitialized().decodeJson<ProfileStat>(json);
  }
}

mixin ProfileStatMappable {
  String toJson() {
    return ProfileStatMapper.ensureInitialized().encodeJson<ProfileStat>(
      this as ProfileStat,
    );
  }

  Map<String, dynamic> toMap() {
    return ProfileStatMapper.ensureInitialized().encodeMap<ProfileStat>(
      this as ProfileStat,
    );
  }

  ProfileStatCopyWith<ProfileStat, ProfileStat, ProfileStat> get copyWith =>
      _ProfileStatCopyWithImpl<ProfileStat, ProfileStat>(
        this as ProfileStat,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ProfileStatMapper.ensureInitialized().stringifyValue(
      this as ProfileStat,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProfileStatMapper.ensureInitialized().equalsValue(
      this as ProfileStat,
      other,
    );
  }

  @override
  int get hashCode {
    return ProfileStatMapper.ensureInitialized().hashValue(this as ProfileStat);
  }
}

extension ProfileStatValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProfileStat, $Out> {
  ProfileStatCopyWith<$R, ProfileStat, $Out> get $asProfileStat =>
      $base.as((v, t, t2) => _ProfileStatCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProfileStatCopyWith<$R, $In extends ProfileStat, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? value, String? label});
  ProfileStatCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProfileStatCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProfileStat, $Out>
    implements ProfileStatCopyWith<$R, ProfileStat, $Out> {
  _ProfileStatCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProfileStat> $mapper =
      ProfileStatMapper.ensureInitialized();
  @override
  $R call({String? value, String? label}) => $apply(
    FieldCopyWithData({
      if (value != null) #value: value,
      if (label != null) #label: label,
    }),
  );
  @override
  ProfileStat $make(CopyWithData data) => ProfileStat(
    value: data.get(#value, or: $value.value),
    label: data.get(#label, or: $value.label),
  );

  @override
  ProfileStatCopyWith<$R2, ProfileStat, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ProfileStatCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ProfileMapper extends ClassMapperBase<Profile> {
  ProfileMapper._();

  static ProfileMapper? _instance;
  static ProfileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileMapper._());
      SkillMapper.ensureInitialized();
      ExperienceMapper.ensureInitialized();
      ProfileStatMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Profile';

  static String _$id(Profile v) => v.id;
  static const Field<Profile, String> _f$id = Field('id', _$id);
  static String _$name(Profile v) => v.name;
  static const Field<Profile, String> _f$name = Field('name', _$name);
  static String _$title(Profile v) => v.title;
  static const Field<Profile, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
    def: '',
  );
  static String _$bio(Profile v) => v.bio;
  static const Field<Profile, String> _f$bio = Field(
    'bio',
    _$bio,
    opt: true,
    def: '',
  );
  static String _$photo(Profile v) => v.photo;
  static const Field<Profile, String> _f$photo = Field(
    'photo',
    _$photo,
    opt: true,
    def: '',
  );
  static String _$email(Profile v) => v.email;
  static const Field<Profile, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
    def: '',
  );
  static String _$phone(Profile v) => v.phone;
  static const Field<Profile, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
    def: '',
  );
  static String _$location(Profile v) => v.location;
  static const Field<Profile, String> _f$location = Field(
    'location',
    _$location,
    opt: true,
    def: '',
  );
  static String _$githubUrl(Profile v) => v.githubUrl;
  static const Field<Profile, String> _f$githubUrl = Field(
    'githubUrl',
    _$githubUrl,
    opt: true,
    def: '',
  );
  static String _$linkedinUrl(Profile v) => v.linkedinUrl;
  static const Field<Profile, String> _f$linkedinUrl = Field(
    'linkedinUrl',
    _$linkedinUrl,
    opt: true,
    def: '',
  );
  static String _$websiteUrl(Profile v) => v.websiteUrl;
  static const Field<Profile, String> _f$websiteUrl = Field(
    'websiteUrl',
    _$websiteUrl,
    opt: true,
    def: '',
  );
  static String _$resumeUrl(Profile v) => v.resumeUrl;
  static const Field<Profile, String> _f$resumeUrl = Field(
    'resumeUrl',
    _$resumeUrl,
    opt: true,
    def: '',
  );
  static String _$availabilityStatus(Profile v) => v.availabilityStatus;
  static const Field<Profile, String> _f$availabilityStatus = Field(
    'availabilityStatus',
    _$availabilityStatus,
    opt: true,
    def: '',
  );
  static String _$stackOverflowUrl(Profile v) => v.stackOverflowUrl;
  static const Field<Profile, String> _f$stackOverflowUrl = Field(
    'stackOverflowUrl',
    _$stackOverflowUrl,
    opt: true,
    def: '',
  );
  static List<Skill> _$skills(Profile v) => v.skills;
  static const Field<Profile, List<Skill>> _f$skills = Field(
    'skills',
    _$skills,
    opt: true,
    def: const [],
  );
  static List<Experience> _$experience(Profile v) => v.experience;
  static const Field<Profile, List<Experience>> _f$experience = Field(
    'experience',
    _$experience,
    opt: true,
    def: const [],
  );
  static List<ProfileStat> _$stats(Profile v) => v.stats;
  static const Field<Profile, List<ProfileStat>> _f$stats = Field(
    'stats',
    _$stats,
    opt: true,
    def: const [],
  );
  static String _$collectionId(Profile v) => v.collectionId;
  static const Field<Profile, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<Profile> fields = const {
    #id: _f$id,
    #name: _f$name,
    #title: _f$title,
    #bio: _f$bio,
    #photo: _f$photo,
    #email: _f$email,
    #phone: _f$phone,
    #location: _f$location,
    #githubUrl: _f$githubUrl,
    #linkedinUrl: _f$linkedinUrl,
    #websiteUrl: _f$websiteUrl,
    #resumeUrl: _f$resumeUrl,
    #availabilityStatus: _f$availabilityStatus,
    #stackOverflowUrl: _f$stackOverflowUrl,
    #skills: _f$skills,
    #experience: _f$experience,
    #stats: _f$stats,
    #collectionId: _f$collectionId,
  };

  static Profile _instantiate(DecodingData data) {
    return Profile(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      title: data.dec(_f$title),
      bio: data.dec(_f$bio),
      photo: data.dec(_f$photo),
      email: data.dec(_f$email),
      phone: data.dec(_f$phone),
      location: data.dec(_f$location),
      githubUrl: data.dec(_f$githubUrl),
      linkedinUrl: data.dec(_f$linkedinUrl),
      websiteUrl: data.dec(_f$websiteUrl),
      resumeUrl: data.dec(_f$resumeUrl),
      availabilityStatus: data.dec(_f$availabilityStatus),
      stackOverflowUrl: data.dec(_f$stackOverflowUrl),
      skills: data.dec(_f$skills),
      experience: data.dec(_f$experience),
      stats: data.dec(_f$stats),
      collectionId: data.dec(_f$collectionId),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Profile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Profile>(map);
  }

  static Profile fromJson(String json) {
    return ensureInitialized().decodeJson<Profile>(json);
  }
}

mixin ProfileMappable {
  String toJson() {
    return ProfileMapper.ensureInitialized().encodeJson<Profile>(
      this as Profile,
    );
  }

  Map<String, dynamic> toMap() {
    return ProfileMapper.ensureInitialized().encodeMap<Profile>(
      this as Profile,
    );
  }

  ProfileCopyWith<Profile, Profile, Profile> get copyWith =>
      _ProfileCopyWithImpl<Profile, Profile>(
        this as Profile,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ProfileMapper.ensureInitialized().stringifyValue(this as Profile);
  }

  @override
  bool operator ==(Object other) {
    return ProfileMapper.ensureInitialized().equalsValue(
      this as Profile,
      other,
    );
  }

  @override
  int get hashCode {
    return ProfileMapper.ensureInitialized().hashValue(this as Profile);
  }
}

extension ProfileValueCopy<$R, $Out> on ObjectCopyWith<$R, Profile, $Out> {
  ProfileCopyWith<$R, Profile, $Out> get $asProfile =>
      $base.as((v, t, t2) => _ProfileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProfileCopyWith<$R, $In extends Profile, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Skill, SkillCopyWith<$R, Skill, Skill>> get skills;
  ListCopyWith<$R, Experience, ExperienceCopyWith<$R, Experience, Experience>>
  get experience;
  ListCopyWith<
    $R,
    ProfileStat,
    ProfileStatCopyWith<$R, ProfileStat, ProfileStat>
  >
  get stats;
  $R call({
    String? id,
    String? name,
    String? title,
    String? bio,
    String? photo,
    String? email,
    String? phone,
    String? location,
    String? githubUrl,
    String? linkedinUrl,
    String? websiteUrl,
    String? resumeUrl,
    String? availabilityStatus,
    String? stackOverflowUrl,
    List<Skill>? skills,
    List<Experience>? experience,
    List<ProfileStat>? stats,
    String? collectionId,
  });
  ProfileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProfileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Profile, $Out>
    implements ProfileCopyWith<$R, Profile, $Out> {
  _ProfileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Profile> $mapper =
      ProfileMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Skill, SkillCopyWith<$R, Skill, Skill>> get skills =>
      ListCopyWith(
        $value.skills,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(skills: v),
      );
  @override
  ListCopyWith<$R, Experience, ExperienceCopyWith<$R, Experience, Experience>>
  get experience => ListCopyWith(
    $value.experience,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(experience: v),
  );
  @override
  ListCopyWith<
    $R,
    ProfileStat,
    ProfileStatCopyWith<$R, ProfileStat, ProfileStat>
  >
  get stats => ListCopyWith(
    $value.stats,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(stats: v),
  );
  @override
  $R call({
    String? id,
    String? name,
    String? title,
    String? bio,
    String? photo,
    String? email,
    String? phone,
    String? location,
    String? githubUrl,
    String? linkedinUrl,
    String? websiteUrl,
    String? resumeUrl,
    String? availabilityStatus,
    String? stackOverflowUrl,
    List<Skill>? skills,
    List<Experience>? experience,
    List<ProfileStat>? stats,
    String? collectionId,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (title != null) #title: title,
      if (bio != null) #bio: bio,
      if (photo != null) #photo: photo,
      if (email != null) #email: email,
      if (phone != null) #phone: phone,
      if (location != null) #location: location,
      if (githubUrl != null) #githubUrl: githubUrl,
      if (linkedinUrl != null) #linkedinUrl: linkedinUrl,
      if (websiteUrl != null) #websiteUrl: websiteUrl,
      if (resumeUrl != null) #resumeUrl: resumeUrl,
      if (availabilityStatus != null) #availabilityStatus: availabilityStatus,
      if (stackOverflowUrl != null) #stackOverflowUrl: stackOverflowUrl,
      if (skills != null) #skills: skills,
      if (experience != null) #experience: experience,
      if (stats != null) #stats: stats,
      if (collectionId != null) #collectionId: collectionId,
    }),
  );
  @override
  Profile $make(CopyWithData data) => Profile(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    title: data.get(#title, or: $value.title),
    bio: data.get(#bio, or: $value.bio),
    photo: data.get(#photo, or: $value.photo),
    email: data.get(#email, or: $value.email),
    phone: data.get(#phone, or: $value.phone),
    location: data.get(#location, or: $value.location),
    githubUrl: data.get(#githubUrl, or: $value.githubUrl),
    linkedinUrl: data.get(#linkedinUrl, or: $value.linkedinUrl),
    websiteUrl: data.get(#websiteUrl, or: $value.websiteUrl),
    resumeUrl: data.get(#resumeUrl, or: $value.resumeUrl),
    availabilityStatus: data.get(
      #availabilityStatus,
      or: $value.availabilityStatus,
    ),
    stackOverflowUrl: data.get(#stackOverflowUrl, or: $value.stackOverflowUrl),
    skills: data.get(#skills, or: $value.skills),
    experience: data.get(#experience, or: $value.experience),
    stats: data.get(#stats, or: $value.stats),
    collectionId: data.get(#collectionId, or: $value.collectionId),
  );

  @override
  ProfileCopyWith<$R2, Profile, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

