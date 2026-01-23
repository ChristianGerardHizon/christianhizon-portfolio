import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/patient.dart';
import '../../../domain/patient_file.dart';
import '../../controllers/patient_files_controller.dart';
import '../../pages/file_viewer_page.dart';
import '../cards/file_card.dart';
import '../sheets/add_file_sheet.dart';

/// Tab displaying patient files with upload capability.
class PatientFilesTab extends HookConsumerWidget {
  const PatientFilesTab({
    super.key,
    required this.patient,
  });

  final Patient patient;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filesAsync = ref.watch(patientFilesControllerProvider(patient.id));

    return filesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorState(context, ref, error),
      data: (files) => files.isEmpty
          ? _buildEmptyState(context, ref)
          : _buildFileGrid(context, ref, files),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, Object error) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load files',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => ref
                  .read(patientFilesControllerProvider(patient.id).notifier)
                  .refresh(),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.folder_open,
              size: 64,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No files yet',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Upload images, videos, or documents for this patient',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => _showAddFileSheet(context, ref),
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload File'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileGrid(
    BuildContext context,
    WidgetRef ref,
    List<PatientFile> files,
  ) {
    return RefreshIndicator(
      onRefresh: () =>
          ref.read(patientFilesControllerProvider(patient.id).notifier).refresh(),
      child: CustomScrollView(
        slivers: [
          // File grid with add button as first item
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  // First item is the add button
                  if (index == 0) {
                    return _AddFileCard(
                      onTap: () => _showAddFileSheet(context, ref),
                    );
                  }
                  // Adjust index for actual files
                  final file = files[index - 1];
                  return FileCard(
                    file: file,
                    onTap: () => _viewFile(context, file),
                    onLongPress: () => _showFileOptions(context, ref, file),
                    onMenuTap: () => _showFileOptions(context, ref, file),
                  );
                },
                childCount: files.length + 1, // +1 for add button
              ),
            ),
          ),
          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
        ],
      ),
    );
  }

  void _showAddFileSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      builder: (context) => AddFileSheet(
        patientId: patient.id,
        onUpload: ({
          required String fileName,
          required List<int> bytes,
          String? notes,
        }) =>
            ref
                .read(patientFilesControllerProvider(patient.id).notifier)
                .uploadFile(fileName: fileName, bytes: bytes, notes: notes),
      ),
    );
  }

  void _viewFile(BuildContext context, PatientFile file) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FileViewerPage(file: file),
      ),
    );
  }

  void _showFileOptions(BuildContext context, WidgetRef ref, PatientFile file) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.visibility),
              title: const Text('View'),
              onTap: () {
                Navigator.pop(context);
                _viewFile(context, file);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Notes'),
              onTap: () {
                Navigator.pop(context);
                _showEditNotesDialog(context, ref, file);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
              title: Text(
                'Delete',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(context, ref, file);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditNotesDialog(
    BuildContext context,
    WidgetRef ref,
    PatientFile file,
  ) {
    final controller = TextEditingController(text: file.notes);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Notes'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Notes',
            hintText: 'Add a description or notes',
          ),
          maxLines: 3,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final rootMessenger = ScaffoldMessenger.of(context);
              Navigator.pop(context);
              final (success, error) = await ref
                  .read(patientFilesControllerProvider(patient.id).notifier)
                  .updateNotes(file.id, controller.text.isEmpty ? null : controller.text);

              rootMessenger.showSnackBar(
                SnackBar(
                  content: Text(success ? 'Notes updated' : (error ?? 'Failed to update notes')),
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, PatientFile file) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete File'),
        content: Text('Are you sure you want to delete "${file.displayName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () async {
              final rootMessenger = ScaffoldMessenger.of(context);
              Navigator.pop(context);
              final (success, error) = await ref
                  .read(patientFilesControllerProvider(patient.id).notifier)
                  .deleteFile(file.id);

              rootMessenger.showSnackBar(
                SnackBar(
                  content: Text(success ? 'File deleted' : (error ?? 'Failed to delete file')),
                ),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

}

/// Card widget for adding a new file.
class _AddFileCard extends StatelessWidget {
  const _AddFileCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.5),
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  size: 32,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Add File',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// FAB for adding files, to be used in the patient detail page.
class AddFileFab extends ConsumerWidget {
  const AddFileFab({
    super.key,
    required this.patientId,
  });

  final String patientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () => _showAddFileSheet(context, ref),
      child: const Icon(Icons.add),
    );
  }

  void _showAddFileSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      builder: (context) => AddFileSheet(
        patientId: patientId,
        onUpload: ({
          required String fileName,
          required List<int> bytes,
          String? notes,
        }) =>
            ref
                .read(patientFilesControllerProvider(patientId).notifier)
                .uploadFile(fileName: fileName, bytes: bytes, notes: notes),
      ),
    );
  }
}
