import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/models/pb_record.dart';

part 'patient_file.mapper.dart';

@MappableClass()
class PatientFile extends PbRecord with PatientFileMappable {
  final String patient;
  final String file;
  final String? notes;

  PatientFile({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    super.isDeleted = false,
    super.created,
    super.updated,
    required this.patient,
    required this.file,
    this.notes,
  });

  bool get isImage =>
      file.endsWith('.png') ||
      file.endsWith('.jpg') ||
      file.endsWith('.jpeg') ||
      file.endsWith('.gif') ||
      file.endsWith('.webp') ||
      file.endsWith('.bmp') ||
      file.endsWith('.ico') ||
      file.endsWith('.tiff') ||
      file.endsWith('.avif') ||
      file.endsWith('.svg');

  static fromMap(Map<String, dynamic> raw) {
    return PatientFileMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = PatientFileMapper.fromJson;
}
