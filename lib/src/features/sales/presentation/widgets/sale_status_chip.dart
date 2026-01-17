import 'package:flutter/material.dart';

/// Color-coded chip showing sale status.
class SaleStatusChip extends StatelessWidget {
  const SaleStatusChip({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    final (color, icon) = _getStatusStyle(status);

    return Chip(
      avatar: Icon(icon, size: 16, color: color),
      label: Text(
        _formatStatus(status),
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
      backgroundColor: color.withValues(alpha: 0.1),
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 2),
      visualDensity: VisualDensity.compact,
    );
  }

  (Color, IconData) _getStatusStyle(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return (Colors.green, Icons.check_circle);
      case 'refunded':
        return (Colors.orange, Icons.refresh);
      case 'voided':
        return (Colors.red, Icons.cancel);
      default:
        return (Colors.grey, Icons.help);
    }
  }

  String _formatStatus(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'Completed';
      case 'refunded':
        return 'Refunded';
      case 'voided':
        return 'Voided';
      default:
        return status;
    }
  }
}
