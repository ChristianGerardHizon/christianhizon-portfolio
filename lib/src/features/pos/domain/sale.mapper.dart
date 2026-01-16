// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'sale.dart';

class SaleMapper extends ClassMapperBase<Sale> {
  SaleMapper._();

  static SaleMapper? _instance;
  static SaleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SaleMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Sale';

  static String _$id(Sale v) => v.id;
  static const Field<Sale, String> _f$id = Field('id', _$id);
  static String _$receiptNumber(Sale v) => v.receiptNumber;
  static const Field<Sale, String> _f$receiptNumber = Field(
    'receiptNumber',
    _$receiptNumber,
  );
  static String _$branchId(Sale v) => v.branchId;
  static const Field<Sale, String> _f$branchId = Field('branchId', _$branchId);
  static String _$cashierId(Sale v) => v.cashierId;
  static const Field<Sale, String> _f$cashierId = Field(
    'cashierId',
    _$cashierId,
  );
  static num _$totalAmount(Sale v) => v.totalAmount;
  static const Field<Sale, num> _f$totalAmount = Field(
    'totalAmount',
    _$totalAmount,
  );
  static String _$paymentMethod(Sale v) => v.paymentMethod;
  static const Field<Sale, String> _f$paymentMethod = Field(
    'paymentMethod',
    _$paymentMethod,
  );
  static String _$status(Sale v) => v.status;
  static const Field<Sale, String> _f$status = Field('status', _$status);
  static String? _$customerId(Sale v) => v.customerId;
  static const Field<Sale, String> _f$customerId = Field(
    'customerId',
    _$customerId,
    opt: true,
  );
  static String? _$paymentRef(Sale v) => v.paymentRef;
  static const Field<Sale, String> _f$paymentRef = Field(
    'paymentRef',
    _$paymentRef,
    opt: true,
  );
  static String? _$notes(Sale v) => v.notes;
  static const Field<Sale, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );
  static DateTime? _$created(Sale v) => v.created;
  static const Field<Sale, DateTime> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static DateTime? _$updated(Sale v) => v.updated;
  static const Field<Sale, DateTime> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );

  @override
  final MappableFields<Sale> fields = const {
    #id: _f$id,
    #receiptNumber: _f$receiptNumber,
    #branchId: _f$branchId,
    #cashierId: _f$cashierId,
    #totalAmount: _f$totalAmount,
    #paymentMethod: _f$paymentMethod,
    #status: _f$status,
    #customerId: _f$customerId,
    #paymentRef: _f$paymentRef,
    #notes: _f$notes,
    #created: _f$created,
    #updated: _f$updated,
  };

  static Sale _instantiate(DecodingData data) {
    return Sale(
      id: data.dec(_f$id),
      receiptNumber: data.dec(_f$receiptNumber),
      branchId: data.dec(_f$branchId),
      cashierId: data.dec(_f$cashierId),
      totalAmount: data.dec(_f$totalAmount),
      paymentMethod: data.dec(_f$paymentMethod),
      status: data.dec(_f$status),
      customerId: data.dec(_f$customerId),
      paymentRef: data.dec(_f$paymentRef),
      notes: data.dec(_f$notes),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Sale fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Sale>(map);
  }

  static Sale fromJson(String json) {
    return ensureInitialized().decodeJson<Sale>(json);
  }
}

mixin SaleMappable {
  String toJson() {
    return SaleMapper.ensureInitialized().encodeJson<Sale>(this as Sale);
  }

  Map<String, dynamic> toMap() {
    return SaleMapper.ensureInitialized().encodeMap<Sale>(this as Sale);
  }

  SaleCopyWith<Sale, Sale, Sale> get copyWith =>
      _SaleCopyWithImpl<Sale, Sale>(this as Sale, $identity, $identity);
  @override
  String toString() {
    return SaleMapper.ensureInitialized().stringifyValue(this as Sale);
  }

  @override
  bool operator ==(Object other) {
    return SaleMapper.ensureInitialized().equalsValue(this as Sale, other);
  }

  @override
  int get hashCode {
    return SaleMapper.ensureInitialized().hashValue(this as Sale);
  }
}

extension SaleValueCopy<$R, $Out> on ObjectCopyWith<$R, Sale, $Out> {
  SaleCopyWith<$R, Sale, $Out> get $asSale =>
      $base.as((v, t, t2) => _SaleCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SaleCopyWith<$R, $In extends Sale, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? receiptNumber,
    String? branchId,
    String? cashierId,
    num? totalAmount,
    String? paymentMethod,
    String? status,
    String? customerId,
    String? paymentRef,
    String? notes,
    DateTime? created,
    DateTime? updated,
  });
  SaleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SaleCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Sale, $Out>
    implements SaleCopyWith<$R, Sale, $Out> {
  _SaleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Sale> $mapper = SaleMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? receiptNumber,
    String? branchId,
    String? cashierId,
    num? totalAmount,
    String? paymentMethod,
    String? status,
    Object? customerId = $none,
    Object? paymentRef = $none,
    Object? notes = $none,
    Object? created = $none,
    Object? updated = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (receiptNumber != null) #receiptNumber: receiptNumber,
      if (branchId != null) #branchId: branchId,
      if (cashierId != null) #cashierId: cashierId,
      if (totalAmount != null) #totalAmount: totalAmount,
      if (paymentMethod != null) #paymentMethod: paymentMethod,
      if (status != null) #status: status,
      if (customerId != $none) #customerId: customerId,
      if (paymentRef != $none) #paymentRef: paymentRef,
      if (notes != $none) #notes: notes,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
    }),
  );
  @override
  Sale $make(CopyWithData data) => Sale(
    id: data.get(#id, or: $value.id),
    receiptNumber: data.get(#receiptNumber, or: $value.receiptNumber),
    branchId: data.get(#branchId, or: $value.branchId),
    cashierId: data.get(#cashierId, or: $value.cashierId),
    totalAmount: data.get(#totalAmount, or: $value.totalAmount),
    paymentMethod: data.get(#paymentMethod, or: $value.paymentMethod),
    status: data.get(#status, or: $value.status),
    customerId: data.get(#customerId, or: $value.customerId),
    paymentRef: data.get(#paymentRef, or: $value.paymentRef),
    notes: data.get(#notes, or: $value.notes),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
  );

  @override
  SaleCopyWith<$R2, Sale, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SaleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

