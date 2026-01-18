// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'message_dto.dart';

class MessageDtoMapper extends ClassMapperBase<MessageDto> {
  MessageDtoMapper._();

  static MessageDtoMapper? _instance;
  static MessageDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MessageDtoMapper._());
      PatientDtoMapper.ensureInitialized();
      AppointmentScheduleDtoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MessageDto';

  static String _$id(MessageDto v) => v.id;
  static const Field<MessageDto, String> _f$id = Field('id', _$id);
  static String _$collectionId(MessageDto v) => v.collectionId;
  static const Field<MessageDto, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(MessageDto v) => v.collectionName;
  static const Field<MessageDto, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static String _$phone(MessageDto v) => v.phone;
  static const Field<MessageDto, String> _f$phone = Field('phone', _$phone);
  static String _$content(MessageDto v) => v.content;
  static const Field<MessageDto, String> _f$content = Field(
    'content',
    _$content,
  );
  static String? _$sendDateTime(MessageDto v) => v.sendDateTime;
  static const Field<MessageDto, String> _f$sendDateTime = Field(
    'sendDateTime',
    _$sendDateTime,
    opt: true,
  );
  static String? _$status(MessageDto v) => v.status;
  static const Field<MessageDto, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );
  static String? _$patient(MessageDto v) => v.patient;
  static const Field<MessageDto, String> _f$patient = Field(
    'patient',
    _$patient,
    opt: true,
  );
  static String? _$appointment(MessageDto v) => v.appointment;
  static const Field<MessageDto, String> _f$appointment = Field(
    'appointment',
    _$appointment,
    opt: true,
  );
  static String? _$notes(MessageDto v) => v.notes;
  static const Field<MessageDto, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );
  static String? _$sentAt(MessageDto v) => v.sentAt;
  static const Field<MessageDto, String> _f$sentAt = Field(
    'sentAt',
    _$sentAt,
    opt: true,
  );
  static String? _$errorMessage(MessageDto v) => v.errorMessage;
  static const Field<MessageDto, String> _f$errorMessage = Field(
    'errorMessage',
    _$errorMessage,
    opt: true,
  );
  static String? _$branch(MessageDto v) => v.branch;
  static const Field<MessageDto, String> _f$branch = Field(
    'branch',
    _$branch,
    opt: true,
  );
  static bool _$isDeleted(MessageDto v) => v.isDeleted;
  static const Field<MessageDto, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static String? _$created(MessageDto v) => v.created;
  static const Field<MessageDto, String> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static String? _$updated(MessageDto v) => v.updated;
  static const Field<MessageDto, String> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );
  static PatientDto? _$patientExpanded(MessageDto v) => v.patientExpanded;
  static const Field<MessageDto, PatientDto> _f$patientExpanded = Field(
    'patientExpanded',
    _$patientExpanded,
    opt: true,
  );
  static AppointmentScheduleDto? _$appointmentExpanded(MessageDto v) =>
      v.appointmentExpanded;
  static const Field<MessageDto, AppointmentScheduleDto>
  _f$appointmentExpanded = Field(
    'appointmentExpanded',
    _$appointmentExpanded,
    opt: true,
  );

  @override
  final MappableFields<MessageDto> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #phone: _f$phone,
    #content: _f$content,
    #sendDateTime: _f$sendDateTime,
    #status: _f$status,
    #patient: _f$patient,
    #appointment: _f$appointment,
    #notes: _f$notes,
    #sentAt: _f$sentAt,
    #errorMessage: _f$errorMessage,
    #branch: _f$branch,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
    #patientExpanded: _f$patientExpanded,
    #appointmentExpanded: _f$appointmentExpanded,
  };

  static MessageDto _instantiate(DecodingData data) {
    return MessageDto(
      id: data.dec(_f$id),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      phone: data.dec(_f$phone),
      content: data.dec(_f$content),
      sendDateTime: data.dec(_f$sendDateTime),
      status: data.dec(_f$status),
      patient: data.dec(_f$patient),
      appointment: data.dec(_f$appointment),
      notes: data.dec(_f$notes),
      sentAt: data.dec(_f$sentAt),
      errorMessage: data.dec(_f$errorMessage),
      branch: data.dec(_f$branch),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
      patientExpanded: data.dec(_f$patientExpanded),
      appointmentExpanded: data.dec(_f$appointmentExpanded),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MessageDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MessageDto>(map);
  }

  static MessageDto fromJson(String json) {
    return ensureInitialized().decodeJson<MessageDto>(json);
  }
}

