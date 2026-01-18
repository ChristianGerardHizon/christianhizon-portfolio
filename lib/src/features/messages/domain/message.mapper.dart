// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'message.dart';

class MessageStatusMapper extends EnumMapper<MessageStatus> {
  MessageStatusMapper._();

  static MessageStatusMapper? _instance;
  static MessageStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MessageStatusMapper._());
    }
    return _instance!;
  }

  static MessageStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  MessageStatus decode(dynamic value) {
    switch (value) {
      case r'pending':
        return MessageStatus.pending;
      case r'sent':
        return MessageStatus.sent;
      case r'failed':
        return MessageStatus.failed;
      case r'cancelled':
        return MessageStatus.cancelled;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(MessageStatus self) {
    switch (self) {
      case MessageStatus.pending:
        return r'pending';
      case MessageStatus.sent:
        return r'sent';
      case MessageStatus.failed:
        return r'failed';
      case MessageStatus.cancelled:
        return r'cancelled';
    }
  }
}

extension MessageStatusMapperExtension on MessageStatus {
  String toValue() {
    MessageStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<MessageStatus>(this) as String;
  }
}

class MessageMapper extends ClassMapperBase<Message> {
  MessageMapper._();

  static MessageMapper? _instance;
  static MessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MessageMapper._());
      MessageStatusMapper.ensureInitialized();
      PatientMapper.ensureInitialized();
      AppointmentScheduleMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Message';

  static String _$id(Message v) => v.id;
  static const Field<Message, String> _f$id = Field('id', _$id);
  static String _$phone(Message v) => v.phone;
  static const Field<Message, String> _f$phone = Field('phone', _$phone);
  static String _$content(Message v) => v.content;
  static const Field<Message, String> _f$content = Field('content', _$content);
  static DateTime _$sendDateTime(Message v) => v.sendDateTime;
  static const Field<Message, DateTime> _f$sendDateTime = Field(
    'sendDateTime',
    _$sendDateTime,
  );
  static MessageStatus _$status(Message v) => v.status;
  static const Field<Message, MessageStatus> _f$status = Field(
    'status',
    _$status,
    opt: true,
    def: MessageStatus.pending,
  );
  static String? _$patient(Message v) => v.patient;
  static const Field<Message, String> _f$patient = Field(
    'patient',
    _$patient,
    opt: true,
  );
  static String? _$appointment(Message v) => v.appointment;
  static const Field<Message, String> _f$appointment = Field(
    'appointment',
    _$appointment,
    opt: true,
  );
  static String? _$notes(Message v) => v.notes;
  static const Field<Message, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );
  static DateTime? _$sentAt(Message v) => v.sentAt;
  static const Field<Message, DateTime> _f$sentAt = Field(
    'sentAt',
    _$sentAt,
    opt: true,
  );
  static String? _$errorMessage(Message v) => v.errorMessage;
  static const Field<Message, String> _f$errorMessage = Field(
    'errorMessage',
    _$errorMessage,
    opt: true,
  );
  static String? _$branch(Message v) => v.branch;
  static const Field<Message, String> _f$branch = Field(
    'branch',
    _$branch,
    opt: true,
  );
  static bool _$isDeleted(Message v) => v.isDeleted;
  static const Field<Message, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static DateTime? _$created(Message v) => v.created;
  static const Field<Message, DateTime> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static DateTime? _$updated(Message v) => v.updated;
  static const Field<Message, DateTime> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );
  static Patient? _$patientExpanded(Message v) => v.patientExpanded;
  static const Field<Message, Patient> _f$patientExpanded = Field(
    'patientExpanded',
    _$patientExpanded,
    opt: true,
  );
  static AppointmentSchedule? _$appointmentExpanded(Message v) =>
      v.appointmentExpanded;
  static const Field<Message, AppointmentSchedule> _f$appointmentExpanded =
      Field('appointmentExpanded', _$appointmentExpanded, opt: true);

  @override
  final MappableFields<Message> fields = const {
    #id: _f$id,
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

  static Message _instantiate(DecodingData data) {
    return Message(
      id: data.dec(_f$id),
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

  static Message fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Message>(map);
  }

  static Message fromJson(String json) {
    return ensureInitialized().decodeJson<Message>(json);
  }
}

mixin MessageMappable {
  String toJson() {
    return MessageMapper.ensureInitialized().encodeJson<Message>(
      this as Message,
    );
  }

  Map<String, dynamic> toMap() {
    return MessageMapper.ensureInitialized().encodeMap<Message>(
      this as Message,
    );
  }

  MessageCopyWith<Message, Message, Message> get copyWith =>
      _MessageCopyWithImpl<Message, Message>(
        this as Message,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MessageMapper.ensureInitialized().stringifyValue(this as Message);
  }

  @override
  bool operator ==(Object other) {
    return MessageMapper.ensureInitialized().equalsValue(
      this as Message,
      other,
    );
  }

  @override
  int get hashCode {
    return MessageMapper.ensureInitialized().hashValue(this as Message);
  }
}

extension MessageValueCopy<$R, $Out> on ObjectCopyWith<$R, Message, $Out> {
  MessageCopyWith<$R, Message, $Out> get $asMessage =>
      $base.as((v, t, t2) => _MessageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MessageCopyWith<$R, $In extends Message, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PatientCopyWith<$R, Patient, Patient>? get patientExpanded;
  AppointmentScheduleCopyWith<$R, AppointmentSchedule, AppointmentSchedule>?
  get appointmentExpanded;
  $R call({
    String? id,
    String? phone,
    String? content,
    DateTime? sendDateTime,
    MessageStatus? status,
    String? patient,
    String? appointment,
    String? notes,
    DateTime? sentAt,
    String? errorMessage,
    String? branch,
    bool? isDeleted,
    DateTime? created,
    DateTime? updated,
    Patient? patientExpanded,
    AppointmentSchedule? appointmentExpanded,
  });
  MessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Message, $Out>
    implements MessageCopyWith<$R, Message, $Out> {
  _MessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Message> $mapper =
      MessageMapper.ensureInitialized();
  @override
  PatientCopyWith<$R, Patient, Patient>? get patientExpanded =>
      $value.patientExpanded?.copyWith.$chain((v) => call(patientExpanded: v));
  @override
  AppointmentScheduleCopyWith<$R, AppointmentSchedule, AppointmentSchedule>?
  get appointmentExpanded => $value.appointmentExpanded?.copyWith.$chain(
    (v) => call(appointmentExpanded: v),
  );
  @override
  $R call({
    String? id,
    String? phone,
    String? content,
    DateTime? sendDateTime,
    MessageStatus? status,
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
      if (phone != null) #phone: phone,
      if (content != null) #content: content,
      if (sendDateTime != null) #sendDateTime: sendDateTime,
      if (status != null) #status: status,
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
  Message $make(CopyWithData data) => Message(
    id: data.get(#id, or: $value.id),
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
  MessageCopyWith<$R2, Message, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MessageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

