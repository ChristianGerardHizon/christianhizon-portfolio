import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../domain/message_template.dart';

part 'message_template_dto.mapper.dart';

/// Data Transfer Object for MessageTemplate from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain MessageTemplate.
@MappableClass()
class MessageTemplateDto with MessageTemplateDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String name;
  final String content;
  final String? category;
  final String? branch;
  final bool isDeleted;
  final String? created;
  final String? updated;

  const MessageTemplateDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.name,
    required this.content,
    this.category,
    this.branch,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory MessageTemplateDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    return MessageTemplateDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      name: json['name'] as String? ?? '',
      content: json['content'] as String? ?? '',
      category: json['category'] as String?,
      branch: json['branch'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );
  }

  /// Converts the DTO to a domain MessageTemplate entity.
  MessageTemplate toEntity() {
    return MessageTemplate(
      id: id,
      name: name,
      content: content,
      category: category,
      branch: branch,
      isDeleted: isDeleted,
      created: created != null ? DateTime.tryParse(created!) : null,
      updated: updated != null ? DateTime.tryParse(updated!) : null,
    );
  }
}
