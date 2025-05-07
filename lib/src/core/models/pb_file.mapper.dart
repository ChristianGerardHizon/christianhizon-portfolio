// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pb_file.dart';

class PBFileMapper extends ClassMapperBase<PBFile> {
  PBFileMapper._();

  static PBFileMapper? _instance;
  static PBFileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PBFileMapper._());
      PBLocalFileMapper.ensureInitialized();
      PBNetworkFileMapper.ensureInitialized();
      PBMemoryFileMapper.ensureInitialized();
      PBPlaceholderImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PBFile';

  static String? _$field(PBFile v) => v.field;
  static const Field<PBFile, String> _f$field = Field('field', _$field);
  static String? _$id(PBFile v) => v.id;
  static const Field<PBFile, String> _f$id = Field('id', _$id, opt: true);
  static bool _$isDeleted(PBFile v) => v.isDeleted;
  static const Field<PBFile, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);

  @override
  final MappableFields<PBFile> fields = const {
    #field: _f$field,
    #id: _f$id,
    #isDeleted: _f$isDeleted,
  };

  static PBFile _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'PBFile', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static PBFile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PBFile>(map);
  }

  static PBFile fromJson(String json) {
    return ensureInitialized().decodeJson<PBFile>(json);
  }
}

mixin PBFileMappable {
  String toJson();
  Map<String, dynamic> toMap();
  PBFileCopyWith<PBFile, PBFile, PBFile> get copyWith;
}

abstract class PBFileCopyWith<$R, $In extends PBFile, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? field, String? id, bool? isDeleted});
  PBFileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class PBLocalFileMapper extends SubClassMapperBase<PBLocalFile> {
  PBLocalFileMapper._();

  static PBLocalFileMapper? _instance;
  static PBLocalFileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PBLocalFileMapper._());
      PBFileMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'PBLocalFile';

  static String? _$field(PBLocalFile v) => v.field;
  static const Field<PBLocalFile, String> _f$field =
      Field('field', _$field, opt: true);
  static String? _$id(PBLocalFile v) => v.id;
  static const Field<PBLocalFile, String> _f$id = Field('id', _$id, opt: true);
  static String _$name(PBLocalFile v) => v.name;
  static const Field<PBLocalFile, String> _f$name = Field('name', _$name);
  static int _$size(PBLocalFile v) => v.size;
  static const Field<PBLocalFile, int> _f$size = Field('size', _$size);
  static Uint8List _$bytes(PBLocalFile v) => v.bytes;
  static const Field<PBLocalFile, Uint8List> _f$bytes = Field('bytes', _$bytes);
  static String _$path(PBLocalFile v) => v.path;
  static const Field<PBLocalFile, String> _f$path = Field('path', _$path);
  static bool _$isDeleted(PBLocalFile v) => v.isDeleted;
  static const Field<PBLocalFile, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);

  @override
  final MappableFields<PBLocalFile> fields = const {
    #field: _f$field,
    #id: _f$id,
    #name: _f$name,
    #size: _f$size,
    #bytes: _f$bytes,
    #path: _f$path,
    #isDeleted: _f$isDeleted,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'local';
  @override
  late final ClassMapperBase superMapper = PBFileMapper.ensureInitialized();

  static PBLocalFile _instantiate(DecodingData data) {
    return PBLocalFile(
        field: data.dec(_f$field),
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        size: data.dec(_f$size),
        bytes: data.dec(_f$bytes),
        path: data.dec(_f$path),
        isDeleted: data.dec(_f$isDeleted));
  }

  @override
  final Function instantiate = _instantiate;

  static PBLocalFile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PBLocalFile>(map);
  }

  static PBLocalFile fromJson(String json) {
    return ensureInitialized().decodeJson<PBLocalFile>(json);
  }
}

