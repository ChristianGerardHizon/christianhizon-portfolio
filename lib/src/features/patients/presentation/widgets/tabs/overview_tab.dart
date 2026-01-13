import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/patient.dart';
import '../patient_avatar.dart';

/// Overview tab showing a customizable brief summary of the patient.
///
/// Displays key patient information in a card-based layout.
/// The content can be customized based on user preferences.
class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key, required this.patient});

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

          // Quick info chips
          _buildQuickInfoSection(theme),
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

  Widget _buildAvatar(BuildContext context, ThemeData theme, {double radius = 36}) {
    return PatientAvatar(
      patient: patient,
      radius: radius,
      onTap: patient.hasAvatar ? () => _showImageViewer(context, patient.avatar!) : null,
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

  Widget _buildQuickInfoSection(ThemeData theme) {
    final items = <_InfoItem>[
      if (patient.sex != null)
        _InfoItem(
          icon: Icons.wc,
          label: 'Sex',
          value: patient.sex!.name.substring(0, 1).toUpperCase() +
              patient.sex!.name.substring(1),
        ),
      if (patient.color != null && patient.color!.isNotEmpty)
        _InfoItem(
          icon: Icons.palette,
          label: 'Color',
          value: patient.color!,
        ),
      if (patient.dateOfBirth != null)
        _InfoItem(
          icon: Icons.cake,
          label: 'Birthday',
          value: _formatDate(patient.dateOfBirth!),
        ),
    ];

    if (items.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) => _buildInfoChip(item, theme)).toList(),
    );
  }

  Widget _buildInfoChip(_InfoItem item, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            item.icon,
            size: 18,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                item.value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
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
                  'Owner',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              patient.owner!,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            if (patient.contactNumber != null &&
                patient.contactNumber!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    patient.contactNumber!,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
            if (patient.email != null && patient.email!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    patient.email!,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
            if (patient.address != null && patient.address!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      patient.address!,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton.tonalIcon(
              onPressed: () {
                // TODO: Implement add record
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add record coming soon')),
                );
              },
              icon: const Icon(Icons.note_add),
              label: const Text('New Record'),
            ),
            FilledButton.tonalIcon(
              onPressed: () {
                // TODO: Implement book appointment
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Book appointment coming soon')),
                );
              },
              icon: const Icon(Icons.calendar_today),
              label: const Text('Book'),
            ),
            if (patient.contactNumber != null &&
                patient.contactNumber!.isNotEmpty)
              OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement call
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

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

class _InfoItem {
  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}
