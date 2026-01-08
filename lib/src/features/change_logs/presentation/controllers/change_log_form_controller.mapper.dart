// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'change_log_form_controller.dart';

class ChangeLogStateMapper extends ClassMapperBase<ChangeLogState> {
  ChangeLogStateMapper._();

  static ChangeLogStateMapper? _instance;
  static ChangeLogStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChangeLogStateMapper._());
      ChangeLogMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ChangeLogState';

  static ChangeLog? _$changeLog(ChangeLogState v) => v.changeLog;
  static const Field<ChangeLogState, ChangeLog> _f$changeLog = Field(
    'changeLog',
    _$changeLog,
  );

  @override
  final MappableFields<ChangeLogState> fields = const {
    #changeLog: _f$changeLog,
  };

  static ChangeLogState _instantiate(DecodingData data) {
    return ChangeLogState(changeLog: data.dec(_f$changeLog));
  }

  @override
  final Function instantiate = _instantiate;

  static ChangeLogState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChangeLogState>(map);
  }

  static ChangeLogState fromJson(String json) {
    return ensureInitialized().decodeJson<ChangeLogState>(json);
  }
}

mixin ChangeLogStateMappable {
  String toJson() {
    return ChangeLogStateMapper.ensureInitialized().encodeJson<ChangeLogState>(
      this as ChangeLogState,
    );
  }

  Map<String, dynamic> toMap() {
    return ChangeLogStateMapper.ensureInitialized().encodeMap<ChangeLogState>(
      this as ChangeLogState,
    );
  }

  ChangeLogStateCopyWith<ChangeLogState, ChangeLogState, ChangeLogState>
  get copyWith => _ChangeLogStateCopyWithImpl<ChangeLogState, ChangeLogState>(
    this as ChangeLogState,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ChangeLogStateMapper.ensureInitialized().stringifyValue(
      this as ChangeLogState,
    );
  }

  @override
  bool operator ==(Object other) {
    return ChangeLogStateMapper.ensureInitialized().equalsValue(
      this as ChangeLogState,
      other,
    );
  }

  @override
  int get hashCode {
    return ChangeLogStateMapper.ensureInitialized().hashValue(
      this as ChangeLogState,
    );
  }
}

extension ChangeLogStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ChangeLogState, $Out> {
  ChangeLogStateCopyWith<$R, ChangeLogState, $Out> get $asChangeLogState =>
      $base.as((v, t, t2) => _ChangeLogStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ChangeLogStateCopyWith<$R, $In extends ChangeLogState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ChangeLogCopyWith<$R, ChangeLog, ChangeLog>? get changeLog;
  $R call({ChangeLog? changeLog});
  ChangeLogStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ChangeLogStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChangeLogState, $Out>
    implements ChangeLogStateCopyWith<$R, ChangeLogState, $Out> {
  _ChangeLogStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChangeLogState> $mapper =
      ChangeLogStateMapper.ensureInitialized();
  @override
  ChangeLogCopyWith<$R, ChangeLog, ChangeLog>? get changeLog =>
      $value.changeLog?.copyWith.$chain((v) => call(changeLog: v));
  @override
  $R call({Object? changeLog = $none}) => $apply(
    FieldCopyWithData({if (changeLog != $none) #changeLog: changeLog}),
  );
  @override
  ChangeLogState $make(CopyWithData data) =>
      ChangeLogState(changeLog: data.get(#changeLog, or: $value.changeLog));

  @override
  ChangeLogStateCopyWith<$R2, ChangeLogState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ChangeLogStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

