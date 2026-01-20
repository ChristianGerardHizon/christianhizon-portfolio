// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'treatment_template_dto.dart';

class TreatmentTemplateDtoMapper extends ClassMapperBase<TreatmentTemplateDto> {
  TreatmentTemplateDtoMapper._();

  static TreatmentTemplateDtoMapper? _instance;
  static TreatmentTemplateDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TreatmentTemplateDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TreatmentTemplateDto';

  static String _$id(TreatmentTemplateDto v) => v.id;
  static const Field<TreatmentTemplateDto, String> _f$id = Field('id', _$id);
  static String _$collectionId(TreatmentTemplateDto v) => v.collectionId;
  static const Field<TreatmentTemplateDto, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(TreatmentTemplateDto v) => v.collectionName;
  static const Field<TreatmentTemplateDto, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static String _$name(TreatmentTemplateDto v) => v.name;
  static const Field<TreatmentTemplateDto, String> _f$name = Field(
    'name',
    _$name,
  );
  static String _$treatment(TreatmentTemplateDto v) => v.treatment;
  static const Field<TreatmentTemplateDto, String> _f$treatment = Field(
    'treatment',
    _$treatment,
  );
  static int _$defaultSessionCount(TreatmentTemplateDto v) =>
      v.defaultSessionCount;
  static const Field<TreatmentTemplateDto, int> _f$defaultSessionCount = Field(
    'defaultSessionCount',
    _$defaultSessionCount,
  );
  static int _$defaultIntervalDays(TreatmentTemplateDto v) =>
      v.defaultIntervalDays;
  static const Field<TreatmentTemplateDto, int> _f$defaultIntervalDays = Field(
    'defaultIntervalDays',
    _$defaultIntervalDays,
  );
  static String? _$notes(TreatmentTemplateDto v) => v.notes;
  static const Field<TreatmentTemplateDto, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );
  static bool _$isDeleted(TreatmentTemplateDto v) => v.isDeleted;
  static const Field<TreatmentTemplateDto, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static String? _$created(TreatmentTemplateDto v) => v.created;
  static const Field<TreatmentTemplateDto, String> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static String? _$updated(TreatmentTemplateDto v) => v.updated;
  static const Field<TreatmentTemplateDto, String> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );
  static String? _$expandedTreatmentId(TreatmentTemplateDto v) =>
      v.expandedTreatmentId;
  static const Field<TreatmentTemplateDto, String> _f$expandedTreatmentId =
      Field('expandedTreatmentId', _$expandedTreatmentId, opt: true);
  static String? _$expandedTreatmentName(TreatmentTemplateDto v) =>
      v.expandedTreatmentName;
  static const Field<TreatmentTemplateDto, String> _f$expandedTreatmentName =
      Field('expandedTreatmentName', _$expandedTreatmentName, opt: true);
  static String? _$expandedTreatmentIcon(TreatmentTemplateDto v) =>
      v.expandedTreatmentIcon;
  static const Field<TreatmentTemplateDto, String> _f$expandedTreatmentIcon =
      Field('expandedTreatmentIcon', _$expandedTreatmentIcon, opt: true);

  @override
  final MappableFields<TreatmentTemplateDto> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #name: _f$name,
    #treatment: _f$treatment,
    #defaultSessionCount: _f$defaultSessionCount,
    #defaultIntervalDays: _f$defaultIntervalDays,
    #notes: _f$notes,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
    #expandedTreatmentId: _f$expandedTreatmentId,
    #expandedTreatmentName: _f$expandedTreatmentName,
    #expandedTreatmentIcon: _f$expandedTreatmentIcon,
  };

  static TreatmentTemplateDto _instantiate(DecodingData data) {
    return TreatmentTemplateDto(
      id: data.dec(_f$id),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      name: data.dec(_f$name),
      treatment: data.dec(_f$treatment),
      defaultSessionCount: data.dec(_f$defaultSessionCount),
      defaultIntervalDays: data.dec(_f$defaultIntervalDays),
      notes: data.dec(_f$notes),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
      expandedTreatmentId: data.dec(_f$expandedTreatmentId),
      expandedTreatmentName: data.dec(_f$expandedTreatmentName),
      expandedTreatmentIcon: data.dec(_f$expandedTreatmentIcon),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TreatmentTemplateDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TreatmentTemplateDto>(map);
  }

  static TreatmentTemplateDto fromJson(String json) {
    return ensureInitialized().decodeJson<TreatmentTemplateDto>(json);
  }
}

