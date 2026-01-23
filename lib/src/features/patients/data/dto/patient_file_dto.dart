import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../../core/utils/date_utils.dart';
import '../../domain/patient_file.dart';

part 'patient_file_dto.mapper.dart';

/// Data Transfer Object for PatientFile from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain PatientFile.
@MappableClass()
class PatientFileDto with PatientFileDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String patient;
  final String file;
  final String? notes;
  final bool isDeleted;
  final String? created;
  final String? updated;

  const PatientFileDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.patient,
    required this.file,
    this.notes,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory PatientFileDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    return PatientFileDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      patient: json['patient'] as String? ?? '',
      file: json['file'] as String? ?? '',
      notes: json['notes'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );
  }

  /// Converts the DTO to a domain PatientFile entity.
  PatientFile toEntity({required String baseUrl}) {
    return PatientFile(
      id: id,
      patientId: patient,
      fileName: file,
      fileUrl: _buildFileUrl(baseUrl),
      notes: notes,
      isDeleted: isDeleted,
      created: parseToLocal(created),
      updated: parseToLocal(updated),
    );
  }

  /// Builds the full URL to access the file.
  String _buildFileUrl(String baseUrl) {
    if (file.isEmpty) return '';
    return '$baseUrl/api/files/$collectionName/$id/$file';
  }
}
