import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/widgets/form/experience_list_editor.dart';
import '../../../../core/widgets/form/key_value_list_editor.dart';
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

    // List state managed via hooks instead of JSON text fields
    final stats = useState<List<Map<String, String>>>(
      profile?.stats
              .map((s) => {'value': s.value, 'label': s.label})
              .toList() ??
          [],
    );

    final skills = useState<List<Map<String, String>>>(
      profile?.skills
              .map((s) => {'name': s.name, 'category': s.category})
              .toList() ??
          [],
    );

    final experience = useState<List<Map<String, String>>>(
      profile?.experience
              .map((e) => {
                    'company': e.company,
                    'role': e.role,
                    'startDate': e.startDate,
                    'endDate': e.endDate ?? '',
                    'description': e.description,
                  })
              .toList() ??
          [],
    );

    Future<void> handleSave() async {
      if (!formKey.currentState!.saveAndValidate()) return;

      isSaving.value = true;
      final values = formKey.currentState!.value;

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
        'skills': skills.value,
        'experience': experience.value,
        'stats': stats.value,
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
                  KeyValueListEditor(
                    label: 'Stats',
                    items: stats.value,
                    keyLabel: 'Value',
                    valueLabel: 'Label',
                    addButtonLabel: 'Add Stat',
                    onChanged: (v) => stats.value = v,
                  ),
                  const SizedBox(height: 16),
                  KeyValueListEditor(
                    label: 'Skills',
                    items: skills.value,
                    keyLabel: 'Name',
                    valueLabel: 'Category',
                    addButtonLabel: 'Add Skill',
                    onChanged: (v) => skills.value = v,
                  ),
                  const SizedBox(height: 16),
                  ExperienceListEditor(
                    items: experience.value,
                    onChanged: (v) => experience.value = v,
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
