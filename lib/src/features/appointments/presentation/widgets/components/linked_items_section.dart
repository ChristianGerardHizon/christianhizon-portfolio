import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../patients/domain/patient_record.dart';
import '../../../../patients/domain/patient_treatment_record.dart';

/// Section widget for displaying linked records and treatments on an appointment.
///
/// Shows compact chips/tiles for linked items with options to add more.
class LinkedItemsSection extends StatelessWidget {
  const LinkedItemsSection({
    super.key,
    required this.patientRecords,
    required this.treatmentRecords,
    this.onAddRecordPressed,
    this.onAddTreatmentPressed,
    this.onLinkExistingPressed,
    this.onRecordTap,
    this.onTreatmentTap,
    this.showActions = true,
  });

  /// The linked patient records (expanded data).
  final List<PatientRecord> patientRecords;

  /// The linked treatment records (expanded data).
  final List<PatientTreatmentRecord> treatmentRecords;

  /// Callback when "Create Record" is pressed.
  final VoidCallback? onAddRecordPressed;

  /// Callback when "Create Treatment" is pressed.
  final VoidCallback? onAddTreatmentPressed;

  /// Callback when "Link Existing" is pressed.
  final VoidCallback? onLinkExistingPressed;

  /// Callback when a record chip is tapped.
  final void Function(PatientRecord record)? onRecordTap;

  /// Callback when a treatment chip is tapped.
  final void Function(PatientTreatmentRecord treatment)? onTreatmentTap;

  /// Whether to show action buttons (add record, add treatment, link existing).
  final bool showActions;

  bool get _hasItems => patientRecords.isNotEmpty || treatmentRecords.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Icon(
              Icons.link,
              size: 18,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              'Linked Items',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (_hasItems) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${patientRecords.length + treatmentRecords.length}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),

        // Linked items
        if (_hasItems) ...[
          // Patient Records
          if (patientRecords.isNotEmpty) ...[
            _buildSectionLabel(context, 'Records', Icons.medical_services_outlined),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: patientRecords.map((record) {
                return _RecordChip(
                  record: record,
                  onTap: onRecordTap != null ? () => onRecordTap!(record) : null,
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
          ],

          // Treatment Records
          if (treatmentRecords.isNotEmpty) ...[
            _buildSectionLabel(context, 'Treatments', Icons.healing_outlined),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: treatmentRecords.map((treatment) {
                return _TreatmentChip(
                  treatment: treatment,
                  onTap: onTreatmentTap != null ? () => onTreatmentTap!(treatment) : null,
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
          ],
        ] else ...[
          // Empty state
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 20,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'No records or treatments linked to this appointment.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],

        // Action buttons
        if (showActions) ...[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (onLinkExistingPressed != null)
                ActionChip(
                  avatar: const Icon(Icons.link, size: 18),
                  label: const Text('Link Existing'),
                  onPressed: onLinkExistingPressed,
                ),
              if (onAddRecordPressed != null)
                ActionChip(
                  avatar: const Icon(Icons.add, size: 18),
                  label: const Text('New Record'),
                  onPressed: onAddRecordPressed,
                ),
              if (onAddTreatmentPressed != null)
                ActionChip(
                  avatar: const Icon(Icons.add, size: 18),
                  label: const Text('New Treatment'),
                  onPressed: onAddTreatmentPressed,
                ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label, IconData icon) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

/// Chip widget for displaying a linked patient record.
class _RecordChip extends StatelessWidget {
  const _RecordChip({
    required this.record,
    this.onTap,
  });

  final PatientRecord record;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d');

    return InputChip(
      label: Text(
        record.diagnosis.isNotEmpty
            ? record.diagnosis
            : 'Record ${dateFormat.format(record.date)}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      avatar: Icon(
        Icons.medical_services_outlined,
        size: 18,
        color: theme.colorScheme.primary,
      ),
      onPressed: onTap,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

/// Chip widget for displaying a linked treatment record.
class _TreatmentChip extends StatelessWidget {
  const _TreatmentChip({
    required this.treatment,
    this.onTap,
  });

  final PatientTreatmentRecord treatment;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InputChip(
      label: Text(
        treatment.treatmentName.isNotEmpty
            ? treatment.treatmentName
            : 'Treatment',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      avatar: Icon(
        Icons.healing_outlined,
        size: 18,
        color: theme.colorScheme.secondary,
      ),
      onPressed: onTap,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

/// Compact indicator for linked items count (for use in cards).
class LinkedItemsIndicator extends StatelessWidget {
  const LinkedItemsIndicator({
    super.key,
    required this.recordCount,
    required this.treatmentCount,
  });

  final int recordCount;
  final int treatmentCount;

  int get totalCount => recordCount + treatmentCount;

  @override
  Widget build(BuildContext context) {
    if (totalCount == 0) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Tooltip(
      message: _buildTooltipMessage(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.link,
              size: 14,
              color: theme.colorScheme.onPrimaryContainer,
            ),
            const SizedBox(width: 4),
            Text(
              totalCount.toString(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _buildTooltipMessage() {
    final parts = <String>[];
    if (recordCount > 0) {
      parts.add('$recordCount record${recordCount > 1 ? 's' : ''}');
    }
    if (treatmentCount > 0) {
      parts.add('$treatmentCount treatment${treatmentCount > 1 ? 's' : ''}');
    }
    return parts.join(', ');
  }
}
