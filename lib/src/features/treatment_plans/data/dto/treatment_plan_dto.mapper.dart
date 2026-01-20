// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'treatment_plan_dto.dart';

class TreatmentPlanDtoMapper extends ClassMapperBase<TreatmentPlanDto> {
  TreatmentPlanDtoMapper._();

  static TreatmentPlanDtoMapper? _instance;
  static TreatmentPlanDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TreatmentPlanDtoMapper._());
      PatientMapper.ensureInitialized();
      TreatmentPlanItemMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TreatmentPlanDto';

  static String _$id(TreatmentPlanDto v) => v.id;
  static const Field<TreatmentPlanDto, String> _f$id = Field('id', _$id);
  static String _$collectionId(TreatmentPlanDto v) => v.collectionId;
  static const Field<TreatmentPlanDto, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(TreatmentPlanDto v) => v.collectionName;
  static const Field<TreatmentPlanDto, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static String _$patient(TreatmentPlanDto v) => v.patient;
  static const Field<TreatmentPlanDto, String> _f$patient = Field(
    'patient',
    _$patient,
  );
  static String _$treatment(TreatmentPlanDto v) => v.treatment;
  static const Field<TreatmentPlanDto, String> _f$treatment = Field(
    'treatment',
    _$treatment,
  );
  static String _$status(TreatmentPlanDto v) => v.status;
  static const Field<TreatmentPlanDto, String> _f$status = Field(
    'status',
    _$status,
  );
  static String _$startDate(TreatmentPlanDto v) => v.startDate;
  static const Field<TreatmentPlanDto, String> _f$startDate = Field(
    'startDate',
    _$startDate,
  );
  static String? _$title(TreatmentPlanDto v) => v.title;
  static const Field<TreatmentPlanDto, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
  );
  static String? _$notes(TreatmentPlanDto v) => v.notes;
  static const Field<TreatmentPlanDto, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );
  static bool _$isDeleted(TreatmentPlanDto v) => v.isDeleted;
  static const Field<TreatmentPlanDto, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static String? _$created(TreatmentPlanDto v) => v.created;
  static const Field<TreatmentPlanDto, String> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static String? _$updated(TreatmentPlanDto v) => v.updated;
  static const Field<TreatmentPlanDto, String> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );
  static Patient? _$expandedPatient(TreatmentPlanDto v) => v.expandedPatient;
  static const Field<TreatmentPlanDto, Patient> _f$expandedPatient = Field(
    'expandedPatient',
    _$expandedPatient,
    opt: true,
  );
  static String? _$expandedTreatmentId(TreatmentPlanDto v) =>
      v.expandedTreatmentId;
  static const Field<TreatmentPlanDto, String> _f$expandedTreatmentId = Field(
    'expandedTreatmentId',
    _$expandedTreatmentId,
    opt: true,
  );
  static String? _$expandedTreatmentName(TreatmentPlanDto v) =>
      v.expandedTreatmentName;
  static const Field<TreatmentPlanDto, String> _f$expandedTreatmentName = Field(
    'expandedTreatmentName',
    _$expandedTreatmentName,
    opt: true,
  );
  static String? _$expandedTreatmentIcon(TreatmentPlanDto v) =>
      v.expandedTreatmentIcon;
  static const Field<TreatmentPlanDto, String> _f$expandedTreatmentIcon = Field(
    'expandedTreatmentIcon',
    _$expandedTreatmentIcon,
    opt: true,
  );
  static List<TreatmentPlanItem> _$expandedItems(TreatmentPlanDto v) =>
      v.expandedItems;
  static const Field<TreatmentPlanDto, List<TreatmentPlanItem>>
  _f$expandedItems = Field(
    'expandedItems',
    _$expandedItems,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<TreatmentPlanDto> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #patient: _f$patient,
    #treatment: _f$treatment,
    #status: _f$status,
    #startDate: _f$startDate,
    #title: _f$title,
    #notes: _f$notes,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
    #expandedPatient: _f$expandedPatient,
    #expandedTreatmentId: _f$expandedTreatmentId,
    #expandedTreatmentName: _f$expandedTreatmentName,
    #expandedTreatmentIcon: _f$expandedTreatmentIcon,
    #expandedItems: _f$expandedItems,
  };

  static TreatmentPlanDto _instantiate(DecodingData data) {
    return TreatmentPlanDto(
      id: data.dec(_f$id),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      patient: data.dec(_f$patient),
      treatment: data.dec(_f$treatment),
      status: data.dec(_f$status),
      startDate: data.dec(_f$startDate),
      title: data.dec(_f$title),
      notes: data.dec(_f$notes),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
      expandedPatient: data.dec(_f$expandedPatient),
      expandedTreatmentId: data.dec(_f$expandedTreatmentId),
      expandedTreatmentName: data.dec(_f$expandedTreatmentName),
      expandedTreatmentIcon: data.dec(_f$expandedTreatmentIcon),
      expandedItems: data.dec(_f$expandedItems),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TreatmentPlanDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TreatmentPlanDto>(map);
  }

  static TreatmentPlanDto fromJson(String json) {
    return ensureInitialized().decodeJson<TreatmentPlanDto>(json);
  }
}

