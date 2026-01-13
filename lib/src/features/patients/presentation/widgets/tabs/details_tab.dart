import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/patient.dart';
import '../patient_avatar.dart';
import '../sheets/edit_patient_sheet.dart';

/// Details tab content showing comprehensive patient and owner information.
class DetailsTab extends StatelessWidget {
  const DetailsTab({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main patient card with avatar and key info
          _buildPatientCard(context, theme),
          const SizedBox(height: 16),

          // Patient details section
          _buildPatientDetailsSection(theme),
          const SizedBox(height: 24),

          // Owner contact card
          _buildOwnerCard(theme),
          const SizedBox(height: 24),

          // Quick actions
          _buildQuickActions(context, theme),
        ],
      ),
    );
  }

  Widget _buildPatientCard(BuildContext context, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Avatar
            _buildAvatar(context, theme, radius: 48),
            const SizedBox(width: 20),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.name,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    [patient.species, patient.breed]
                        .where((s) => s != null && s.isNotEmpty)
                        .join(' • '),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (patient.age != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      patient.age!,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, ThemeData theme,
      {double radius = 36}) {
    return PatientAvatar(
      patient: patient,
      radius: radius,
      onTap:
          patient.hasAvatar ? () => _showImageViewer(context, patient.avatar!) : null,
    );
  }

  void _showImageViewer(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Center(
                    child: Icon(
                      Icons.pets,
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.broken_image,
                          size: 48,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Failed to load image',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onErrorContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton.filled(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black54,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientDetailsSection(ThemeData theme) {
    final items = <_DetailItem>[
      if (patient.sex != null)
        _DetailItem(
          icon: Icons.wc,
          label: 'Sex',
          value: patient.sex!.name.substring(0, 1).toUpperCase() +
              patient.sex!.name.substring(1),
        ),
      if (patient.color != null && patient.color!.isNotEmpty)
        _DetailItem(
          icon: Icons.palette,
          label: 'Color',
          value: patient.color!,
        ),
      if (patient.dateOfBirth != null)
        _DetailItem(
          icon: Icons.cake,
          label: 'Date of Birth',
          value: _formatDate(patient.dateOfBirth!),
        ),
      if (patient.species != null && patient.species!.isNotEmpty)
        _DetailItem(
          icon: Icons.category,
          label: 'Species',
          value: patient.species!,
        ),
      if (patient.breed != null && patient.breed!.isNotEmpty)
        _DetailItem(
          icon: Icons.pets,
          label: 'Breed',
          value: patient.breed!,
        ),
    ];

    if (items.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Patient Details',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...items.map((item) => _buildDetailRow(item, theme)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(_DetailItem item, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            item.icon,
            size: 20,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOwnerCard(ThemeData theme) {
    if (patient.owner == null || patient.owner!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Owner Information',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildOwnerDetailRow(
              Icons.person_outline,
              'Name',
              patient.owner!,
              theme,
            ),
            if (patient.contactNumber != null &&
                patient.contactNumber!.isNotEmpty)
              _buildOwnerDetailRow(
                Icons.phone,
                'Phone',
                patient.contactNumber!,
                theme,
              ),
            if (patient.email != null && patient.email!.isNotEmpty)
              _buildOwnerDetailRow(
                Icons.email,
                'Email',
                patient.email!,
                theme,
              ),
            if (patient.address != null && patient.address!.isNotEmpty)
              _buildOwnerDetailRow(
                Icons.location_on,
                'Address',
                patient.address!,
                theme,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOwnerDetailRow(
    IconData icon,
    String label,
    String value,
    ThemeData theme,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actions',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton.icon(
              onPressed: () => _showEditPatientDialog(context),
              icon: const Icon(Icons.edit),
              label: const Text('Edit Details'),
            ),
            FilledButton.tonalIcon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Book appointment coming soon')),
                );
              },
              icon: const Icon(Icons.calendar_today),
              label: const Text('Book Appointment'),
            ),
            if (patient.contactNumber != null &&
                patient.contactNumber!.isNotEmpty)
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Call feature coming soon')),
                  );
                },
                icon: const Icon(Icons.phone),
                label: const Text('Call Owner'),
              ),
          ],
        ),
      ],
    );
  }

  void _showEditPatientDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => EditPatientSheet(patient: patient),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
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
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

class _DetailItem {
  const _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}
