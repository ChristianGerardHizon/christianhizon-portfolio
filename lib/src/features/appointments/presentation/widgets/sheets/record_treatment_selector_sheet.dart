import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../patients/domain/patient_record.dart';
import '../../../../patients/domain/patient_treatment_record.dart';
import '../../../../patients/presentation/controllers/patient_records_controller.dart';
import '../../../../patients/presentation/controllers/patient_treatment_records_controller.dart';

/// Bottom sheet for selecting existing records and treatments to link to an appointment.
class RecordTreatmentSelectorSheet extends HookConsumerWidget {
  const RecordTreatmentSelectorSheet({
    super.key,
    required this.patientId,
    required this.selectedRecordIds,
    required this.selectedTreatmentIds,
    required this.onSave,
  });

  /// The patient ID to fetch records and treatments for.
  final String patientId;

  /// Currently selected record IDs.
  final List<String> selectedRecordIds;

  /// Currently selected treatment record IDs.
  final List<String> selectedTreatmentIds;

  /// Callback when selections are saved.
  final void Function(List<String> recordIds, List<String> treatmentIds) onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    // Local state for selections
    final selectedRecords = useState<Set<String>>(selectedRecordIds.toSet());
    final selectedTreatments = useState<Set<String>>(selectedTreatmentIds.toSet());
    final recordsExpanded = useState(true);
    final treatmentsExpanded = useState(true);

    // Watch patient records and treatments
    final recordsAsync = ref.watch(patientRecordsControllerProvider(patientId));
    final treatmentsAsync = ref.watch(patientTreatmentRecordsControllerProvider(patientId));

    void handleSave() {
      onSave(
        selectedRecords.value.toList(),
        selectedTreatments.value.toList(),
      );
      Navigator.pop(context);
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          Text('Link Records & Treatments', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Select existing records and treatments to link to this appointment.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),

          // Scrollable content
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Patient Records Section
                  _buildExpansionTile(
                    context: context,
                    title: 'Patient Records',
                    icon: Icons.medical_services_outlined,
                    isExpanded: recordsExpanded.value,
                    onExpansionChanged: (expanded) => recordsExpanded.value = expanded,
                    selectedCount: selectedRecords.value.length,
                    child: recordsAsync.when(
                      loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      error: (_, __) => const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Error loading records'),
                      ),
                      data: (records) {
                        if (records.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'No records available',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          );
                        }
                        return Column(
                          children: records.map((record) {
                            return _RecordCheckboxTile(
                              record: record,
                              isSelected: selectedRecords.value.contains(record.id),
                              onChanged: (selected) {
                                if (selected == true) {
                                  selectedRecords.value = {...selectedRecords.value, record.id};
                                } else {
                                  selectedRecords.value = {...selectedRecords.value}..remove(record.id);
                                }
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Treatment Records Section
                  _buildExpansionTile(
                    context: context,
                    title: 'Treatments',
                    icon: Icons.healing_outlined,
                    isExpanded: treatmentsExpanded.value,
                    onExpansionChanged: (expanded) => treatmentsExpanded.value = expanded,
                    selectedCount: selectedTreatments.value.length,
                    child: treatmentsAsync.when(
                      loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      error: (_, __) => const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Error loading treatments'),
                      ),
                      data: (treatments) {
                        if (treatments.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'No treatments available',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          );
                        }
                        return Column(
                          children: treatments.map((treatment) {
                            return _TreatmentCheckboxTile(
                              treatment: treatment,
                              isSelected: selectedTreatments.value.contains(treatment.id),
                              onChanged: (selected) {
                                if (selected == true) {
                                  selectedTreatments.value = {...selectedTreatments.value, treatment.id};
                                } else {
                                  selectedTreatments.value = {...selectedTreatments.value}..remove(treatment.id);
                                }
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(t.common.cancel),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: handleSave,
                  child: Text('Link Selected'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required bool isExpanded,
    required ValueChanged<bool> onExpansionChanged,
    required int selectedCount,
    required Widget child,
  }) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Row(
          children: [
            Text(title),
            if (selectedCount > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  selectedCount.toString(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ],
        ),
        initiallyExpanded: isExpanded,
        onExpansionChanged: onExpansionChanged,
        children: [child],
      ),
    );
  }
}

class _RecordCheckboxTile extends StatelessWidget {
  const _RecordCheckboxTile({
    required this.record,
    required this.isSelected,
    required this.onChanged,
  });

  final PatientRecord record;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d, yyyy');

    return CheckboxListTile(
      value: isSelected,
      onChanged: onChanged,
      title: Text(
        record.diagnosis.isNotEmpty ? record.diagnosis : 'No diagnosis',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        dateFormat.format(record.date),
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      secondary: record.appointment != null
          ? Tooltip(
              message: 'Already linked to an appointment',
              child: Icon(Icons.link, color: theme.colorScheme.primary, size: 20),
            )
          : null,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}

class _TreatmentCheckboxTile extends StatelessWidget {
  const _TreatmentCheckboxTile({
    required this.treatment,
    required this.isSelected,
    required this.onChanged,
  });

  final PatientTreatmentRecord treatment;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d, yyyy');

    return CheckboxListTile(
      value: isSelected,
      onChanged: onChanged,
      title: Text(
        treatment.treatmentName.isNotEmpty ? treatment.treatmentName : 'Unknown treatment',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        treatment.date != null ? dateFormat.format(treatment.date!) : 'No date',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      secondary: treatment.appointment != null
          ? Tooltip(
              message: 'Already linked to an appointment',
              child: Icon(Icons.link, color: theme.colorScheme.primary, size: 20),
            )
          : null,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
