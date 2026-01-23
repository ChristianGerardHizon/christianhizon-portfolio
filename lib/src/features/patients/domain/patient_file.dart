import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'patient_file.mapper.dart';

/// File type categories for patient files.
@MappableEnum()
enum PatientFileType {
  image,
  video,
  document,
  unknown;

  /// Image file extensions.
  static const _imageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp',
    'bmp',
    'heic',
  ];

  /// Video file extensions.
  static const _videoExtensions = [
    'mp4',
    'mov',
    'avi',
    'webm',
    '3gp',
  ];

  /// Document file extensions.
  static const _documentExtensions = [
    'pdf',
  ];

  /// Returns the file type based on file extension.
  static PatientFileType fromExtension(String ext) {
    final lower = ext.toLowerCase();
    if (_imageExtensions.contains(lower)) return image;
    if (_videoExtensions.contains(lower)) return video;
    if (_documentExtensions.contains(lower)) return document;
    return unknown;
  }

  /// Returns the icon for this file type.
  IconData get icon {
    switch (this) {
      case PatientFileType.image:
        return Icons.image;
      case PatientFileType.video:
        return Icons.videocam;
      case PatientFileType.document:
        return Icons.description;
      case PatientFileType.unknown:
        return Icons.insert_drive_file;
    }
  }

  /// Returns a human-readable label for this file type.
  String get label {
    switch (this) {
      case PatientFileType.image:
        return 'Image';
      case PatientFileType.video:
        return 'Video';
      case PatientFileType.document:
        return 'Document';
      case PatientFileType.unknown:
        return 'File';
    }
  }
}

/// Patient file domain model.
///
/// Represents a file attached to a patient (images, videos, documents).
@MappableClass()
class PatientFile with PatientFileMappable {
  const PatientFile({
    required this.id,
    required this.patientId,
    required this.fileName,
    required this.fileUrl,
    this.notes,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// FK to the patient this file belongs to.
  final String patientId;

  /// Original filename.
  final String fileName;

  /// Full URL to access the file.
  final String fileUrl;

  /// Optional notes or description.
  final String? notes;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;

  /// File extension in lowercase (e.g., "jpg", "mp4", "pdf").
  String get extension {
    final parts = fileName.split('.');
    return parts.length > 1 ? parts.last.toLowerCase() : '';
  }

  /// Returns the file type category.
  PatientFileType get fileType => PatientFileType.fromExtension(extension);

  /// Whether this file is an image.
  bool get isImage => fileType == PatientFileType.image;

  /// Whether this file is a video.
  bool get isVideo => fileType == PatientFileType.video;

  /// Whether this file is a document.
  bool get isDocument => fileType == PatientFileType.document;

  /// Returns true if the file has notes.
  bool get hasNotes => notes != null && notes!.isNotEmpty;

  /// Returns a display-friendly filename (truncated if too long).
  String get displayName {
    if (fileName.length <= 25) return fileName;
    final ext = extension;
    final nameWithoutExt = fileName.substring(0, fileName.length - ext.length - 1);
    if (nameWithoutExt.length <= 20) return fileName;
    return '${nameWithoutExt.substring(0, 17)}...$ext';
  }
}
