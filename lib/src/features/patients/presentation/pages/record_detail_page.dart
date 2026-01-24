import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/patient.dart';
import '../../domain/patient_record.dart';
import '../../domain/prescription.dart';
import '../controllers/patient_provider.dart';
import '../controllers/patient_record_provider.dart';
import '../controllers/prescription_controller.dart';
import '../pdf/prescription_pdf_generator.dart';
import '../widgets/sections/prescriptions_section.dart';
import '../widgets/sheets/edit_record_sheet.dart';

/// Full-screen page showing record details.
class RecordDetailPage extends ConsumerWidget {
  const RecordDetailPage({
    super.key,
    required this.patientId,
    required this.recordId,
  });

  final String patientId;
  final String recordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final patientAsync = ref.watch(patientProvider(patientId));
    final recordAsync = ref.watch(patientRecordProvider(recordId));

    // Handle loading state for both patient and record
    if (patientAsync.isLoading || recordAsync.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Handle error state
    if (patientAsync.hasError) {
      return Scaffold(
        appBar: AppBar(title: const Text('Record Details')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('Error: ${patientAsync.error.toString()}'),
            ],
          ),
        ),
      );
    }

    if (recordAsync.hasError) {
      return Scaffold(
        appBar: AppBar(title: const Text('Record Details')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('Error: ${recordAsync.error.toString()}'),
            ],
          ),
        ),
      );
    }

    final patient = patientAsync.value;
    final record = recordAsync.value;

    if (patient == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Record Details')),
        body: const Center(child: Text('Patient not found')),
      );
    }

    if (record == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Record Details')),
        body: const Center(child: Text('Record not found')),
      );
    }

    return _buildContent(context, ref, theme, patient, record);
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
    Patient patient,
    PatientRecord record,
  ) {
    final dateStr = _formatDate(record.date);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                useRootNavigator: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => EditRecordSheet(record: record),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(patientProvider(patientId));
          ref.invalidate(patientRecordProvider(recordId));
          await Future.wait([
            ref.read(patientProvider(patientId).future),
            ref.read(patientRecordProvider(recordId).future),
          ]);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patient info
            _buildPatientCard(theme, patient),
            const SizedBox(height: 24),

            // Visit date
            Text('Visit Date', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 20),
                    const SizedBox(width: 12),
                    Text(dateStr),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Vitals
            Text('Vitals', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            _buildVitalsRow(theme, record),
            const SizedBox(height: 24),

            // Diagnosis
            Text('Diagnosis', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(record.diagnosis),
              ),
            ),

            if (record.notes != null) ...[
              const SizedBox(height: 24),
              Text('Notes', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(record.notes!),
                ),
              ),
            ],

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),

            // Prescriptions
            PrescriptionsSection(recordId: recordId),

            const SizedBox(height: 32),

            // Actions
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: () => _showPrescriptionGroupSelector(
                    context,
                    ref,
                    patient,
                    record,
                    action: _PdfAction.print,
                  ),
                  icon: const Icon(Icons.print),
                  label: const Text('Print'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _showPrescriptionGroupSelector(
                    context,
                    ref,
                    patient,
                    record,
                    action: _PdfAction.share,
                  ),
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _showPrescriptionGroupSelector(
                    context,
                    ref,
                    patient,
                    record,
                    action: _PdfAction.save,
                  ),
                  icon: const Icon(Icons.download),
                  label: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildPatientCard(ThemeData theme, Patient patient) {
    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: patient.species == 'Dog'
                  ? Colors.brown.shade100
                  : Colors.orange.shade100,
              child: Icon(
                patient.species == 'Dog' ? Icons.pets : Icons.catching_pokemon,
                color: patient.species == 'Dog' ? Colors.brown : Colors.orange,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.name,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text('${patient.species ?? ''} - ${patient.breed ?? ''}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalsRow(ThemeData theme, PatientRecord record) {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.monitor_weight, size: 32),
                  const SizedBox(height: 8),
                  Text(record.weight, style: theme.textTheme.headlineSmall),
                  Text('Weight', style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.thermostat, size: 32),
                  const SizedBox(height: 8),
                  Text(record.temperature,
                      style: theme.textTheme.headlineSmall),
                  Text('Temperature', style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final month = months[date.month - 1];
    final amPm = date.hour >= 12 ? 'PM' : 'AM';
    final hour =
        date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final minute = date.minute.toString().padLeft(2, '0');
    return '$month ${date.day}, ${date.year} $hour:$minute $amPm';
  }

  /// Groups prescriptions by date and returns a sorted map (newest first).
  Map<DateTime, List<Prescription>> _groupPrescriptionsByDate(
      List<Prescription> prescriptions) {
    final grouped = groupBy<Prescription, DateTime>(
      prescriptions,
      (p) {
        final date = p.date ?? p.created ?? DateTime.now();
        return DateTime(date.year, date.month, date.day);
      },
    );
    final sortedKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));
    return {for (final key in sortedKeys) key: grouped[key]!};
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (date == today) {
      return 'Today';
    } else if (date == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMMM d, yyyy').format(date);
    }
  }

  void _showPrescriptionGroupSelector(
    BuildContext context,
    WidgetRef ref,
    Patient patient,
    PatientRecord record, {
    required _PdfAction action,
  }) {
    final prescriptionsAsync =
        ref.read(prescriptionControllerProvider(recordId));

    prescriptionsAsync.when(
      loading: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Loading prescriptions...')),
        );
      },
      error: (error, stack) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load prescriptions')),
        );
      },
      data: (prescriptions) {
        if (prescriptions.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No prescriptions available')),
          );
          return;
        }

        final groupedPrescriptions = _groupPrescriptionsByDate(prescriptions);

        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) => _PrescriptionGroupSelectorSheet(
            groupedPrescriptions: groupedPrescriptions,
            formatDateHeader: _formatDateHeader,
            onSelect: (date, prescriptions) async {
              Navigator.pop(context);
              final pdfData = PrescriptionPdfData(
                prescriptions: prescriptions,
                patient: patient,
                record: record,
                prescriptionDate: date,
              );
              final generator = PrescriptionPdfGenerator(pdfData);
              switch (action) {
                case _PdfAction.print:
                  await generator.printPrescription();
                case _PdfAction.share:
                  await generator.sharePrescription();
                case _PdfAction.save:
                  final path = await generator.savePrescription();
                  if (context.mounted && path != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Prescription saved')),
                    );
                  }
              }
            },
            action: action,
          ),
        );
      },
    );
  }
}

