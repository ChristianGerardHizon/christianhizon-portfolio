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
      AuthFailureMapper.ensureInitialized();
      PresentationFailureMapper.ensureInitialized();
      DataFailureMapper.ensureInitialized();
      UserCancelledFailureMapper.ensureInitialized();
      GenericFailureMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Failure';

  static dynamic _$message(Failure v) => v.message;
  static const Field<Failure, dynamic> _f$message = Field('message', _$message);
  static StackTrace? _$stackTrace(Failure v) => v.stackTrace;
  static const Field<Failure, StackTrace> _f$stackTrace =
      Field('stackTrace', _$stackTrace);
  static String? _$identifier(Failure v) => v.identifier;
  static const Field<Failure, String> _f$identifier =
      Field('identifier', _$identifier);

  @override
  final MappableFields<Failure> fields = const {
    #message: _f$message,
    #stackTrace: _f$stackTrace,
    #identifier: _f$identifier,
  };

  static Failure _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'Failure', 'type', '${data.value['type']}');
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
  String toJson();
  Map<String, dynamic> toMap();
  FailureCopyWith<Failure, Failure, Failure> get copyWith;
}

abstract class FailureCopyWith<$R, $In extends Failure, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({dynamic message, StackTrace? stackTrace, String? identifier});
  FailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class AuthFailureMapper extends SubClassMapperBase<AuthFailure> {
  AuthFailureMapper._();

  static AuthFailureMapper? _instance;
  static AuthFailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthFailureMapper._());
      FailureMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'AuthFailure';

  static dynamic _$message(AuthFailure v) => v.message;
  static const Field<AuthFailure, dynamic> _f$message =
      Field('message', _$message, opt: true);
  static StackTrace? _$stackTrace(AuthFailure v) => v.stackTrace;
  static const Field<AuthFailure, StackTrace> _f$stackTrace =
      Field('stackTrace', _$stackTrace, opt: true);
  static String? _$identifier(AuthFailure v) => v.identifier;
  static const Field<AuthFailure, String> _f$identifier =
      Field('identifier', _$identifier, opt: true);

  @override
  final MappableFields<AuthFailure> fields = const {
    #message: _f$message,
    #stackTrace: _f$stackTrace,
    #identifier: _f$identifier,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'AuthFailure';
  @override
  late final ClassMapperBase superMapper = FailureMapper.ensureInitialized();

  static AuthFailure _instantiate(DecodingData data) {
    return AuthFailure(
        data.dec(_f$message), data.dec(_f$stackTrace), data.dec(_f$identifier));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthFailure fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthFailure>(map);
  }

  static AuthFailure fromJson(String json) {
    return ensureInitialized().decodeJson<AuthFailure>(json);
  }
}

mixin AuthFailureMappable {
  String toJson() {
    return AuthFailureMapper.ensureInitialized()
        .encodeJson<AuthFailure>(this as AuthFailure);
  }

  Map<String, dynamic> toMap() {
    return AuthFailureMapper.ensureInitialized()
        .encodeMap<AuthFailure>(this as AuthFailure);
  }

  AuthFailureCopyWith<AuthFailure, AuthFailure, AuthFailure> get copyWith =>
      _AuthFailureCopyWithImpl<AuthFailure, AuthFailure>(
          this as AuthFailure, $identity, $identity);
  @override
  String toString() {
    return AuthFailureMapper.ensureInitialized()
        .stringifyValue(this as AuthFailure);
  }

  @override
  bool operator ==(Object other) {
    return AuthFailureMapper.ensureInitialized()
        .equalsValue(this as AuthFailure, other);
  }

  @override
  int get hashCode {
    return AuthFailureMapper.ensureInitialized().hashValue(this as AuthFailure);
  }
}

