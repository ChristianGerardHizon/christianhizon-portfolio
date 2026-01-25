import 'package:dart_mappable/dart_mappable.dart';

import 'printer_connection_type.dart';
import 'printer_paper_width.dart';

part 'printer_config.mapper.dart';

/// Printer configuration domain model.
///
/// Represents a configured thermal printer for receipt printing.
@MappableClass()
class PrinterConfig with PrinterConfigMappable {
  const PrinterConfig({
    required this.id,
    required this.name,
    required this.connectionType,
    this.address,
    this.port = 9100,
    this.paperWidth = PrinterPaperWidth.mm80,
    this.isDefault = false,
    this.isEnabled = true,
    this.branchId,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// Printer name (user-friendly identifier).
  final String name;

  /// Connection type (Bluetooth or Network).
  final PrinterConnectionType connectionType;

  /// Printer address.
  /// - For Bluetooth: MAC address (e.g., "00:11:22:33:44:55")
  /// - For Network: IP address (e.g., "192.168.1.100")
  final String? address;

  /// Port number for network printers. Defaults to 9100.
  final int port;

  /// Paper width (58mm or 80mm).
  final PrinterPaperWidth paperWidth;

  /// Whether this is the default printer.
  final bool isDefault;

  /// Whether the printer is enabled.
  final bool isEnabled;

  /// Associated branch ID (optional).
  final String? branchId;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;

  /// Whether the printer has a valid address configured.
  bool get hasAddress => address != null && address!.isNotEmpty;

  /// Whether this is a Bluetooth printer.
  bool get isBluetooth => connectionType == PrinterConnectionType.bluetooth;

  /// Whether this is a network printer.
  bool get isNetwork => connectionType == PrinterConnectionType.network;
}
