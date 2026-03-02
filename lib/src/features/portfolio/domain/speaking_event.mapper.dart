// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'speaking_event.dart';

class SpeakingEventMapper extends ClassMapperBase<SpeakingEvent> {
  SpeakingEventMapper._();

  static SpeakingEventMapper? _instance;
  static SpeakingEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SpeakingEventMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SpeakingEvent';

  static String _$id(SpeakingEvent v) => v.id;
  static const Field<SpeakingEvent, String> _f$id = Field('id', _$id);
  static String _$title(SpeakingEvent v) => v.title;
  static const Field<SpeakingEvent, String> _f$title = Field('title', _$title);
  static String _$organization(SpeakingEvent v) => v.organization;
  static const Field<SpeakingEvent, String> _f$organization = Field(
    'organization',
    _$organization,
  );
  static String _$date(SpeakingEvent v) => v.date;
  static const Field<SpeakingEvent, String> _f$date = Field('date', _$date);
  static String _$description(SpeakingEvent v) => v.description;
  static const Field<SpeakingEvent, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static String _$type(SpeakingEvent v) => v.type;
  static const Field<SpeakingEvent, String> _f$type = Field(
    'type',
    _$type,
    opt: true,
    def: '',
  );
  static int _$sortOrder(SpeakingEvent v) => v.sortOrder;
  static const Field<SpeakingEvent, int> _f$sortOrder = Field(
    'sortOrder',
    _$sortOrder,
    opt: true,
    def: 0,
  );

  @override
  final MappableFields<SpeakingEvent> fields = const {
    #id: _f$id,
    #title: _f$title,
    #organization: _f$organization,
    #date: _f$date,
    #description: _f$description,
    #type: _f$type,
    #sortOrder: _f$sortOrder,
  };

  static SpeakingEvent _instantiate(DecodingData data) {
    return SpeakingEvent(
      id: data.dec(_f$id),
      title: data.dec(_f$title),
      organization: data.dec(_f$organization),
      date: data.dec(_f$date),
      description: data.dec(_f$description),
      type: data.dec(_f$type),
      sortOrder: data.dec(_f$sortOrder),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SpeakingEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SpeakingEvent>(map);
  }

  static SpeakingEvent fromJson(String json) {
    return ensureInitialized().decodeJson<SpeakingEvent>(json);
  }
}

mixin SpeakingEventMappable {
  String toJson() {
    return SpeakingEventMapper.ensureInitialized().encodeJson<SpeakingEvent>(
      this as SpeakingEvent,
    );
  }

  Map<String, dynamic> toMap() {
    return SpeakingEventMapper.ensureInitialized().encodeMap<SpeakingEvent>(
      this as SpeakingEvent,
    );
  }

  SpeakingEventCopyWith<SpeakingEvent, SpeakingEvent, SpeakingEvent>
  get copyWith => _SpeakingEventCopyWithImpl<SpeakingEvent, SpeakingEvent>(
    this as SpeakingEvent,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return SpeakingEventMapper.ensureInitialized().stringifyValue(
      this as SpeakingEvent,
    );
  }

  @override
  bool operator ==(Object other) {
    return SpeakingEventMapper.ensureInitialized().equalsValue(
      this as SpeakingEvent,
      other,
    );
  }

  @override
  int get hashCode {
    return SpeakingEventMapper.ensureInitialized().hashValue(
      this as SpeakingEvent,
    );
  }
}

extension SpeakingEventValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SpeakingEvent, $Out> {
  SpeakingEventCopyWith<$R, SpeakingEvent, $Out> get $asSpeakingEvent =>
      $base.as((v, t, t2) => _SpeakingEventCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SpeakingEventCopyWith<$R, $In extends SpeakingEvent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? title,
    String? organization,
    String? date,
    String? description,
    String? type,
    int? sortOrder,
  });
  SpeakingEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SpeakingEventCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SpeakingEvent, $Out>
    implements SpeakingEventCopyWith<$R, SpeakingEvent, $Out> {
  _SpeakingEventCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SpeakingEvent> $mapper =
      SpeakingEventMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? title,
    String? organization,
    String? date,
    String? description,
    String? type,
    int? sortOrder,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (title != null) #title: title,
      if (organization != null) #organization: organization,
      if (date != null) #date: date,
      if (description != null) #description: description,
      if (type != null) #type: type,
      if (sortOrder != null) #sortOrder: sortOrder,
    }),
  );
  @override
  SpeakingEvent $make(CopyWithData data) => SpeakingEvent(
    id: data.get(#id, or: $value.id),
    title: data.get(#title, or: $value.title),
    organization: data.get(#organization, or: $value.organization),
    date: data.get(#date, or: $value.date),
    description: data.get(#description, or: $value.description),
    type: data.get(#type, or: $value.type),
    sortOrder: data.get(#sortOrder, or: $value.sortOrder),
  );

  @override
  SpeakingEventCopyWith<$R2, SpeakingEvent, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SpeakingEventCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