extension AuthFailureValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthFailure, $Out> {
  AuthFailureCopyWith<$R, AuthFailure, $Out> get $asAuthFailure =>
      $base.as((v, t, t2) => _AuthFailureCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthFailureCopyWith<$R, $In extends AuthFailure, $Out>
    implements FailureCopyWith<$R, $In, $Out> {
  @override
  $R call({dynamic message, StackTrace? stackTrace, String? identifier});
  AuthFailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AuthFailureCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthFailure, $Out>
    implements AuthFailureCopyWith<$R, AuthFailure, $Out> {
  _AuthFailureCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthFailure> $mapper =
      AuthFailureMapper.ensureInitialized();
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
  AuthFailure $make(CopyWithData data) => AuthFailure(
      data.get(#message, or: $value.message),
      data.get(#stackTrace, or: $value.stackTrace),
      data.get(#identifier, or: $value.identifier));

  @override
  AuthFailureCopyWith<$R2, AuthFailure, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthFailureCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PresentationFailureMapper
    extends SubClassMapperBase<PresentationFailure> {
  PresentationFailureMapper._();

  static PresentationFailureMapper? _instance;
  static PresentationFailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PresentationFailureMapper._());
      FailureMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'PresentationFailure';

  static dynamic _$message(PresentationFailure v) => v.message;
  static const Field<PresentationFailure, dynamic> _f$message =
      Field('message', _$message, opt: true);
  static StackTrace? _$stackTrace(PresentationFailure v) => v.stackTrace;
  static const Field<PresentationFailure, StackTrace> _f$stackTrace =
      Field('stackTrace', _$stackTrace, opt: true);
  static String? _$identifier(PresentationFailure v) => v.identifier;
  static const Field<PresentationFailure, String> _f$identifier =
      Field('identifier', _$identifier, opt: true);

  @override
  final MappableFields<PresentationFailure> fields = const {
    #message: _f$message,
    #stackTrace: _f$stackTrace,
    #identifier: _f$identifier,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'PresentationFailure';
  @override
  late final ClassMapperBase superMapper = FailureMapper.ensureInitialized();

  static PresentationFailure _instantiate(DecodingData data) {
    return PresentationFailure(
        data.dec(_f$message), data.dec(_f$stackTrace), data.dec(_f$identifier));
  }

  @override
  final Function instantiate = _instantiate;

  static PresentationFailure fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PresentationFailure>(map);
  }

  static PresentationFailure fromJson(String json) {
    return ensureInitialized().decodeJson<PresentationFailure>(json);
  }
}

mixin PresentationFailureMappable {
  String toJson() {
    return PresentationFailureMapper.ensureInitialized()
        .encodeJson<PresentationFailure>(this as PresentationFailure);
  }

  Map<String, dynamic> toMap() {
    return PresentationFailureMapper.ensureInitialized()
        .encodeMap<PresentationFailure>(this as PresentationFailure);
  }

  PresentationFailureCopyWith<PresentationFailure, PresentationFailure,
      PresentationFailure> get copyWith => _PresentationFailureCopyWithImpl<
          PresentationFailure, PresentationFailure>(
      this as PresentationFailure, $identity, $identity);
  @override
  String toString() {
    return PresentationFailureMapper.ensureInitialized()
        .stringifyValue(this as PresentationFailure);
  }

  @override
  bool operator ==(Object other) {
    return PresentationFailureMapper.ensureInitialized()
        .equalsValue(this as PresentationFailure, other);
  }

  @override
  int get hashCode {
    return PresentationFailureMapper.ensureInitialized()
        .hashValue(this as PresentationFailure);
  }
}

extension PresentationFailureValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PresentationFailure, $Out> {
  PresentationFailureCopyWith<$R, PresentationFailure, $Out>
      get $asPresentationFailure => $base.as(
          (v, t, t2) => _PresentationFailureCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PresentationFailureCopyWith<$R, $In extends PresentationFailure,
    $Out> implements FailureCopyWith<$R, $In, $Out> {
  @override
  $R call({dynamic message, StackTrace? stackTrace, String? identifier});
  PresentationFailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PresentationFailureCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PresentationFailure, $Out>
    implements PresentationFailureCopyWith<$R, PresentationFailure, $Out> {
  _PresentationFailureCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PresentationFailure> $mapper =
      PresentationFailureMapper.ensureInitialized();
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
  PresentationFailure $make(CopyWithData data) => PresentationFailure(
      data.get(#message, or: $value.message),
      data.get(#stackTrace, or: $value.stackTrace),
      data.get(#identifier, or: $value.identifier));

  @override
  PresentationFailureCopyWith<$R2, PresentationFailure, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _PresentationFailureCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DataFailureMapper extends SubClassMapperBase<DataFailure> {
  DataFailureMapper._();

  static DataFailureMapper? _instance;
  static DataFailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DataFailureMapper._());
      FailureMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'DataFailure';

  static dynamic _$message(DataFailure v) => v.message;
  static const Field<DataFailure, dynamic> _f$message =
      Field('message', _$message, opt: true);
  static StackTrace? _$stackTrace(DataFailure v) => v.stackTrace;
  static const Field<DataFailure, StackTrace> _f$stackTrace =
      Field('stackTrace', _$stackTrace, opt: true);
  static String? _$identifier(DataFailure v) => v.identifier;
  static const Field<DataFailure, String> _f$identifier =
      Field('identifier', _$identifier, opt: true);

  @override
  final MappableFields<DataFailure> fields = const {
    #message: _f$message,
    #stackTrace: _f$stackTrace,
    #identifier: _f$identifier,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'DataFailure';
  @override
  late final ClassMapperBase superMapper = FailureMapper.ensureInitialized();

  static DataFailure _instantiate(DecodingData data) {
    return DataFailure(
        data.dec(_f$message), data.dec(_f$stackTrace), data.dec(_f$identifier));
  }

  @override
  final Function instantiate = _instantiate;

  static DataFailure fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DataFailure>(map);
  }

  static DataFailure fromJson(String json) {
    return ensureInitialized().decodeJson<DataFailure>(json);
  }
}

mixin DataFailureMappable {
  String toJson() {
    return DataFailureMapper.ensureInitialized()
        .encodeJson<DataFailure>(this as DataFailure);
  }

  Map<String, dynamic> toMap() {
    return DataFailureMapper.ensureInitialized()
        .encodeMap<DataFailure>(this as DataFailure);
  }

  DataFailureCopyWith<DataFailure, DataFailure, DataFailure> get copyWith =>
      _DataFailureCopyWithImpl<DataFailure, DataFailure>(
          this as DataFailure, $identity, $identity);
  @override
  String toString() {
    return DataFailureMapper.ensureInitialized()
        .stringifyValue(this as DataFailure);
  }

  @override
  bool operator ==(Object other) {
    return DataFailureMapper.ensureInitialized()
        .equalsValue(this as DataFailure, other);
  }

  @override
  int get hashCode {
    return DataFailureMapper.ensureInitialized().hashValue(this as DataFailure);
  }
}

extension DataFailureValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DataFailure, $Out> {
  DataFailureCopyWith<$R, DataFailure, $Out> get $asDataFailure =>
      $base.as((v, t, t2) => _DataFailureCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DataFailureCopyWith<$R, $In extends DataFailure, $Out>
    implements FailureCopyWith<$R, $In, $Out> {
  @override
  $R call({dynamic message, StackTrace? stackTrace, String? identifier});
  DataFailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DataFailureCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DataFailure, $Out>
    implements DataFailureCopyWith<$R, DataFailure, $Out> {
  _DataFailureCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DataFailure> $mapper =
      DataFailureMapper.ensureInitialized();
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
  DataFailure $make(CopyWithData data) => DataFailure(
      data.get(#message, or: $value.message),
      data.get(#stackTrace, or: $value.stackTrace),
      data.get(#identifier, or: $value.identifier));

  @override
  DataFailureCopyWith<$R2, DataFailure, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DataFailureCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class UserCancelledFailureMapper
    extends SubClassMapperBase<UserCancelledFailure> {
  UserCancelledFailureMapper._();

  static UserCancelledFailureMapper? _instance;
  static UserCancelledFailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserCancelledFailureMapper._());
      FailureMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'UserCancelledFailure';

  static dynamic _$message(UserCancelledFailure v) => v.message;
  static const Field<UserCancelledFailure, dynamic> _f$message =
      Field('message', _$message, opt: true);
  static StackTrace? _$stackTrace(UserCancelledFailure v) => v.stackTrace;
  static const Field<UserCancelledFailure, StackTrace> _f$stackTrace =
      Field('stackTrace', _$stackTrace, opt: true);
  static String? _$identifier(UserCancelledFailure v) => v.identifier;
  static const Field<UserCancelledFailure, String> _f$identifier =
      Field('identifier', _$identifier, opt: true);

  @override
  final MappableFields<UserCancelledFailure> fields = const {
    #message: _f$message,
    #stackTrace: _f$stackTrace,
    #identifier: _f$identifier,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'UserCancelledFailure';
  @override
  late final ClassMapperBase superMapper = FailureMapper.ensureInitialized();

  static UserCancelledFailure _instantiate(DecodingData data) {
    return UserCancelledFailure(
        data.dec(_f$message), data.dec(_f$stackTrace), data.dec(_f$identifier));
  }

  @override
  final Function instantiate = _instantiate;

  static UserCancelledFailure fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserCancelledFailure>(map);
  }

  static UserCancelledFailure fromJson(String json) {
    return ensureInitialized().decodeJson<UserCancelledFailure>(json);
  }
}

mixin UserCancelledFailureMappable {
  String toJson() {
    return UserCancelledFailureMapper.ensureInitialized()
        .encodeJson<UserCancelledFailure>(this as UserCancelledFailure);
  }

  Map<String, dynamic> toMap() {
    return UserCancelledFailureMapper.ensureInitialized()
        .encodeMap<UserCancelledFailure>(this as UserCancelledFailure);
  }

  UserCancelledFailureCopyWith<UserCancelledFailure, UserCancelledFailure,
      UserCancelledFailure> get copyWith => _UserCancelledFailureCopyWithImpl<
          UserCancelledFailure, UserCancelledFailure>(
      this as UserCancelledFailure, $identity, $identity);
  @override
  String toString() {
    return UserCancelledFailureMapper.ensureInitialized()
        .stringifyValue(this as UserCancelledFailure);
  }

  @override
  bool operator ==(Object other) {
    return UserCancelledFailureMapper.ensureInitialized()
        .equalsValue(this as UserCancelledFailure, other);
  }

  @override
  int get hashCode {
    return UserCancelledFailureMapper.ensureInitialized()
        .hashValue(this as UserCancelledFailure);
  }
}

extension UserCancelledFailureValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserCancelledFailure, $Out> {
  UserCancelledFailureCopyWith<$R, UserCancelledFailure, $Out>
      get $asUserCancelledFailure => $base.as(
          (v, t, t2) => _UserCancelledFailureCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserCancelledFailureCopyWith<
    $R,
    $In extends UserCancelledFailure,
    $Out> implements FailureCopyWith<$R, $In, $Out> {
  @override
  $R call({dynamic message, StackTrace? stackTrace, String? identifier});
  UserCancelledFailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _UserCancelledFailureCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserCancelledFailure, $Out>
    implements UserCancelledFailureCopyWith<$R, UserCancelledFailure, $Out> {
  _UserCancelledFailureCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserCancelledFailure> $mapper =
      UserCancelledFailureMapper.ensureInitialized();
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
  UserCancelledFailure $make(CopyWithData data) => UserCancelledFailure(
      data.get(#message, or: $value.message),
      data.get(#stackTrace, or: $value.stackTrace),
      data.get(#identifier, or: $value.identifier));

  @override
  UserCancelledFailureCopyWith<$R2, UserCancelledFailure, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _UserCancelledFailureCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class GenericFailureMapper extends SubClassMapperBase<GenericFailure> {
  GenericFailureMapper._();

  static GenericFailureMapper? _instance;
  static GenericFailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GenericFailureMapper._());
      FailureMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'GenericFailure';

  static dynamic _$message(GenericFailure v) => v.message;
  static const Field<GenericFailure, dynamic> _f$message =
      Field('message', _$message, opt: true);
  static StackTrace? _$stackTrace(GenericFailure v) => v.stackTrace;
  static const Field<GenericFailure, StackTrace> _f$stackTrace =
      Field('stackTrace', _$stackTrace, opt: true);
  static String? _$identifier(GenericFailure v) => v.identifier;
  static const Field<GenericFailure, String> _f$identifier =
      Field('identifier', _$identifier, opt: true);

  @override
  final MappableFields<GenericFailure> fields = const {
    #message: _f$message,
    #stackTrace: _f$stackTrace,
    #identifier: _f$identifier,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'GenericFailure';
  @override
  late final ClassMapperBase superMapper = FailureMapper.ensureInitialized();

  static GenericFailure _instantiate(DecodingData data) {
    return GenericFailure(
        data.dec(_f$message), data.dec(_f$stackTrace), data.dec(_f$identifier));
  }

  @override
  final Function instantiate = _instantiate;

  static GenericFailure fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GenericFailure>(map);
  }

  static GenericFailure fromJson(String json) {
    return ensureInitialized().decodeJson<GenericFailure>(json);
  }
}

mixin GenericFailureMappable {
  String toJson() {
    return GenericFailureMapper.ensureInitialized()
        .encodeJson<GenericFailure>(this as GenericFailure);
  }

  Map<String, dynamic> toMap() {
    return GenericFailureMapper.ensureInitialized()
        .encodeMap<GenericFailure>(this as GenericFailure);
  }

  GenericFailureCopyWith<GenericFailure, GenericFailure, GenericFailure>
      get copyWith =>
          _GenericFailureCopyWithImpl<GenericFailure, GenericFailure>(
              this as GenericFailure, $identity, $identity);
  @override
  String toString() {
    return GenericFailureMapper.ensureInitialized()
        .stringifyValue(this as GenericFailure);
  }

  @override
  bool operator ==(Object other) {
    return GenericFailureMapper.ensureInitialized()
        .equalsValue(this as GenericFailure, other);
  }

  @override
  int get hashCode {
    return GenericFailureMapper.ensureInitialized()
        .hashValue(this as GenericFailure);
  }
}

extension GenericFailureValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GenericFailure, $Out> {
  GenericFailureCopyWith<$R, GenericFailure, $Out> get $asGenericFailure =>
      $base.as((v, t, t2) => _GenericFailureCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GenericFailureCopyWith<$R, $In extends GenericFailure, $Out>
    implements FailureCopyWith<$R, $In, $Out> {
  @override
  $R call({dynamic message, StackTrace? stackTrace, String? identifier});
  GenericFailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GenericFailureCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GenericFailure, $Out>
    implements GenericFailureCopyWith<$R, GenericFailure, $Out> {
  _GenericFailureCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GenericFailure> $mapper =
      GenericFailureMapper.ensureInitialized();
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
  GenericFailure $make(CopyWithData data) => GenericFailure(
      data.get(#message, or: $value.message),
      data.get(#stackTrace, or: $value.stackTrace),
      data.get(#identifier, or: $value.identifier));

  @override
  GenericFailureCopyWith<$R2, GenericFailure, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GenericFailureCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
