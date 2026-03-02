// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'work_history_item.dart';

class WorkHistoryItemMapper extends ClassMapperBase<WorkHistoryItem> {
  WorkHistoryItemMapper._();

  static WorkHistoryItemMapper? _instance;
  static WorkHistoryItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WorkHistoryItemMapper._());
      WorkAchievementMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WorkHistoryItem';

  static String _$id(WorkHistoryItem v) => v.id;
  static const Field<WorkHistoryItem, String> _f$id = Field('id', _$id);
  static String _$company(WorkHistoryItem v) => v.company;
  static const Field<WorkHistoryItem, String> _f$company = Field(
    'company',
    _$company,
  );
  static String _$role(WorkHistoryItem v) => v.role;
  static const Field<WorkHistoryItem, String> _f$role = Field('role', _$role);
  static String _$startDate(WorkHistoryItem v) => v.startDate;
  static const Field<WorkHistoryItem, String> _f$startDate = Field(
    'startDate',
    _$startDate,
  );
  static String _$endDate(WorkHistoryItem v) => v.endDate;
  static const Field<WorkHistoryItem, String> _f$endDate = Field(
    'endDate',
    _$endDate,
    opt: true,
    def: '',
  );
  static String _$description(WorkHistoryItem v) => v.description;
  static const Field<WorkHistoryItem, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static List<String> _$responsibilities(WorkHistoryItem v) =>
      v.responsibilities;
  static const Field<WorkHistoryItem, List<String>> _f$responsibilities = Field(
    'responsibilities',
    _$responsibilities,
    opt: true,
    def: const [],
  );
  static List<WorkAchievement> _$achievements(WorkHistoryItem v) =>
      v.achievements;
  static const Field<WorkHistoryItem, List<WorkAchievement>> _f$achievements =
      Field('achievements', _$achievements, opt: true, def: const []);
  static List<String> _$techStack(WorkHistoryItem v) => v.techStack;
  static const Field<WorkHistoryItem, List<String>> _f$techStack = Field(
    'techStack',
    _$techStack,
    opt: true,
    def: const [],
  );
  static int _$sortOrder(WorkHistoryItem v) => v.sortOrder;
  static const Field<WorkHistoryItem, int> _f$sortOrder = Field(
    'sortOrder',
    _$sortOrder,
    opt: true,
    def: 0,
  );

  @override
  final MappableFields<WorkHistoryItem> fields = const {
    #id: _f$id,
    #company: _f$company,
    #role: _f$role,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #description: _f$description,
    #responsibilities: _f$responsibilities,
    #achievements: _f$achievements,
    #techStack: _f$techStack,
    #sortOrder: _f$sortOrder,
  };

  static WorkHistoryItem _instantiate(DecodingData data) {
    return WorkHistoryItem(
      id: data.dec(_f$id),
      company: data.dec(_f$company),
      role: data.dec(_f$role),
      startDate: data.dec(_f$startDate),
      endDate: data.dec(_f$endDate),
      description: data.dec(_f$description),
      responsibilities: data.dec(_f$responsibilities),
      achievements: data.dec(_f$achievements),
      techStack: data.dec(_f$techStack),
      sortOrder: data.dec(_f$sortOrder),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WorkHistoryItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WorkHistoryItem>(map);
  }

  static WorkHistoryItem fromJson(String json) {
    return ensureInitialized().decodeJson<WorkHistoryItem>(json);
  }
}

