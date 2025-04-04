// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pb_image.dart';

class PBImageMapper extends ClassMapperBase<PBImage> {
  PBImageMapper._();

  static PBImageMapper? _instance;
  static PBImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PBImageMapper._());
      PBLocalImageMapper.ensureInitialized();
      PBNetworkImageMapper.ensureInitialized();
      PBMemoryImageMapper.ensureInitialized();
      PBPlaceholderImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PBImage';

  static String? _$field(PBImage v) => v.field;
  static const Field<PBImage, String> _f$field = Field('field', _$field);
  static String? _$id(PBImage v) => v.id;
  static const Field<PBImage, String> _f$id = Field('id', _$id, opt: true);
  static bool _$isDeleted(PBImage v) => v.isDeleted;
  static const Field<PBImage, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);

  @override
  final MappableFields<PBImage> fields = const {
    #field: _f$field,
    #id: _f$id,
    #isDeleted: _f$isDeleted,
  };

  static PBImage _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'PBImage', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static PBImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PBImage>(map);
  }

  static PBImage fromJson(String json) {
    return ensureInitialized().decodeJson<PBImage>(json);
  }
}

mixin PBImageMappable {
  String toJson();
  Map<String, dynamic> toMap();
  PBImageCopyWith<PBImage, PBImage, PBImage> get copyWith;
}

