import 'dart:typed_data';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:http/http.dart';

part 'pb_image.mapper.dart';

@MappableClass(discriminatorKey: 'type')
sealed class PBImage with PBImageMappable {
  final String? field;
  final String? id;
  final bool isDeleted;

  const PBImage({
    required this.field,
    this.id,
    this.isDeleted = false,
  });
}

@MappableClass(discriminatorValue: 'local')
class PBLocalImage extends PBImage with PBLocalImageMappable {
  final String name;
  final String path;
  final Uint8List bytes;
  final int size;

  const PBLocalImage({
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
class PBNetworkImage extends PBImage with PBNetworkImageMappable {
  final Uri uri;

  const PBNetworkImage({
    super.field,
    super.id,
    required this.uri,
    super.isDeleted = false,
  });
}

@MappableClass(discriminatorValue: 'memory')
class PBMemoryImage extends PBImage with PBMemoryImageMappable {
  final Uint8List bytes;
  final String fullFilename;

  const PBMemoryImage({
    super.field,
    super.id,
    required this.bytes,
    required this.fullFilename,
    super.isDeleted = false,
  });
}

@MappableClass(discriminatorValue: 'placeholder')
class PBPlaceholderImage extends PBImage with PBPlaceholderImageMappable {
  const PBPlaceholderImage({
    super.field,
    super.id = '',
    super.isDeleted = false,
  });
}

extension PbImageExtension on PBImage {
  bool get isLocal => this is PBLocalImage;
  bool get isNetwork => this is PBNetworkImage;
  bool get isMemory => this is PBMemoryImage;
  bool get isPlaceholder => this is PBPlaceholderImage;

  bool get isCreate => id == null;
  bool get isUpdate => id != null && isDeleted == false;

  Future<MultipartFile> toMultipart() async {
    final value = this;
    if (value is PBLocalImage) {
      return MultipartFile.fromPath(
        value.field!,
        value.path,
        filename: value.name,
      );
    } else if (value is PBMemoryImage) {
      return MultipartFile.fromBytes(
        value.field!,
        value.bytes,
        filename: value.fullFilename,
      );
    } else if (value is PBNetworkImage) {
      return Future.error(Exception('Image is not local or network'));
    } else {
      return Future.error(Exception('Image is not local or network'));
    }
  }
}

extension PBImageMaybeMapX on PBImage {
  T maybeMap<T>({
    T Function(PBLocalImage)? local,
    T Function(PBNetworkImage)? network,
    T Function(PBMemoryImage)? memory,
    T Function(PBPlaceholderImage)? placeholder,
    required T Function() orElse,
  }) {
    if (this is PBLocalImage && local != null) {
      return local(this as PBLocalImage);
    } else if (this is PBNetworkImage && network != null) {
      return network(this as PBNetworkImage);
    } else if (this is PBMemoryImage && memory != null) {
      return memory(this as PBMemoryImage);
    } else if (this is PBPlaceholderImage && placeholder != null) {
      return placeholder(this as PBPlaceholderImage);
    } else {
      return orElse();
    }
  }
}