mixin PBLocalFileMappable {
  String toJson() {
    return PBLocalFileMapper.ensureInitialized()
        .encodeJson<PBLocalFile>(this as PBLocalFile);
  }

  Map<String, dynamic> toMap() {
    return PBLocalFileMapper.ensureInitialized()
        .encodeMap<PBLocalFile>(this as PBLocalFile);
  }

  PBLocalFileCopyWith<PBLocalFile, PBLocalFile, PBLocalFile> get copyWith =>
      _PBLocalFileCopyWithImpl<PBLocalFile, PBLocalFile>(
          this as PBLocalFile, $identity, $identity);
  @override
  String toString() {
    return PBLocalFileMapper.ensureInitialized()
        .stringifyValue(this as PBLocalFile);
  }

  @override
  bool operator ==(Object other) {
    return PBLocalFileMapper.ensureInitialized()
        .equalsValue(this as PBLocalFile, other);
  }

  @override
  int get hashCode {
    return PBLocalFileMapper.ensureInitialized().hashValue(this as PBLocalFile);
  }
}

extension PBLocalFileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PBLocalFile, $Out> {
  PBLocalFileCopyWith<$R, PBLocalFile, $Out> get $asPBLocalFile =>
      $base.as((v, t, t2) => _PBLocalFileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PBLocalFileCopyWith<$R, $In extends PBLocalFile, $Out>
    implements PBFileCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? field,
      String? id,
      String? name,
      int? size,
      Uint8List? bytes,
      String? path,
      bool? isDeleted});
  PBLocalFileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PBLocalFileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PBLocalFile, $Out>
    implements PBLocalFileCopyWith<$R, PBLocalFile, $Out> {
  _PBLocalFileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PBLocalFile> $mapper =
      PBLocalFileMapper.ensureInitialized();
  @override
  $R call(
          {Object? field = $none,
          Object? id = $none,
          String? name,
          int? size,
          Uint8List? bytes,
          String? path,
          bool? isDeleted}) =>
      $apply(FieldCopyWithData({
        if (field != $none) #field: field,
        if (id != $none) #id: id,
        if (name != null) #name: name,
        if (size != null) #size: size,
        if (bytes != null) #bytes: bytes,
        if (path != null) #path: path,
        if (isDeleted != null) #isDeleted: isDeleted
      }));
  @override
  PBLocalFile $make(CopyWithData data) => PBLocalFile(
      field: data.get(#field, or: $value.field),
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      size: data.get(#size, or: $value.size),
      bytes: data.get(#bytes, or: $value.bytes),
      path: data.get(#path, or: $value.path),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted));

  @override
  PBLocalFileCopyWith<$R2, PBLocalFile, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PBLocalFileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PBNetworkFileMapper extends SubClassMapperBase<PBNetworkFile> {
  PBNetworkFileMapper._();

  static PBNetworkFileMapper? _instance;
  static PBNetworkFileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PBNetworkFileMapper._());
      PBFileMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'PBNetworkFile';

  static String? _$field(PBNetworkFile v) => v.field;
  static const Field<PBNetworkFile, String> _f$field =
      Field('field', _$field, opt: true);
  static String? _$id(PBNetworkFile v) => v.id;
  static const Field<PBNetworkFile, String> _f$id =
      Field('id', _$id, opt: true);
  static Uri _$uri(PBNetworkFile v) => v.uri;
  static const Field<PBNetworkFile, Uri> _f$uri = Field('uri', _$uri);
  static String _$fileName(PBNetworkFile v) => v.fileName;
  static const Field<PBNetworkFile, String> _f$fileName =
      Field('fileName', _$fileName);
  static bool _$isDeleted(PBNetworkFile v) => v.isDeleted;
  static const Field<PBNetworkFile, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);

  @override
  final MappableFields<PBNetworkFile> fields = const {
    #field: _f$field,
    #id: _f$id,
    #uri: _f$uri,
    #fileName: _f$fileName,
    #isDeleted: _f$isDeleted,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'network';
  @override
  late final ClassMapperBase superMapper = PBFileMapper.ensureInitialized();

  static PBNetworkFile _instantiate(DecodingData data) {
    return PBNetworkFile(
        field: data.dec(_f$field),
        id: data.dec(_f$id),
        uri: data.dec(_f$uri),
        fileName: data.dec(_f$fileName),
        isDeleted: data.dec(_f$isDeleted));
  }

  @override
  final Function instantiate = _instantiate;

  static PBNetworkFile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PBNetworkFile>(map);
  }

  static PBNetworkFile fromJson(String json) {
    return ensureInitialized().decodeJson<PBNetworkFile>(json);
  }
}

mixin PBNetworkFileMappable {
  String toJson() {
    return PBNetworkFileMapper.ensureInitialized()
        .encodeJson<PBNetworkFile>(this as PBNetworkFile);
  }

  Map<String, dynamic> toMap() {
    return PBNetworkFileMapper.ensureInitialized()
        .encodeMap<PBNetworkFile>(this as PBNetworkFile);
  }

  PBNetworkFileCopyWith<PBNetworkFile, PBNetworkFile, PBNetworkFile>
      get copyWith => _PBNetworkFileCopyWithImpl<PBNetworkFile, PBNetworkFile>(
          this as PBNetworkFile, $identity, $identity);
  @override
  String toString() {
    return PBNetworkFileMapper.ensureInitialized()
        .stringifyValue(this as PBNetworkFile);
  }

  @override
  bool operator ==(Object other) {
    return PBNetworkFileMapper.ensureInitialized()
        .equalsValue(this as PBNetworkFile, other);
  }

  @override
  int get hashCode {
    return PBNetworkFileMapper.ensureInitialized()
        .hashValue(this as PBNetworkFile);
  }
}

extension PBNetworkFileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PBNetworkFile, $Out> {
  PBNetworkFileCopyWith<$R, PBNetworkFile, $Out> get $asPBNetworkFile =>
      $base.as((v, t, t2) => _PBNetworkFileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PBNetworkFileCopyWith<$R, $In extends PBNetworkFile, $Out>
    implements PBFileCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? field, String? id, Uri? uri, String? fileName, bool? isDeleted});
  PBNetworkFileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PBNetworkFileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PBNetworkFile, $Out>
    implements PBNetworkFileCopyWith<$R, PBNetworkFile, $Out> {
  _PBNetworkFileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PBNetworkFile> $mapper =
      PBNetworkFileMapper.ensureInitialized();
  @override
  $R call(
          {Object? field = $none,
          Object? id = $none,
          Uri? uri,
          String? fileName,
          bool? isDeleted}) =>
      $apply(FieldCopyWithData({
        if (field != $none) #field: field,
        if (id != $none) #id: id,
        if (uri != null) #uri: uri,
        if (fileName != null) #fileName: fileName,
        if (isDeleted != null) #isDeleted: isDeleted
      }));
  @override
  PBNetworkFile $make(CopyWithData data) => PBNetworkFile(
      field: data.get(#field, or: $value.field),
      id: data.get(#id, or: $value.id),
      uri: data.get(#uri, or: $value.uri),
      fileName: data.get(#fileName, or: $value.fileName),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted));

  @override
  PBNetworkFileCopyWith<$R2, PBNetworkFile, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PBNetworkFileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PBMemoryFileMapper extends SubClassMapperBase<PBMemoryFile> {
  PBMemoryFileMapper._();

  static PBMemoryFileMapper? _instance;
  static PBMemoryFileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PBMemoryFileMapper._());
      PBFileMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'PBMemoryFile';

  static String? _$field(PBMemoryFile v) => v.field;
  static const Field<PBMemoryFile, String> _f$field =
      Field('field', _$field, opt: true);
  static String? _$id(PBMemoryFile v) => v.id;
  static const Field<PBMemoryFile, String> _f$id = Field('id', _$id, opt: true);
  static Uint8List _$bytes(PBMemoryFile v) => v.bytes;
  static const Field<PBMemoryFile, Uint8List> _f$bytes =
      Field('bytes', _$bytes);
  static String _$fullFilename(PBMemoryFile v) => v.fullFilename;
  static const Field<PBMemoryFile, String> _f$fullFilename =
      Field('fullFilename', _$fullFilename);
  static bool _$isDeleted(PBMemoryFile v) => v.isDeleted;
  static const Field<PBMemoryFile, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);

  @override
  final MappableFields<PBMemoryFile> fields = const {
    #field: _f$field,
    #id: _f$id,
    #bytes: _f$bytes,
    #fullFilename: _f$fullFilename,
    #isDeleted: _f$isDeleted,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'memory';
  @override
  late final ClassMapperBase superMapper = PBFileMapper.ensureInitialized();

  static PBMemoryFile _instantiate(DecodingData data) {
    return PBMemoryFile(
        field: data.dec(_f$field),
        id: data.dec(_f$id),
        bytes: data.dec(_f$bytes),
        fullFilename: data.dec(_f$fullFilename),
        isDeleted: data.dec(_f$isDeleted));
  }

  @override
  final Function instantiate = _instantiate;

  static PBMemoryFile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PBMemoryFile>(map);
  }

  static PBMemoryFile fromJson(String json) {
    return ensureInitialized().decodeJson<PBMemoryFile>(json);
  }
}

mixin PBMemoryFileMappable {
  String toJson() {
    return PBMemoryFileMapper.ensureInitialized()
        .encodeJson<PBMemoryFile>(this as PBMemoryFile);
  }

  Map<String, dynamic> toMap() {
    return PBMemoryFileMapper.ensureInitialized()
        .encodeMap<PBMemoryFile>(this as PBMemoryFile);
  }

  PBMemoryFileCopyWith<PBMemoryFile, PBMemoryFile, PBMemoryFile> get copyWith =>
      _PBMemoryFileCopyWithImpl<PBMemoryFile, PBMemoryFile>(
          this as PBMemoryFile, $identity, $identity);
  @override
  String toString() {
    return PBMemoryFileMapper.ensureInitialized()
        .stringifyValue(this as PBMemoryFile);
  }

  @override
  bool operator ==(Object other) {
    return PBMemoryFileMapper.ensureInitialized()
        .equalsValue(this as PBMemoryFile, other);
  }

  @override
  int get hashCode {
    return PBMemoryFileMapper.ensureInitialized()
        .hashValue(this as PBMemoryFile);
  }
}

extension PBMemoryFileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PBMemoryFile, $Out> {
  PBMemoryFileCopyWith<$R, PBMemoryFile, $Out> get $asPBMemoryFile =>
      $base.as((v, t, t2) => _PBMemoryFileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PBMemoryFileCopyWith<$R, $In extends PBMemoryFile, $Out>
    implements PBFileCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? field,
      String? id,
      Uint8List? bytes,
      String? fullFilename,
      bool? isDeleted});
  PBMemoryFileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PBMemoryFileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PBMemoryFile, $Out>
    implements PBMemoryFileCopyWith<$R, PBMemoryFile, $Out> {
  _PBMemoryFileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PBMemoryFile> $mapper =
      PBMemoryFileMapper.ensureInitialized();
  @override
  $R call(
          {Object? field = $none,
          Object? id = $none,
          Uint8List? bytes,
          String? fullFilename,
          bool? isDeleted}) =>
      $apply(FieldCopyWithData({
        if (field != $none) #field: field,
        if (id != $none) #id: id,
        if (bytes != null) #bytes: bytes,
        if (fullFilename != null) #fullFilename: fullFilename,
        if (isDeleted != null) #isDeleted: isDeleted
      }));
  @override
  PBMemoryFile $make(CopyWithData data) => PBMemoryFile(
      field: data.get(#field, or: $value.field),
      id: data.get(#id, or: $value.id),
      bytes: data.get(#bytes, or: $value.bytes),
      fullFilename: data.get(#fullFilename, or: $value.fullFilename),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted));

  @override
  PBMemoryFileCopyWith<$R2, PBMemoryFile, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PBMemoryFileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PBPlaceholderImageMapper extends SubClassMapperBase<PBPlaceholderImage> {
  PBPlaceholderImageMapper._();

  static PBPlaceholderImageMapper? _instance;
  static PBPlaceholderImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PBPlaceholderImageMapper._());
      PBFileMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'PBPlaceholderImage';

  static String? _$field(PBPlaceholderImage v) => v.field;
  static const Field<PBPlaceholderImage, String> _f$field =
      Field('field', _$field, opt: true);
  static String? _$id(PBPlaceholderImage v) => v.id;
  static const Field<PBPlaceholderImage, String> _f$id =
      Field('id', _$id, opt: true, def: '');
  static bool _$isDeleted(PBPlaceholderImage v) => v.isDeleted;
  static const Field<PBPlaceholderImage, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);

  @override
  final MappableFields<PBPlaceholderImage> fields = const {
    #field: _f$field,
    #id: _f$id,
    #isDeleted: _f$isDeleted,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'placeholder';
  @override
  late final ClassMapperBase superMapper = PBFileMapper.ensureInitialized();

  static PBPlaceholderImage _instantiate(DecodingData data) {
    return PBPlaceholderImage(
        field: data.dec(_f$field),
        id: data.dec(_f$id),
        isDeleted: data.dec(_f$isDeleted));
  }

  @override
  final Function instantiate = _instantiate;

  static PBPlaceholderImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PBPlaceholderImage>(map);
  }

  static PBPlaceholderImage fromJson(String json) {
    return ensureInitialized().decodeJson<PBPlaceholderImage>(json);
  }
}

mixin PBPlaceholderImageMappable {
  String toJson() {
    return PBPlaceholderImageMapper.ensureInitialized()
        .encodeJson<PBPlaceholderImage>(this as PBPlaceholderImage);
  }

  Map<String, dynamic> toMap() {
    return PBPlaceholderImageMapper.ensureInitialized()
        .encodeMap<PBPlaceholderImage>(this as PBPlaceholderImage);
  }

  PBPlaceholderImageCopyWith<PBPlaceholderImage, PBPlaceholderImage,
          PBPlaceholderImage>
      get copyWith => _PBPlaceholderImageCopyWithImpl<PBPlaceholderImage,
          PBPlaceholderImage>(this as PBPlaceholderImage, $identity, $identity);
  @override
  String toString() {
    return PBPlaceholderImageMapper.ensureInitialized()
        .stringifyValue(this as PBPlaceholderImage);
  }

  @override
  bool operator ==(Object other) {
    return PBPlaceholderImageMapper.ensureInitialized()
        .equalsValue(this as PBPlaceholderImage, other);
  }

  @override
  int get hashCode {
    return PBPlaceholderImageMapper.ensureInitialized()
        .hashValue(this as PBPlaceholderImage);
  }
}

extension PBPlaceholderImageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PBPlaceholderImage, $Out> {
  PBPlaceholderImageCopyWith<$R, PBPlaceholderImage, $Out>
      get $asPBPlaceholderImage => $base.as(
          (v, t, t2) => _PBPlaceholderImageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PBPlaceholderImageCopyWith<$R, $In extends PBPlaceholderImage,
    $Out> implements PBFileCopyWith<$R, $In, $Out> {
  @override
  $R call({String? field, String? id, bool? isDeleted});
  PBPlaceholderImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PBPlaceholderImageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PBPlaceholderImage, $Out>
    implements PBPlaceholderImageCopyWith<$R, PBPlaceholderImage, $Out> {
  _PBPlaceholderImageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PBPlaceholderImage> $mapper =
      PBPlaceholderImageMapper.ensureInitialized();
  @override
  $R call({Object? field = $none, Object? id = $none, bool? isDeleted}) =>
      $apply(FieldCopyWithData({
        if (field != $none) #field: field,
        if (id != $none) #id: id,
        if (isDeleted != null) #isDeleted: isDeleted
      }));
  @override
  PBPlaceholderImage $make(CopyWithData data) => PBPlaceholderImage(
      field: data.get(#field, or: $value.field),
      id: data.get(#id, or: $value.id),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted));

  @override
  PBPlaceholderImageCopyWith<$R2, PBPlaceholderImage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PBPlaceholderImageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