abstract class PBImageCopyWith<$R, $In extends PBImage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? field, String? id, bool? isDeleted});
  PBImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class PBLocalImageMapper extends SubClassMapperBase<PBLocalImage> {
  PBLocalImageMapper._();

  static PBLocalImageMapper? _instance;
  static PBLocalImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PBLocalImageMapper._());
      PBImageMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'PBLocalImage';

  static String? _$field(PBLocalImage v) => v.field;
  static const Field<PBLocalImage, String> _f$field =
      Field('field', _$field, opt: true);
  static String? _$id(PBLocalImage v) => v.id;
  static const Field<PBLocalImage, String> _f$id = Field('id', _$id, opt: true);
  static String _$name(PBLocalImage v) => v.name;
  static const Field<PBLocalImage, String> _f$name = Field('name', _$name);
  static int _$size(PBLocalImage v) => v.size;
  static const Field<PBLocalImage, int> _f$size = Field('size', _$size);
  static Uint8List _$bytes(PBLocalImage v) => v.bytes;
  static const Field<PBLocalImage, Uint8List> _f$bytes =
      Field('bytes', _$bytes);
  static String _$path(PBLocalImage v) => v.path;
  static const Field<PBLocalImage, String> _f$path = Field('path', _$path);
  static bool _$isDeleted(PBLocalImage v) => v.isDeleted;
  static const Field<PBLocalImage, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);

  @override
  final MappableFields<PBLocalImage> fields = const {
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
  late final ClassMapperBase superMapper = PBImageMapper.ensureInitialized();

  static PBLocalImage _instantiate(DecodingData data) {
    return PBLocalImage(
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

  static PBLocalImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PBLocalImage>(map);
  }

  static PBLocalImage fromJson(String json) {
    return ensureInitialized().decodeJson<PBLocalImage>(json);
  }
}

mixin PBLocalImageMappable {
  String toJson() {
    return PBLocalImageMapper.ensureInitialized()
        .encodeJson<PBLocalImage>(this as PBLocalImage);
  }

  Map<String, dynamic> toMap() {
    return PBLocalImageMapper.ensureInitialized()
        .encodeMap<PBLocalImage>(this as PBLocalImage);
  }

  PBLocalImageCopyWith<PBLocalImage, PBLocalImage, PBLocalImage> get copyWith =>
      _PBLocalImageCopyWithImpl<PBLocalImage, PBLocalImage>(
          this as PBLocalImage, $identity, $identity);
  @override
  String toString() {
    return PBLocalImageMapper.ensureInitialized()
        .stringifyValue(this as PBLocalImage);
  }

  @override
  bool operator ==(Object other) {
    return PBLocalImageMapper.ensureInitialized()
        .equalsValue(this as PBLocalImage, other);
  }

  @override
  int get hashCode {
    return PBLocalImageMapper.ensureInitialized()
        .hashValue(this as PBLocalImage);
  }
}

extension PBLocalImageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PBLocalImage, $Out> {
  PBLocalImageCopyWith<$R, PBLocalImage, $Out> get $asPBLocalImage =>
      $base.as((v, t, t2) => _PBLocalImageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PBLocalImageCopyWith<$R, $In extends PBLocalImage, $Out>
    implements PBImageCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? field,
      String? id,
      String? name,
      int? size,
      Uint8List? bytes,
      String? path,
      bool? isDeleted});
  PBLocalImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PBLocalImageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PBLocalImage, $Out>
    implements PBLocalImageCopyWith<$R, PBLocalImage, $Out> {
  _PBLocalImageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PBLocalImage> $mapper =
      PBLocalImageMapper.ensureInitialized();
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
  PBLocalImage $make(CopyWithData data) => PBLocalImage(
      field: data.get(#field, or: $value.field),
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      size: data.get(#size, or: $value.size),
      bytes: data.get(#bytes, or: $value.bytes),
      path: data.get(#path, or: $value.path),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted));

  @override
  PBLocalImageCopyWith<$R2, PBLocalImage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PBLocalImageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PBNetworkImageMapper extends SubClassMapperBase<PBNetworkImage> {
  PBNetworkImageMapper._();

  static PBNetworkImageMapper? _instance;
  static PBNetworkImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PBNetworkImageMapper._());
      PBImageMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'PBNetworkImage';

  static String? _$field(PBNetworkImage v) => v.field;
  static const Field<PBNetworkImage, String> _f$field =
      Field('field', _$field, opt: true);
  static String? _$id(PBNetworkImage v) => v.id;
  static const Field<PBNetworkImage, String> _f$id =
      Field('id', _$id, opt: true);
  static Uri _$uri(PBNetworkImage v) => v.uri;
  static const Field<PBNetworkImage, Uri> _f$uri = Field('uri', _$uri);
  static bool _$isDeleted(PBNetworkImage v) => v.isDeleted;
  static const Field<PBNetworkImage, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);

  @override
  final MappableFields<PBNetworkImage> fields = const {
    #field: _f$field,
    #id: _f$id,
    #uri: _f$uri,
    #isDeleted: _f$isDeleted,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'network';
  @override
  late final ClassMapperBase superMapper = PBImageMapper.ensureInitialized();

  static PBNetworkImage _instantiate(DecodingData data) {
    return PBNetworkImage(
        field: data.dec(_f$field),
        id: data.dec(_f$id),
        uri: data.dec(_f$uri),
        isDeleted: data.dec(_f$isDeleted));
  }

  @override
  final Function instantiate = _instantiate;

  static PBNetworkImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PBNetworkImage>(map);
  }

  static PBNetworkImage fromJson(String json) {
    return ensureInitialized().decodeJson<PBNetworkImage>(json);
  }
}

mixin PBNetworkImageMappable {
  String toJson() {
    return PBNetworkImageMapper.ensureInitialized()
        .encodeJson<PBNetworkImage>(this as PBNetworkImage);
  }

  Map<String, dynamic> toMap() {
    return PBNetworkImageMapper.ensureInitialized()
        .encodeMap<PBNetworkImage>(this as PBNetworkImage);
  }

  PBNetworkImageCopyWith<PBNetworkImage, PBNetworkImage, PBNetworkImage>
      get copyWith =>
          _PBNetworkImageCopyWithImpl<PBNetworkImage, PBNetworkImage>(
              this as PBNetworkImage, $identity, $identity);
  @override
  String toString() {
    return PBNetworkImageMapper.ensureInitialized()
        .stringifyValue(this as PBNetworkImage);
  }

  @override
  bool operator ==(Object other) {
    return PBNetworkImageMapper.ensureInitialized()
        .equalsValue(this as PBNetworkImage, other);
  }

  @override
  int get hashCode {
    return PBNetworkImageMapper.ensureInitialized()
        .hashValue(this as PBNetworkImage);
  }
}

extension PBNetworkImageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PBNetworkImage, $Out> {
  PBNetworkImageCopyWith<$R, PBNetworkImage, $Out> get $asPBNetworkImage =>
      $base.as((v, t, t2) => _PBNetworkImageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PBNetworkImageCopyWith<$R, $In extends PBNetworkImage, $Out>
    implements PBImageCopyWith<$R, $In, $Out> {
  @override
  $R call({String? field, String? id, Uri? uri, bool? isDeleted});
  PBNetworkImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PBNetworkImageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PBNetworkImage, $Out>
    implements PBNetworkImageCopyWith<$R, PBNetworkImage, $Out> {
  _PBNetworkImageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PBNetworkImage> $mapper =
      PBNetworkImageMapper.ensureInitialized();
  @override
  $R call(
          {Object? field = $none,
          Object? id = $none,
          Uri? uri,
          bool? isDeleted}) =>
      $apply(FieldCopyWithData({
        if (field != $none) #field: field,
        if (id != $none) #id: id,
        if (uri != null) #uri: uri,
        if (isDeleted != null) #isDeleted: isDeleted
      }));
  @override
  PBNetworkImage $make(CopyWithData data) => PBNetworkImage(
      field: data.get(#field, or: $value.field),
      id: data.get(#id, or: $value.id),
      uri: data.get(#uri, or: $value.uri),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted));

  @override
  PBNetworkImageCopyWith<$R2, PBNetworkImage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PBNetworkImageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PBMemoryImageMapper extends SubClassMapperBase<PBMemoryImage> {
  PBMemoryImageMapper._();

  static PBMemoryImageMapper? _instance;
  static PBMemoryImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PBMemoryImageMapper._());
      PBImageMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'PBMemoryImage';

  static String? _$field(PBMemoryImage v) => v.field;
  static const Field<PBMemoryImage, String> _f$field =
      Field('field', _$field, opt: true);
  static String? _$id(PBMemoryImage v) => v.id;
  static const Field<PBMemoryImage, String> _f$id =
      Field('id', _$id, opt: true);
  static Uint8List _$bytes(PBMemoryImage v) => v.bytes;
  static const Field<PBMemoryImage, Uint8List> _f$bytes =
      Field('bytes', _$bytes);
  static String _$fullFilename(PBMemoryImage v) => v.fullFilename;
  static const Field<PBMemoryImage, String> _f$fullFilename =
      Field('fullFilename', _$fullFilename);
  static bool _$isDeleted(PBMemoryImage v) => v.isDeleted;
  static const Field<PBMemoryImage, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);

  @override
  final MappableFields<PBMemoryImage> fields = const {
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
  late final ClassMapperBase superMapper = PBImageMapper.ensureInitialized();

  static PBMemoryImage _instantiate(DecodingData data) {
    return PBMemoryImage(
        field: data.dec(_f$field),
        id: data.dec(_f$id),
        bytes: data.dec(_f$bytes),
        fullFilename: data.dec(_f$fullFilename),
        isDeleted: data.dec(_f$isDeleted));
  }

  @override
  final Function instantiate = _instantiate;

  static PBMemoryImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PBMemoryImage>(map);
  }

  static PBMemoryImage fromJson(String json) {
    return ensureInitialized().decodeJson<PBMemoryImage>(json);
  }
}

mixin PBMemoryImageMappable {
  String toJson() {
    return PBMemoryImageMapper.ensureInitialized()
        .encodeJson<PBMemoryImage>(this as PBMemoryImage);
  }

  Map<String, dynamic> toMap() {
    return PBMemoryImageMapper.ensureInitialized()
        .encodeMap<PBMemoryImage>(this as PBMemoryImage);
  }

  PBMemoryImageCopyWith<PBMemoryImage, PBMemoryImage, PBMemoryImage>
      get copyWith => _PBMemoryImageCopyWithImpl<PBMemoryImage, PBMemoryImage>(
          this as PBMemoryImage, $identity, $identity);
  @override
  String toString() {
    return PBMemoryImageMapper.ensureInitialized()
        .stringifyValue(this as PBMemoryImage);
  }

  @override
  bool operator ==(Object other) {
    return PBMemoryImageMapper.ensureInitialized()
        .equalsValue(this as PBMemoryImage, other);
  }

  @override
  int get hashCode {
    return PBMemoryImageMapper.ensureInitialized()
        .hashValue(this as PBMemoryImage);
  }
}

extension PBMemoryImageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PBMemoryImage, $Out> {
  PBMemoryImageCopyWith<$R, PBMemoryImage, $Out> get $asPBMemoryImage =>
      $base.as((v, t, t2) => _PBMemoryImageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PBMemoryImageCopyWith<$R, $In extends PBMemoryImage, $Out>
    implements PBImageCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? field,
      String? id,
      Uint8List? bytes,
      String? fullFilename,
      bool? isDeleted});
  PBMemoryImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PBMemoryImageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PBMemoryImage, $Out>
    implements PBMemoryImageCopyWith<$R, PBMemoryImage, $Out> {
  _PBMemoryImageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PBMemoryImage> $mapper =
      PBMemoryImageMapper.ensureInitialized();
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
  PBMemoryImage $make(CopyWithData data) => PBMemoryImage(
      field: data.get(#field, or: $value.field),
      id: data.get(#id, or: $value.id),
      bytes: data.get(#bytes, or: $value.bytes),
      fullFilename: data.get(#fullFilename, or: $value.fullFilename),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted));

  @override
  PBMemoryImageCopyWith<$R2, PBMemoryImage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PBMemoryImageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PBPlaceholderImageMapper extends SubClassMapperBase<PBPlaceholderImage> {
  PBPlaceholderImageMapper._();

  static PBPlaceholderImageMapper? _instance;
  static PBPlaceholderImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PBPlaceholderImageMapper._());
      PBImageMapper.ensureInitialized().addSubMapper(_instance!);
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
  late final ClassMapperBase superMapper = PBImageMapper.ensureInitialized();

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
    $Out> implements PBImageCopyWith<$R, $In, $Out> {
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
