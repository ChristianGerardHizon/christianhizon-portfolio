// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'tech_stack_item.dart';

class TechStackItemMapper extends ClassMapperBase<TechStackItem> {
  TechStackItemMapper._();

  static TechStackItemMapper? _instance;
  static TechStackItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TechStackItemMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TechStackItem';

  static String _$id(TechStackItem v) => v.id;
  static const Field<TechStackItem, String> _f$id = Field('id', _$id);
  static String _$name(TechStackItem v) => v.name;
  static const Field<TechStackItem, String> _f$name = Field('name', _$name);
  static String _$category(TechStackItem v) => v.category;
  static const Field<TechStackItem, String> _f$category = Field(
    'category',
    _$category,
    opt: true,
    def: '',
  );
  static String _$description(TechStackItem v) => v.description;
  static const Field<TechStackItem, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static String _$iconName(TechStackItem v) => v.iconName;
  static const Field<TechStackItem, String> _f$iconName = Field(
    'iconName',
    _$iconName,
    opt: true,
    def: '',
  );
  static int _$proficiencyLevel(TechStackItem v) => v.proficiencyLevel;
  static const Field<TechStackItem, int> _f$proficiencyLevel = Field(
    'proficiencyLevel',
    _$proficiencyLevel,
    opt: true,
    def: 0,
  );
  static int _$yearsOfExperience(TechStackItem v) => v.yearsOfExperience;
  static const Field<TechStackItem, int> _f$yearsOfExperience = Field(
    'yearsOfExperience',
    _$yearsOfExperience,
    opt: true,
    def: 0,
  );
  static String _$url(TechStackItem v) => v.url;
  static const Field<TechStackItem, String> _f$url = Field(
    'url',
    _$url,
    opt: true,
    def: '',
  );
  static int _$sortOrder(TechStackItem v) => v.sortOrder;
  static const Field<TechStackItem, int> _f$sortOrder = Field(
    'sortOrder',
    _$sortOrder,
    opt: true,
    def: 0,
  );
  static String _$collectionId(TechStackItem v) => v.collectionId;
  static const Field<TechStackItem, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<TechStackItem> fields = const {
    #id: _f$id,
    #name: _f$name,
    #category: _f$category,
    #description: _f$description,
    #iconName: _f$iconName,
    #proficiencyLevel: _f$proficiencyLevel,
    #yearsOfExperience: _f$yearsOfExperience,
    #url: _f$url,
    #sortOrder: _f$sortOrder,
    #collectionId: _f$collectionId,
  };

  static TechStackItem _instantiate(DecodingData data) {
    return TechStackItem(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      category: data.dec(_f$category),
      description: data.dec(_f$description),
      iconName: data.dec(_f$iconName),
      proficiencyLevel: data.dec(_f$proficiencyLevel),
      yearsOfExperience: data.dec(_f$yearsOfExperience),
      url: data.dec(_f$url),
      sortOrder: data.dec(_f$sortOrder),
      collectionId: data.dec(_f$collectionId),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TechStackItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TechStackItem>(map);
  }

  static TechStackItem fromJson(String json) {
    return ensureInitialized().decodeJson<TechStackItem>(json);
  }
}

mixin TechStackItemMappable {
  String toJson() {
    return TechStackItemMapper.ensureInitialized().encodeJson<TechStackItem>(
      this as TechStackItem,
    );
  }

  Map<String, dynamic> toMap() {
    return TechStackItemMapper.ensureInitialized().encodeMap<TechStackItem>(
      this as TechStackItem,
    );
  }

  TechStackItemCopyWith<TechStackItem, TechStackItem, TechStackItem>
  get copyWith => _TechStackItemCopyWithImpl<TechStackItem, TechStackItem>(
    this as TechStackItem,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return TechStackItemMapper.ensureInitialized().stringifyValue(
      this as TechStackItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return TechStackItemMapper.ensureInitialized().equalsValue(
      this as TechStackItem,
      other,
    );
  }

  @override
  int get hashCode {
    return TechStackItemMapper.ensureInitialized().hashValue(
      this as TechStackItem,
    );
  }
}

extension TechStackItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TechStackItem, $Out> {
  TechStackItemCopyWith<$R, TechStackItem, $Out> get $asTechStackItem =>
      $base.as((v, t, t2) => _TechStackItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TechStackItemCopyWith<$R, $In extends TechStackItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? name,
    String? category,
    String? description,
    String? iconName,
    int? proficiencyLevel,
    int? yearsOfExperience,
    String? url,
    int? sortOrder,
    String? collectionId,
  });
  TechStackItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TechStackItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TechStackItem, $Out>
    implements TechStackItemCopyWith<$R, TechStackItem, $Out> {
  _TechStackItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TechStackItem> $mapper =
      TechStackItemMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? name,
    String? category,
    String? description,
    String? iconName,
    int? proficiencyLevel,
    int? yearsOfExperience,
    String? url,
    int? sortOrder,
    String? collectionId,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (category != null) #category: category,
      if (description != null) #description: description,
      if (iconName != null) #iconName: iconName,
      if (proficiencyLevel != null) #proficiencyLevel: proficiencyLevel,
      if (yearsOfExperience != null) #yearsOfExperience: yearsOfExperience,
      if (url != null) #url: url,
      if (sortOrder != null) #sortOrder: sortOrder,
      if (collectionId != null) #collectionId: collectionId,
    }),
  );
  @override
  TechStackItem $make(CopyWithData data) => TechStackItem(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    category: data.get(#category, or: $value.category),
    description: data.get(#description, or: $value.description),
    iconName: data.get(#iconName, or: $value.iconName),
    proficiencyLevel: data.get(#proficiencyLevel, or: $value.proficiencyLevel),
    yearsOfExperience: data.get(
      #yearsOfExperience,
      or: $value.yearsOfExperience,
    ),
    url: data.get(#url, or: $value.url),
    sortOrder: data.get(#sortOrder, or: $value.sortOrder),
    collectionId: data.get(#collectionId, or: $value.collectionId),
  );

  @override
  TechStackItemCopyWith<$R2, TechStackItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TechStackItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

