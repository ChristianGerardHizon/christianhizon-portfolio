import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../domain/patient.dart';

/// Bottom sheet for editing patient information.
class EditPatientSheet extends HookWidget {
  const EditPatientSheet({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    final nameController = useTextEditingController(text: patient.name);
    final breedController = useTextEditingController(text: patient.breed);
    final ownerController = useTextEditingController(text: patient.owner);
    final phoneController = useTextEditingController(text: patient.contactNumber);

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
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

            Text('Edit Patient', style: theme.textTheme.titleLarge),
            const SizedBox(height: 24),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Pet Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.pets),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: breedController,
              decoration: const InputDecoration(
                labelText: 'Breed',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: ownerController,
              decoration: const InputDecoration(
                labelText: 'Owner Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),

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
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Patient updated (demo)')),
                      );
                    },
                    child: Text(t.common.save),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
