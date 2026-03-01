import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../portfolio/domain/profile.dart';
import '../../../portfolio/presentation/controllers/profile_controller.dart';

/// Form widget for editing the portfolio profile.
class ProfileForm extends HookConsumerWidget {
  const ProfileForm({super.key, this.profile});

  final Profile? profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);
    final theme = Theme.of(context);

    // Serialize skills and experience to editable text
    final skillsText = profile?.skills.isNotEmpty == true
        ? jsonEncode(profile!.skills
            .map((s) => {'name': s.name, 'category': s.category})
            .toList())
        : '[]';

    final experienceText = profile?.experience.isNotEmpty == true
        ? jsonEncode(profile!.experience
            .map((e) => {
                  'company': e.company,
                  'role': e.role,
                  'startDate': e.startDate,
                  'endDate': e.endDate,
                  'description': e.description,
                })
            .toList())
        : '[]';

    final statsText = profile?.stats.isNotEmpty == true
        ? jsonEncode(profile!.stats
            .map((s) => {'value': s.value, 'label': s.label})
            .toList())
        : '[]';

    Future<void> handleSave() async {
      if (!formKey.currentState!.saveAndValidate()) return;

      isSaving.value = true;
      final values = formKey.currentState!.value;

      // Parse skills JSON
      dynamic skills;
      try {
        skills = jsonDecode(values['skills'] as String? ?? '[]');
      } catch (_) {
        skills = [];
      }

      // Parse experience JSON
      dynamic experience;
      try {
        experience = jsonDecode(values['experience'] as String? ?? '[]');
      } catch (_) {
        experience = [];
      }

      // Parse stats JSON
      dynamic stats;
      try {
        stats = jsonDecode(values['stats'] as String? ?? '[]');
      } catch (_) {
        stats = [];
      }

      final data = <String, dynamic>{
        'name': values['name'],
        'title': values['title'] ?? '',
        'bio': values['bio'] ?? '',
        'email': values['email'] ?? '',
        'phone': values['phone'] ?? '',
        'location': values['location'] ?? '',
        'githubUrl': values['githubUrl'] ?? '',
        'linkedinUrl': values['linkedinUrl'] ?? '',
        'websiteUrl': values['websiteUrl'] ?? '',
        'stackOverflowUrl': values['stackOverflowUrl'] ?? '',
        'availabilityStatus': values['availabilityStatus'] ?? '',
        'skills': skills,
        'experience': experience,
        'stats': stats,
      };

      final success = await ref
          .read(profileControllerProvider.notifier)
          .save(id: profile?.id, data: data);

      isSaving.value = false;

      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile saved successfully')),
        );
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: FormBuilder(
        key: formKey,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Edit Profile', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 24),
              // Personal Information
              _buildSection(
                theme: theme,
                title: 'Personal Information',
                icon: Icons.person_outline,
                children: [
                  FormBuilderTextField(
                    name: 'name',
                    initialValue: profile?.name ?? '',
                    decoration: const InputDecoration(labelText: 'Name *'),
                    validator: FormBuilderValidators.required(),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'title',
                    initialValue: profile?.title ?? '',
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'e.g. Full Stack Developer',
                    ),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'bio',
                    initialValue: profile?.bio ?? '',
                    decoration: const InputDecoration(labelText: 'Bio'),
                    maxLines: 4,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Contact Details
              _buildSection(
                theme: theme,
                title: 'Contact Details',
                icon: Icons.contact_mail_outlined,
                children: [
                  FormBuilderTextField(
                    name: 'email',
                    initialValue: profile?.email ?? '',
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.email(),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'phone',
                    initialValue: profile?.phone ?? '',
                    decoration: const InputDecoration(labelText: 'Phone'),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'location',
                    initialValue: profile?.location ?? '',
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      hintText: 'e.g. Manila, Philippines',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Social Links
              _buildSection(
                theme: theme,
                title: 'Social Links',
                icon: Icons.link,
                children: [
                  FormBuilderTextField(
                    name: 'githubUrl',
                    initialValue: profile?.githubUrl ?? '',
                    decoration:
                        const InputDecoration(labelText: 'GitHub URL'),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'linkedinUrl',
                    initialValue: profile?.linkedinUrl ?? '',
                    decoration:
                        const InputDecoration(labelText: 'LinkedIn URL'),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'websiteUrl',
                    initialValue: profile?.websiteUrl ?? '',
                    decoration:
                        const InputDecoration(labelText: 'Website URL'),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'stackOverflowUrl',
                    initialValue: profile?.stackOverflowUrl ?? '',
                    decoration: const InputDecoration(
                        labelText: 'Stack Overflow URL'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Portfolio Display
              _buildSection(
                theme: theme,
                title: 'Portfolio Display',
                icon: Icons.dashboard_outlined,
                children: [
                  FormBuilderTextField(
                    name: 'availabilityStatus',
                    initialValue: profile?.availabilityStatus ?? '',
                    decoration: const InputDecoration(
                      labelText: 'Availability Status',
                      hintText: 'e.g. Available for Contracts',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Stats — Format: [{"value": "5+", "label": "Years Flutter"}]',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormBuilderTextField(
                    name: 'stats',
                    initialValue: statsText,
                    decoration:
                        const InputDecoration(labelText: 'Stats JSON'),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Skills — Format: [{"name": "Flutter", "category": "Mobile"}]',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormBuilderTextField(
                    name: 'skills',
                    initialValue: skillsText,
                    decoration:
                        const InputDecoration(labelText: 'Skills JSON'),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Experience — Format: [{"company": "...", "role": "...", "startDate": "2020", "endDate": "2023", "description": "..."}]',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormBuilderTextField(
                    name: 'experience',
                    initialValue: experienceText,
                    decoration:
                        const InputDecoration(labelText: 'Experience JSON'),
                    maxLines: 6,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: isSaving.value ? null : handleSave,
                  icon: isSaving.value
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save),
                  label: Text(isSaving.value ? 'Saving...' : 'Save Profile'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required ThemeData theme,
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(title, style: theme.textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}