mixin MessageDtoMappable {
  String toJson() {
    return MessageDtoMapper.ensureInitialized().encodeJson<MessageDto>(
      this as MessageDto,
    );
  }

  Map<String, dynamic> toMap() {
    return MessageDtoMapper.ensureInitialized().encodeMap<MessageDto>(
      this as MessageDto,
    );
  }

  MessageDtoCopyWith<MessageDto, MessageDto, MessageDto> get copyWith =>
      _MessageDtoCopyWithImpl<MessageDto, MessageDto>(
        this as MessageDto,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MessageDtoMapper.ensureInitialized().stringifyValue(
      this as MessageDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return MessageDtoMapper.ensureInitialized().equalsValue(
      this as MessageDto,
      other,
    );
  }

  @override
  int get hashCode {
    return MessageDtoMapper.ensureInitialized().hashValue(this as MessageDto);
  }
}

extension MessageDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MessageDto, $Out> {
  MessageDtoCopyWith<$R, MessageDto, $Out> get $asMessageDto =>
      $base.as((v, t, t2) => _MessageDtoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MessageDtoCopyWith<$R, $In extends MessageDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PatientDtoCopyWith<$R, PatientDto, PatientDto>? get patientExpanded;
  AppointmentScheduleDtoCopyWith<
    $R,
    AppointmentScheduleDto,
    AppointmentScheduleDto
  >?
  get appointmentExpanded;
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? phone,
    String? content,
    String? sendDateTime,
    String? status,
    String? patient,
    String? appointment,
    String? notes,
    String? sentAt,
    String? errorMessage,
    String? branch,
    bool? isDeleted,
    String? created,
    String? updated,
    PatientDto? patientExpanded,
    AppointmentScheduleDto? appointmentExpanded,
  });
  MessageDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MessageDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MessageDto, $Out>
    implements MessageDtoCopyWith<$R, MessageDto, $Out> {
  _MessageDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MessageDto> $mapper =
      MessageDtoMapper.ensureInitialized();
  @override
  PatientDtoCopyWith<$R, PatientDto, PatientDto>? get patientExpanded =>
      $value.patientExpanded?.copyWith.$chain((v) => call(patientExpanded: v));
  @override
  AppointmentScheduleDtoCopyWith<
    $R,
    AppointmentScheduleDto,
    AppointmentScheduleDto
  >?
  get appointmentExpanded => $value.appointmentExpanded?.copyWith.$chain(
    (v) => call(appointmentExpanded: v),
  );
  @override
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? phone,
    String? content,
    Object? sendDateTime = $none,
    Object? status = $none,
    Object? patient = $none,
    Object? appointment = $none,
    Object? notes = $none,
    Object? sentAt = $none,
    Object? errorMessage = $none,
    Object? branch = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
    Object? patientExpanded = $none,
    Object? appointmentExpanded = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (phone != null) #phone: phone,
      if (content != null) #content: content,
      if (sendDateTime != $none) #sendDateTime: sendDateTime,
      if (status != $none) #status: status,
      if (patient != $none) #patient: patient,
      if (appointment != $none) #appointment: appointment,
      if (notes != $none) #notes: notes,
      if (sentAt != $none) #sentAt: sentAt,
      if (errorMessage != $none) #errorMessage: errorMessage,
      if (branch != $none) #branch: branch,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
      if (patientExpanded != $none) #patientExpanded: patientExpanded,
      if (appointmentExpanded != $none)
        #appointmentExpanded: appointmentExpanded,
    }),
  );
  @override
  MessageDto $make(CopyWithData data) => MessageDto(
    id: data.get(#id, or: $value.id),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    phone: data.get(#phone, or: $value.phone),
    content: data.get(#content, or: $value.content),
    sendDateTime: data.get(#sendDateTime, or: $value.sendDateTime),
    status: data.get(#status, or: $value.status),
    patient: data.get(#patient, or: $value.patient),
    appointment: data.get(#appointment, or: $value.appointment),
    notes: data.get(#notes, or: $value.notes),
    sentAt: data.get(#sentAt, or: $value.sentAt),
    errorMessage: data.get(#errorMessage, or: $value.errorMessage),
    branch: data.get(#branch, or: $value.branch),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
    patientExpanded: data.get(#patientExpanded, or: $value.patientExpanded),
    appointmentExpanded: data.get(
      #appointmentExpanded,
      or: $value.appointmentExpanded,
    ),
  );

  @override
  MessageDtoCopyWith<$R2, MessageDto, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MessageDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

