import 'dart:typed_data';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:http/http.dart';

part 'pb_file.mapper.dart';

@MappableClass(discriminatorKey: 'type')
sealed class PBFile with PBFileMappable {
  final String? field;
  final String? id;
  final bool isDeleted;

  const PBFile({
    required this.field,
    this.id,
    this.isDeleted = false,
  });

  Future<MultipartFile> toMultipart() async {
    final value = this;
    if (value is PBLocalFile) {
      return MultipartFile.fromPath(
        value.field!,
        value.path,
        filename: value.name,
      );
    } else if (value is PBMemoryFile) {
      return MultipartFile.fromBytes(
        value.field!,
        value.bytes,
        filename: value.fullFilename,
      );
    } else if (value is PBNetworkFile) {
      return Future.error(Exception('Image is not local or network'));
    } else {
      return Future.error(Exception('Image is not local or network'));
    }
  }

  bool get isLocal => this is PBLocalFile;
  bool get isNetwork => this is PBNetworkFile;
  bool get isMemory => this is PBMemoryFile;
  bool get isPlaceholder => this is PBPlaceholderImage;

  bool get isCreate => id == null;
  bool get isUpdate => id != null && isDeleted == false;
}

@MappableClass(discriminatorValue: 'local')
class PBLocalFile extends PBFile with PBLocalFileMappable {
  final String name;
  final String path;
  final Uint8List bytes;
  final int size;

  const PBLocalFile({
    super.field,
    super.id,
    required this.name,
    required this.size,
    required this.bytes,
    required this.path,
    super.isDeleted = false,
  });
}

@MappableClass(discriminatorValue: 'network')
class PBNetworkFile extends PBFile with PBNetworkFileMappable {
  final Uri uri;
  final String fileName;

  const PBNetworkFile({
    super.field,
    super.id,
    required this.uri,
    required this.fileName,
    super.isDeleted = false,
  });
}

@MappableClass(discriminatorValue: 'memory')
class PBMemoryFile extends PBFile with PBMemoryFileMappable {
  final Uint8List bytes;
  final String fullFilename;

  const PBMemoryFile({
    super.field,
    super.id,
    required this.bytes,
    required this.fullFilename,
    super.isDeleted = false,
  });
}

@MappableClass(discriminatorValue: 'placeholder')
class PBPlaceholderImage extends PBFile with PBPlaceholderImageMappable {
  const PBPlaceholderImage({
    super.field,
    super.id = '',
    super.isDeleted = false,
  });
}

extension PBFileMaybeMapX on PBFile {
  T maybeMap<T>({
    T Function(PBLocalFile)? local,
    T Function(PBNetworkFile)? network,
    T Function(PBMemoryFile)? memory,
    T Function(PBPlaceholderImage)? placeholder,
    required T Function() orElse,
  }) {
    if (this is PBLocalFile && local != null) {
      return local(this as PBLocalFile);
    } else if (this is PBNetworkFile && network != null) {
      return network(this as PBNetworkFile);
    } else if (this is PBMemoryFile && memory != null) {
      return memory(this as PBMemoryFile);
    } else if (this is PBPlaceholderImage && placeholder != null) {
      return placeholder(this as PBPlaceholderImage);
    } else {
      return orElse();
    }
  }
}
