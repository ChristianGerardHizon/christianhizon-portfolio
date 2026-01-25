import 'package:dart_mappable/dart_mappable.dart';

part 'printer_paper_width.mapper.dart';

/// Paper width for thermal printers.
@MappableEnum()
enum PrinterPaperWidth {
  mm58,
  mm80;

  /// Display name for UI.
  String get displayName {
    switch (this) {
      case mm58:
        return '58mm';
      case mm80:
        return '80mm';
    }
  }

  /// Characters per line for this paper width.
  int get charsPerLine {
    switch (this) {
      case mm58:
        return 32;
      case mm80:
        return 48;
    }
  }
}