/// Action type for prescription PDF.
enum _PdfAction { print, share, save }

/// Bottom sheet for selecting a prescription group to print/share/save.
class _PrescriptionGroupSelectorSheet extends StatelessWidget {
  const _PrescriptionGroupSelectorSheet({
    required this.groupedPrescriptions,
    required this.formatDateHeader,
    required this.onSelect,
    required this.action,
  });

  final Map<DateTime, List<Prescription>> groupedPrescriptions;
  final String Function(DateTime) formatDateHeader;
  final void Function(DateTime date, List<Prescription> prescriptions) onSelect;
  final _PdfAction action;

  String get _title => switch (action) {
        _PdfAction.print => 'Select Prescription to Print',
        _PdfAction.share => 'Select Prescription to Share',
        _PdfAction.save => 'Select Prescription to Save',
      };

  IconData get _trailingIcon => switch (action) {
        _PdfAction.print => Icons.print,
        _PdfAction.share => Icons.share,
        _PdfAction.save => Icons.download,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _title,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Choose a prescription group by date',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          ...groupedPrescriptions.entries.map((entry) {
            final date = entry.key;
            final prescriptions = entry.value;
            final medicationNames =
                prescriptions.map((p) => p.medication).join(', ');

            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: const Icon(Icons.medication),
                title: Text(formatDateHeader(date)),
                subtitle: Text(
                  '${prescriptions.length} medication${prescriptions.length > 1 ? 's' : ''}: $medicationNames',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(_trailingIcon),
                onTap: () => onSelect(date, prescriptions),
              ),
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
