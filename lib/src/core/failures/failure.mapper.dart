// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'failure.dart';

class FailureMapper extends ClassMapperBase<Failure> {
  FailureMapper._();

  static FailureMapper? _instance;
  static FailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FailureMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Failure';

  static dynamic _$message(Failure v) => v.message;
  static const Field<Failure, dynamic> _f$message =
      Field('message', _$message, opt: true);
  static StackTrace? _$stackTrace(Failure v) => v.stackTrace;
  static const Field<Failure, StackTrace> _f$stackTrace =
      Field('stackTrace', _$stackTrace, opt: true);
  static String? _$identifier(Failure v) => v.identifier;
  static const Field<Failure, String> _f$identifier =
      Field('identifier', _$identifier, opt: true);

  @override
  final MappableFields<Failure> fields = const {
    #message: _f$message,
    #stackTrace: _f$stackTrace,
    #identifier: _f$identifier,
  };

  static Failure _instantiate(DecodingData data) {
    return Failure(
        data.dec(_f$message), data.dec(_f$stackTrace), data.dec(_f$identifier));
  }

  @override
  final Function instantiate = _instantiate;

  static Failure fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Failure>(map);
  }

  static Failure fromJson(String json) {
    return ensureInitialized().decodeJson<Failure>(json);
  }
}

mixin FailureMappable {
  String toJson() {
    return FailureMapper.ensureInitialized()
        .encodeJson<Failure>(this as Failure);
  }

  Map<String, dynamic> toMap() {
    return FailureMapper.ensureInitialized()
        .encodeMap<Failure>(this as Failure);
  }

  FailureCopyWith<Failure, Failure, Failure> get copyWith =>
      _FailureCopyWithImpl(this as Failure, $identity, $identity);
  @override
  String toString() {
    return FailureMapper.ensureInitialized().stringifyValue(this as Failure);
  }

  @override
  bool operator ==(Object other) {
    return FailureMapper.ensureInitialized()
        .equalsValue(this as Failure, other);
  }

  @override
  int get hashCode {
    return FailureMapper.ensureInitialized().hashValue(this as Failure);
  }
}

extension FailureValueCopy<$R, $Out> on ObjectCopyWith<$R, Failure, $Out> {
  FailureCopyWith<$R, Failure, $Out> get $asFailure =>
      $base.as((v, t, t2) => _FailureCopyWithImpl(v, t, t2));
}

abstract class FailureCopyWith<$R, $In extends Failure, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({dynamic message, StackTrace? stackTrace, String? identifier});
  FailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FailureCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Failure, $Out>
    implements FailureCopyWith<$R, Failure, $Out> {
  _FailureCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Failure> $mapper =
      FailureMapper.ensureInitialized();
  @override
  $R call(
          {Object? message = $none,
          Object? stackTrace = $none,
          Object? identifier = $none}) =>
      $apply(FieldCopyWithData({
        if (message != $none) #message: message,
        if (stackTrace != $none) #stackTrace: stackTrace,
        if (identifier != $none) #identifier: identifier
      }));
  @override
  Failure $make(CopyWithData data) => Failure(
      data.get(#message, or: $value.message),
      data.get(#stackTrace, or: $value.stackTrace),
      data.get(#identifier, or: $value.identifier));

  @override
  FailureCopyWith<$R2, Failure, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FailureCopyWithImpl($value, $cast, t);
}
