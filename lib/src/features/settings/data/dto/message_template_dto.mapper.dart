// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'message_template_dto.dart';

class MessageTemplateDtoMapper extends ClassMapperBase<MessageTemplateDto> {
  MessageTemplateDtoMapper._();

  static MessageTemplateDtoMapper? _instance;
  static MessageTemplateDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MessageTemplateDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MessageTemplateDto';

  static String _$id(MessageTemplateDto v) => v.id;
  static const Field<MessageTemplateDto, String> _f$id = Field('id', _$id);
  static String _$collectionId(MessageTemplateDto v) => v.collectionId;
  static const Field<MessageTemplateDto, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(MessageTemplateDto v) => v.collectionName;
  static const Field<MessageTemplateDto, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static String _$name(MessageTemplateDto v) => v.name;
  static const Field<MessageTemplateDto, String> _f$name = Field(
    'name',
    _$name,
  );
  static String _$content(MessageTemplateDto v) => v.content;
  static const Field<MessageTemplateDto, String> _f$content = Field(
    'content',
    _$content,
  );
  static String? _$category(MessageTemplateDto v) => v.category;
  static const Field<MessageTemplateDto, String> _f$category = Field(
    'category',
    _$category,
    opt: true,
  );
  static String? _$branch(MessageTemplateDto v) => v.branch;
  static const Field<MessageTemplateDto, String> _f$branch = Field(
    'branch',
    _$branch,
    opt: true,
  );
  static bool _$isDeleted(MessageTemplateDto v) => v.isDeleted;
  static const Field<MessageTemplateDto, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static String? _$created(MessageTemplateDto v) => v.created;
  static const Field<MessageTemplateDto, String> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static String? _$updated(MessageTemplateDto v) => v.updated;
  static const Field<MessageTemplateDto, String> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );

  @override
  final MappableFields<MessageTemplateDto> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #name: _f$name,
    #content: _f$content,
    #category: _f$category,
    #branch: _f$branch,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static MessageTemplateDto _instantiate(DecodingData data) {
    return MessageTemplateDto(
      id: data.dec(_f$id),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      name: data.dec(_f$name),
      content: data.dec(_f$content),
      category: data.dec(_f$category),
      branch: data.dec(_f$branch),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MessageTemplateDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MessageTemplateDto>(map);
  }

  static MessageTemplateDto fromJson(String json) {
    return ensureInitialized().decodeJson<MessageTemplateDto>(json);
  }
}

mixin MessageTemplateDtoMappable {
  String toJson() {
    return MessageTemplateDtoMapper.ensureInitialized()
        .encodeJson<MessageTemplateDto>(this as MessageTemplateDto);
  }

  Map<String, dynamic> toMap() {
    return MessageTemplateDtoMapper.ensureInitialized()
        .encodeMap<MessageTemplateDto>(this as MessageTemplateDto);
  }

  MessageTemplateDtoCopyWith<
    MessageTemplateDto,
    MessageTemplateDto,
    MessageTemplateDto
  >
  get copyWith =>
      _MessageTemplateDtoCopyWithImpl<MessageTemplateDto, MessageTemplateDto>(
        this as MessageTemplateDto,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MessageTemplateDtoMapper.ensureInitialized().stringifyValue(
      this as MessageTemplateDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return MessageTemplateDtoMapper.ensureInitialized().equalsValue(
      this as MessageTemplateDto,
      other,
    );
  }

  @override
  int get hashCode {
    return MessageTemplateDtoMapper.ensureInitialized().hashValue(
      this as MessageTemplateDto,
    );
  }
}

extension MessageTemplateDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MessageTemplateDto, $Out> {
  MessageTemplateDtoCopyWith<$R, MessageTemplateDto, $Out>
  get $asMessageTemplateDto => $base.as(
    (v, t, t2) => _MessageTemplateDtoCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class MessageTemplateDtoCopyWith<
  $R,
  $In extends MessageTemplateDto,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? name,
    String? content,
    String? category,
    String? branch,
    bool? isDeleted,
    String? created,
    String? updated,
  });
  MessageTemplateDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MessageTemplateDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MessageTemplateDto, $Out>
    implements MessageTemplateDtoCopyWith<$R, MessageTemplateDto, $Out> {
  _MessageTemplateDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MessageTemplateDto> $mapper =
      MessageTemplateDtoMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? name,
    String? content,
    Object? category = $none,
    Object? branch = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (name != null) #name: name,
      if (content != null) #content: content,
      if (category != $none) #category: category,
      if (branch != $none) #branch: branch,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
    }),
  );
  @override
  MessageTemplateDto $make(CopyWithData data) => MessageTemplateDto(
    id: data.get(#id, or: $value.id),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    name: data.get(#name, or: $value.name),
    content: data.get(#content, or: $value.content),
    category: data.get(#category, or: $value.category),
    branch: data.get(#branch, or: $value.branch),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
  );

  @override
  MessageTemplateDtoCopyWith<$R2, MessageTemplateDto, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MessageTemplateDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