mixin WorkHistoryItemMappable {
  String toJson() {
    return WorkHistoryItemMapper.ensureInitialized()
        .encodeJson<WorkHistoryItem>(this as WorkHistoryItem);
  }

  Map<String, dynamic> toMap() {
    return WorkHistoryItemMapper.ensureInitialized().encodeMap<WorkHistoryItem>(
      this as WorkHistoryItem,
    );
  }

  WorkHistoryItemCopyWith<WorkHistoryItem, WorkHistoryItem, WorkHistoryItem>
  get copyWith =>
      _WorkHistoryItemCopyWithImpl<WorkHistoryItem, WorkHistoryItem>(
        this as WorkHistoryItem,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WorkHistoryItemMapper.ensureInitialized().stringifyValue(
      this as WorkHistoryItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return WorkHistoryItemMapper.ensureInitialized().equalsValue(
      this as WorkHistoryItem,
      other,
    );
  }

  @override
  int get hashCode {
    return WorkHistoryItemMapper.ensureInitialized().hashValue(
      this as WorkHistoryItem,
    );
  }
}

extension WorkHistoryItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WorkHistoryItem, $Out> {
  WorkHistoryItemCopyWith<$R, WorkHistoryItem, $Out> get $asWorkHistoryItem =>
      $base.as((v, t, t2) => _WorkHistoryItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WorkHistoryItemCopyWith<$R, $In extends WorkHistoryItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get responsibilities;
  ListCopyWith<
    $R,
    WorkAchievement,
    WorkAchievementCopyWith<$R, WorkAchievement, WorkAchievement>
  >
  get achievements;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get techStack;
  $R call({
    String? id,
    String? company,
    String? role,
    String? startDate,
    String? endDate,
    String? description,
    List<String>? responsibilities,
    List<WorkAchievement>? achievements,
    List<String>? techStack,
    int? sortOrder,
  });
  WorkHistoryItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WorkHistoryItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WorkHistoryItem, $Out>
    implements WorkHistoryItemCopyWith<$R, WorkHistoryItem, $Out> {
  _WorkHistoryItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WorkHistoryItem> $mapper =
      WorkHistoryItemMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get responsibilities => ListCopyWith(
    $value.responsibilities,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(responsibilities: v),
  );
  @override
  ListCopyWith<
    $R,
    WorkAchievement,
    WorkAchievementCopyWith<$R, WorkAchievement, WorkAchievement>
  >
  get achievements => ListCopyWith(
    $value.achievements,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(achievements: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get techStack =>
      ListCopyWith(
        $value.techStack,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(techStack: v),
      );
  @override
  $R call({
    String? id,
    String? company,
    String? role,
    String? startDate,
    String? endDate,
    String? description,
    List<String>? responsibilities,
    List<WorkAchievement>? achievements,
    List<String>? techStack,
    int? sortOrder,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (company != null) #company: company,
      if (role != null) #role: role,
      if (startDate != null) #startDate: startDate,
      if (endDate != null) #endDate: endDate,
      if (description != null) #description: description,
      if (responsibilities != null) #responsibilities: responsibilities,
      if (achievements != null) #achievements: achievements,
      if (techStack != null) #techStack: techStack,
      if (sortOrder != null) #sortOrder: sortOrder,
    }),
  );
  @override
  WorkHistoryItem $make(CopyWithData data) => WorkHistoryItem(
    id: data.get(#id, or: $value.id),
    company: data.get(#company, or: $value.company),
    role: data.get(#role, or: $value.role),
    startDate: data.get(#startDate, or: $value.startDate),
    endDate: data.get(#endDate, or: $value.endDate),
    description: data.get(#description, or: $value.description),
    responsibilities: data.get(#responsibilities, or: $value.responsibilities),
    achievements: data.get(#achievements, or: $value.achievements),
    techStack: data.get(#techStack, or: $value.techStack),
    sortOrder: data.get(#sortOrder, or: $value.sortOrder),
  );

  @override
  WorkHistoryItemCopyWith<$R2, WorkHistoryItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WorkHistoryItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class WorkAchievementMapper extends ClassMapperBase<WorkAchievement> {
  WorkAchievementMapper._();

  static WorkAchievementMapper? _instance;
  static WorkAchievementMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WorkAchievementMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WorkAchievement';

  static String _$title(WorkAchievement v) => v.title;
  static const Field<WorkAchievement, String> _f$title = Field(
    'title',
    _$title,
  );
  static String _$description(WorkAchievement v) => v.description;
  static const Field<WorkAchievement, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<WorkAchievement> fields = const {
    #title: _f$title,
    #description: _f$description,
  };

  static WorkAchievement _instantiate(DecodingData data) {
    return WorkAchievement(
      title: data.dec(_f$title),
      description: data.dec(_f$description),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WorkAchievement fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WorkAchievement>(map);
  }

  static WorkAchievement fromJson(String json) {
    return ensureInitialized().decodeJson<WorkAchievement>(json);
  }
}

mixin WorkAchievementMappable {
  String toJson() {
    return WorkAchievementMapper.ensureInitialized()
        .encodeJson<WorkAchievement>(this as WorkAchievement);
  }

  Map<String, dynamic> toMap() {
    return WorkAchievementMapper.ensureInitialized().encodeMap<WorkAchievement>(
      this as WorkAchievement,
    );
  }

  WorkAchievementCopyWith<WorkAchievement, WorkAchievement, WorkAchievement>
  get copyWith =>
      _WorkAchievementCopyWithImpl<WorkAchievement, WorkAchievement>(
        this as WorkAchievement,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WorkAchievementMapper.ensureInitialized().stringifyValue(
      this as WorkAchievement,
    );
  }

  @override
  bool operator ==(Object other) {
    return WorkAchievementMapper.ensureInitialized().equalsValue(
      this as WorkAchievement,
      other,
    );
  }

  @override
  int get hashCode {
    return WorkAchievementMapper.ensureInitialized().hashValue(
      this as WorkAchievement,
    );
  }
}

extension WorkAchievementValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WorkAchievement, $Out> {
  WorkAchievementCopyWith<$R, WorkAchievement, $Out> get $asWorkAchievement =>
      $base.as((v, t, t2) => _WorkAchievementCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WorkAchievementCopyWith<$R, $In extends WorkAchievement, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? title, String? description});
  WorkAchievementCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WorkAchievementCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WorkAchievement, $Out>
    implements WorkAchievementCopyWith<$R, WorkAchievement, $Out> {
  _WorkAchievementCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WorkAchievement> $mapper =
      WorkAchievementMapper.ensureInitialized();
  @override
  $R call({String? title, String? description}) => $apply(
    FieldCopyWithData({
      if (title != null) #title: title,
      if (description != null) #description: description,
    }),
  );
  @override
  WorkAchievement $make(CopyWithData data) => WorkAchievement(
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
  );

  @override
  WorkAchievementCopyWith<$R2, WorkAchievement, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WorkAchievementCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