mixin TreatmentPlanDtoMappable {
  String toJson() {
    return TreatmentPlanDtoMapper.ensureInitialized()
        .encodeJson<TreatmentPlanDto>(this as TreatmentPlanDto);
  }

  Map<String, dynamic> toMap() {
    return TreatmentPlanDtoMapper.ensureInitialized()
        .encodeMap<TreatmentPlanDto>(this as TreatmentPlanDto);
  }

  TreatmentPlanDtoCopyWith<TreatmentPlanDto, TreatmentPlanDto, TreatmentPlanDto>
  get copyWith =>
      _TreatmentPlanDtoCopyWithImpl<TreatmentPlanDto, TreatmentPlanDto>(
        this as TreatmentPlanDto,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TreatmentPlanDtoMapper.ensureInitialized().stringifyValue(
      this as TreatmentPlanDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return TreatmentPlanDtoMapper.ensureInitialized().equalsValue(
      this as TreatmentPlanDto,
      other,
    );
  }

  @override
  int get hashCode {
    return TreatmentPlanDtoMapper.ensureInitialized().hashValue(
      this as TreatmentPlanDto,
    );
  }
}

extension TreatmentPlanDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TreatmentPlanDto, $Out> {
  TreatmentPlanDtoCopyWith<$R, TreatmentPlanDto, $Out>
  get $asTreatmentPlanDto =>
      $base.as((v, t, t2) => _TreatmentPlanDtoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TreatmentPlanDtoCopyWith<$R, $In extends TreatmentPlanDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PatientCopyWith<$R, Patient, Patient>? get expandedPatient;
  ListCopyWith<
    $R,
    TreatmentPlanItem,
    TreatmentPlanItemCopyWith<$R, TreatmentPlanItem, TreatmentPlanItem>
  >
  get expandedItems;
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? patient,
    String? treatment,
    String? status,
    String? startDate,
    String? title,
    String? notes,
    bool? isDeleted,
    String? created,
    String? updated,
    Patient? expandedPatient,
    String? expandedTreatmentId,
    String? expandedTreatmentName,
    String? expandedTreatmentIcon,
    List<TreatmentPlanItem>? expandedItems,
  });
  TreatmentPlanDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _TreatmentPlanDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TreatmentPlanDto, $Out>
    implements TreatmentPlanDtoCopyWith<$R, TreatmentPlanDto, $Out> {
  _TreatmentPlanDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TreatmentPlanDto> $mapper =
      TreatmentPlanDtoMapper.ensureInitialized();
  @override
  PatientCopyWith<$R, Patient, Patient>? get expandedPatient =>
      $value.expandedPatient?.copyWith.$chain((v) => call(expandedPatient: v));
  @override
  ListCopyWith<
    $R,
    TreatmentPlanItem,
    TreatmentPlanItemCopyWith<$R, TreatmentPlanItem, TreatmentPlanItem>
  >
  get expandedItems => ListCopyWith(
    $value.expandedItems,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(expandedItems: v),
  );
  @override
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? patient,
    String? treatment,
    String? status,
    String? startDate,
    Object? title = $none,
    Object? notes = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
    Object? expandedPatient = $none,
    Object? expandedTreatmentId = $none,
    Object? expandedTreatmentName = $none,
    Object? expandedTreatmentIcon = $none,
    List<TreatmentPlanItem>? expandedItems,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (patient != null) #patient: patient,
      if (treatment != null) #treatment: treatment,
      if (status != null) #status: status,
      if (startDate != null) #startDate: startDate,
      if (title != $none) #title: title,
      if (notes != $none) #notes: notes,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
      if (expandedPatient != $none) #expandedPatient: expandedPatient,
      if (expandedTreatmentId != $none)
        #expandedTreatmentId: expandedTreatmentId,
      if (expandedTreatmentName != $none)
        #expandedTreatmentName: expandedTreatmentName,
      if (expandedTreatmentIcon != $none)
        #expandedTreatmentIcon: expandedTreatmentIcon,
      if (expandedItems != null) #expandedItems: expandedItems,
    }),
  );
  @override
  TreatmentPlanDto $make(CopyWithData data) => TreatmentPlanDto(
    id: data.get(#id, or: $value.id),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    patient: data.get(#patient, or: $value.patient),
    treatment: data.get(#treatment, or: $value.treatment),
    status: data.get(#status, or: $value.status),
    startDate: data.get(#startDate, or: $value.startDate),
    title: data.get(#title, or: $value.title),
    notes: data.get(#notes, or: $value.notes),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
    expandedPatient: data.get(#expandedPatient, or: $value.expandedPatient),
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
    expandedItems: data.get(#expandedItems, or: $value.expandedItems),
  );

  @override
  TreatmentPlanDtoCopyWith<$R2, TreatmentPlanDto, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TreatmentPlanDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

