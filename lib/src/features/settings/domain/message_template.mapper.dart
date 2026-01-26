// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'message_template.dart';

class MessageTemplateMapper extends ClassMapperBase<MessageTemplate> {
  MessageTemplateMapper._();

  static MessageTemplateMapper? _instance;
  static MessageTemplateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MessageTemplateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MessageTemplate';

  static String _$id(MessageTemplate v) => v.id;
  static const Field<MessageTemplate, String> _f$id = Field('id', _$id);
  static String _$name(MessageTemplate v) => v.name;
  static const Field<MessageTemplate, String> _f$name = Field('name', _$name);
  static String _$content(MessageTemplate v) => v.content;
  static const Field<MessageTemplate, String> _f$content = Field(
    'content',
    _$content,
  );
  static String? _$category(MessageTemplate v) => v.category;
  static const Field<MessageTemplate, String> _f$category = Field(
    'category',
    _$category,
    opt: true,
  );
  static String? _$branch(MessageTemplate v) => v.branch;
  static const Field<MessageTemplate, String> _f$branch = Field(
    'branch',
    _$branch,
    opt: true,
  );
  static bool _$isDefault(MessageTemplate v) => v.isDefault;
  static const Field<MessageTemplate, bool> _f$isDefault = Field(
    'isDefault',
    _$isDefault,
    opt: true,
    def: false,
  );
  static bool _$isDeleted(MessageTemplate v) => v.isDeleted;
  static const Field<MessageTemplate, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static DateTime? _$created(MessageTemplate v) => v.created;
  static const Field<MessageTemplate, DateTime> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static DateTime? _$updated(MessageTemplate v) => v.updated;
  static const Field<MessageTemplate, DateTime> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );

  @override
  final MappableFields<MessageTemplate> fields = const {
    #id: _f$id,
    #name: _f$name,
    #content: _f$content,
    #category: _f$category,
    #branch: _f$branch,
    #isDefault: _f$isDefault,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static MessageTemplate _instantiate(DecodingData data) {
    return MessageTemplate(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      content: data.dec(_f$content),
      category: data.dec(_f$category),
      branch: data.dec(_f$branch),
      isDefault: data.dec(_f$isDefault),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MessageTemplate fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MessageTemplate>(map);
  }

  static MessageTemplate fromJson(String json) {
    return ensureInitialized().decodeJson<MessageTemplate>(json);
  }
}

mixin MessageTemplateMappable {
  String toJson() {
    return MessageTemplateMapper.ensureInitialized()
        .encodeJson<MessageTemplate>(this as MessageTemplate);
  }

  Map<String, dynamic> toMap() {
    return MessageTemplateMapper.ensureInitialized().encodeMap<MessageTemplate>(
      this as MessageTemplate,
    );
  }

  MessageTemplateCopyWith<MessageTemplate, MessageTemplate, MessageTemplate>
  get copyWith =>
      _MessageTemplateCopyWithImpl<MessageTemplate, MessageTemplate>(
        this as MessageTemplate,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MessageTemplateMapper.ensureInitialized().stringifyValue(
      this as MessageTemplate,
    );
  }

  @override
  bool operator ==(Object other) {
    return MessageTemplateMapper.ensureInitialized().equalsValue(
      this as MessageTemplate,
      other,
    );
  }

  @override
  int get hashCode {
    return MessageTemplateMapper.ensureInitialized().hashValue(
      this as MessageTemplate,
    );
  }
}

extension MessageTemplateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MessageTemplate, $Out> {
  MessageTemplateCopyWith<$R, MessageTemplate, $Out> get $asMessageTemplate =>
      $base.as((v, t, t2) => _MessageTemplateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MessageTemplateCopyWith<$R, $In extends MessageTemplate, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? name,
    String? content,
    String? category,
    String? branch,
    bool? isDefault,
    bool? isDeleted,
    DateTime? created,
    DateTime? updated,
  });
  MessageTemplateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MessageTemplateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MessageTemplate, $Out>
    implements MessageTemplateCopyWith<$R, MessageTemplate, $Out> {
  _MessageTemplateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MessageTemplate> $mapper =
      MessageTemplateMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? name,
    String? content,
    Object? category = $none,
    Object? branch = $none,
    bool? isDefault,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (content != null) #content: content,
      if (category != $none) #category: category,
      if (branch != $none) #branch: branch,
      if (isDefault != null) #isDefault: isDefault,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
    }),
  );
  @override
  MessageTemplate $make(CopyWithData data) => MessageTemplate(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    content: data.get(#content, or: $value.content),
    category: data.get(#category, or: $value.category),
    branch: data.get(#branch, or: $value.branch),
    isDefault: data.get(#isDefault, or: $value.isDefault),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
  );

  @override
  MessageTemplateCopyWith<$R2, MessageTemplate, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MessageTemplateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

