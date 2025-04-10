// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pb_object.dart';

class PbObjectMapper extends ClassMapperBase<PbObject> {
  PbObjectMapper._();

  static PbObjectMapper? _instance;
  static PbObjectMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PbObjectMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PbObject';

  static String _$id(PbObject v) => v.id;
  static const Field<PbObject, String> _f$id = Field('id', _$id);
  static bool _$isDeleted(PbObject v) => v.isDeleted;
  static const Field<PbObject, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted);
  static String _$collectionId(PbObject v) => v.collectionId;
  static const Field<PbObject, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(PbObject v) => v.collectionName;
  static const Field<PbObject, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static DateTime? _$created(PbObject v) => v.created;
  static const Field<PbObject, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(PbObject v) => v.updated;
  static const Field<PbObject, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);

  @override
  final MappableFields<PbObject> fields = const {
    #id: _f$id,
    #isDeleted: _f$isDeleted,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #created: _f$created,
    #updated: _f$updated,
  };

  static PbObject _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('PbObject');
  }

  @override
  final Function instantiate = _instantiate;

  static PbObject fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PbObject>(map);
  }

  static PbObject fromJson(String json) {
    return ensureInitialized().decodeJson<PbObject>(json);
  }
}

mixin PbObjectMappable {
  String toJson();
  Map<String, dynamic> toMap();
  PbObjectCopyWith<PbObject, PbObject, PbObject> get copyWith;
}

abstract class PbObjectCopyWith<$R, $In extends PbObject, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      bool? isDeleted,
      String? collectionId,
      String? collectionName,
      DateTime? created,
      DateTime? updated});
  PbObjectCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}
