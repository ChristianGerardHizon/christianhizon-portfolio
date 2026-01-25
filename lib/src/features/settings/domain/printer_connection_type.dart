import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'printer_connection_type.mapper.dart';

/// Connection type for thermal printers.
@MappableEnum()
enum PrinterConnectionType {
  bluetooth,
  network;

  /// Display name for UI.
  String get displayName {
    switch (this) {
      case bluetooth:
        return 'Bluetooth';
      case network:
        return 'Network (WiFi/LAN)';
    }
  }

  /// Icon for this connection type.
  IconData get icon {
    switch (this) {
      case bluetooth:
        return Icons.bluetooth;
      case network:
        return Icons.wifi;
    }
  }
}
