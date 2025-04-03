import 'dart:math';

import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:http/http.dart' as http show get;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/file_utils/file_utils.dart'
    show createPlatformFileFromBytes;

part 'dynamic_field_builder_controller.g.dart';

class DynamicFieldBuilderControllerState {
  final List<DynamicField> fields;
  final Map<String, dynamic> intialValues;

  DynamicFieldBuilderControllerState({
    required this.fields,
    this.intialValues = const {},
  });
}

@riverpod
class DynamicFieldBuilderController extends _$DynamicFieldBuilderController {
  @override
  FutureOr<DynamicFieldBuilderControllerState> build(
    List<DynamicField> list,
  ) async {
    final initialValues = await buildInitialValues(list);

    return DynamicFieldBuilderControllerState(
      fields: list,
      intialValues: initialValues,
    );
  }
}

Future<Map<String, dynamic>> buildInitialValues(
    List<DynamicField> fields) async {
  final Map<String, dynamic> initialValues = {};

  for (final field in fields) {
    final String name = field.name;
    final value = field.initialValue;

    if (field is DynamicImageField || field is DynamicFileField) {
      if (value is XFile) {
        initialValues[name] = await _xFileToPlatformFile(value);
      } else if (value is List) {
        final platformFiles = await Future.wait(
          value.map((item) async {
            if (item is Uri &&
                item.isAbsolute &&
                item.hasScheme &&
                (item.scheme == 'http' || item.scheme == 'https')) {
              return _urlToPlatformFile(item);
            } else if (item is XFile) {
              return _xFileToPlatformFile(item);
            } else {
              return null; // ignore unsupported items
            }
          }),
        );

        initialValues[name] = platformFiles.whereType<PlatformFile>().toList();
      }
    } else {
      initialValues[name] = value;
    }
  }

  return initialValues;
}

Future<PlatformFile> _urlToPlatformFile(Uri uri) async {
  final response = await http.get(uri);
  if (response.statusCode != 200) {
    throw Exception('Failed to load file from $uri');
  }

  final bytes = response.bodyBytes;
  final name = _safeFileNameFromUri(uri);

  return createPlatformFileFromBytes(name: name, bytes: bytes);
}

Future<PlatformFile> _xFileToPlatformFile(XFile file) async {
  final int size = await file.length();

  if (kIsWeb) {
    final bytes = await file.readAsBytes();

    return PlatformFile(
      name: file.name,
      size: size,
      bytes: bytes,
      path: null, // web has no path
    );
  } else {
    return PlatformFile(
      name: file.name,
      size: size,
      path: file.path,
      bytes: null, // skip bytes for performance
    );
  }
}

String _safeFileNameFromUri(Uri uri, {String? fallbackExtension}) {
  final lastSegment =
      uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null;

  final hasValidName = lastSegment != null && lastSegment.contains('.');
  if (hasValidName) return lastSegment;

  // Generate random fallback like file_ab12cd34.jpg
  final random = _randomHex(8);
  final ext = fallbackExtension ?? 'bin';
  return 'file_$random.$ext';
}

String _randomHex(int length) {
  final rand = Random.secure();
  const chars = 'abcdef0123456789';
  return List.generate(length, (_) => chars[rand.nextInt(chars.length)]).join();
}
