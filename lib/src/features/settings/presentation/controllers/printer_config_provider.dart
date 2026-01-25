import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/printer_config_repository.dart';
import '../../domain/printer_config.dart';

part 'printer_config_provider.g.dart';

/// Provider to fetch a single printer config by ID.
@riverpod
Future<PrinterConfig?> printerConfig(Ref ref, String id) async {
  if (id.isEmpty) return null;

  final repository = ref.watch(printerConfigRepositoryProvider);
  final result = await repository.fetchOne(id);

  return result.fold(
    (failure) => null,
    (config) => config,
  );
}

/// Provider to fetch the default printer configuration.
@riverpod
Future<PrinterConfig?> defaultPrinter(Ref ref) async {
  final repository = ref.watch(printerConfigRepositoryProvider);
  final result = await repository.fetchDefault();

  return result.fold(
    (failure) => null,
    (config) => config,
  );
}