mixin TreatmentTemplateDtoMappable {
  String toJson() {
    return TreatmentTemplateDtoMapper.ensureInitialized()
        .encodeJson<TreatmentTemplateDto>(this as TreatmentTemplateDto);
  }

  Map<String, dynamic> toMap() {
    return TreatmentTemplateDtoMapper.ensureInitialized()
        .encodeMap<TreatmentTemplateDto>(this as TreatmentTemplateDto);
  }

  TreatmentTemplateDtoCopyWith<
    TreatmentTemplateDto,
    TreatmentTemplateDto,
    TreatmentTemplateDto
  >
  get copyWith =>
      _TreatmentTemplateDtoCopyWithImpl<
        TreatmentTemplateDto,
        TreatmentTemplateDto
      >(this as TreatmentTemplateDto, $identity, $identity);
  @override
  String toString() {
    return TreatmentTemplateDtoMapper.ensureInitialized().stringifyValue(
      this as TreatmentTemplateDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return TreatmentTemplateDtoMapper.ensureInitialized().equalsValue(
      this as TreatmentTemplateDto,
      other,
    );
  }

  @override
  int get hashCode {
    return TreatmentTemplateDtoMapper.ensureInitialized().hashValue(
      this as TreatmentTemplateDto,
    );
  }
}

extension TreatmentTemplateDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TreatmentTemplateDto, $Out> {
  TreatmentTemplateDtoCopyWith<$R, TreatmentTemplateDto, $Out>
  get $asTreatmentTemplateDto => $base.as(
    (v, t, t2) => _TreatmentTemplateDtoCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class TreatmentTemplateDtoCopyWith<
  $R,
  $In extends TreatmentTemplateDto,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? name,
    String? treatment,
    int? defaultSessionCount,
    int? defaultIntervalDays,
    String? notes,
    bool? isDeleted,
    String? created,
    String? updated,
    String? expandedTreatmentId,
    String? expandedTreatmentName,
    String? expandedTreatmentIcon,
  });
  TreatmentTemplateDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _TreatmentTemplateDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TreatmentTemplateDto, $Out>
    implements TreatmentTemplateDtoCopyWith<$R, TreatmentTemplateDto, $Out> {
  _TreatmentTemplateDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TreatmentTemplateDto> $mapper =
      TreatmentTemplateDtoMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? name,
    String? treatment,
    int? defaultSessionCount,
    int? defaultIntervalDays,
    Object? notes = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
    Object? expandedTreatmentId = $none,
    Object? expandedTreatmentName = $none,
    Object? expandedTreatmentIcon = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (name != null) #name: name,
      if (treatment != null) #treatment: treatment,
      if (defaultSessionCount != null)
        #defaultSessionCount: defaultSessionCount,
      if (defaultIntervalDays != null)
        #defaultIntervalDays: defaultIntervalDays,
      if (notes != $none) #notes: notes,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
      if (expandedTreatmentId != $none)
        #expandedTreatmentId: expandedTreatmentId,
      if (expandedTreatmentName != $none)
        #expandedTreatmentName: expandedTreatmentName,
      if (expandedTreatmentIcon != $none)
        #expandedTreatmentIcon: expandedTreatmentIcon,
    }),
  );
  @override
  TreatmentTemplateDto $make(CopyWithData data) => TreatmentTemplateDto(
    id: data.get(#id, or: $value.id),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    name: data.get(#name, or: $value.name),
    treatment: data.get(#treatment, or: $value.treatment),
    defaultSessionCount: data.get(
      #defaultSessionCount,
      or: $value.defaultSessionCount,
    ),
    defaultIntervalDays: data.get(
      #defaultIntervalDays,
      or: $value.defaultIntervalDays,
    ),
    notes: data.get(#notes, or: $value.notes),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
    expandedTreatmentId: data.get(
      #expandedTreatmentId,
      or: $value.expandedTreatmentId,
    ),
    expandedTreatmentName: data.get(
      #expandedTreatmentName,
      or: $value.expandedTreatmentName,
    ),
    expandedTreatmentIcon: data.get(
      #expandedTreatmentIcon,
      or: $value.expandedTreatmentIcon,
    ),
  );

  @override
  TreatmentTemplateDtoCopyWith<$R2, TreatmentTemplateDto, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _TreatmentTemplateDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

