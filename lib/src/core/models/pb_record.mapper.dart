// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pb_record.dart';

class PbRecordMapper extends ClassMapperBase<PbRecord> {
  PbRecordMapper._();

  static PbRecordMapper? _instance;
  static PbRecordMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PbRecordMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PbRecord';

  static String _$id(PbRecord v) => v.id;
  static const Field<PbRecord, String> _f$id = Field('id', _$id);
  static bool _$isDeleted(PbRecord v) => v.isDeleted;
  static const Field<PbRecord, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted);
  static String _$collectionId(PbRecord v) => v.collectionId;
  static const Field<PbRecord, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(PbRecord v) => v.collectionName;
  static const Field<PbRecord, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static DateTime? _$created(PbRecord v) => v.created;
  static const Field<PbRecord, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(PbRecord v) => v.updated;
  static const Field<PbRecord, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);

  @override
  final MappableFields<PbRecord> fields = const {
    #id: _f$id,
    #isDeleted: _f$isDeleted,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #created: _f$created,
    #updated: _f$updated,
  };

  static PbRecord _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('PbRecord');
  }

  @override
  final Function instantiate = _instantiate;

  static PbRecord fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PbRecord>(map);
  }

  static PbRecord fromJson(String json) {
    return ensureInitialized().decodeJson<PbRecord>(json);
  }
}

mixin PbRecordMappable {
  String toJson();
  Map<String, dynamic> toMap();
  PbRecordCopyWith<PbRecord, PbRecord, PbRecord> get copyWith;
}

abstract class PbRecordCopyWith<$R, $In extends PbRecord, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      bool? isDeleted,
      String? collectionId,
      String? collectionName,
      DateTime? created,
      DateTime? updated});
  PbRecordCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}
