import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/i18n/strings.g.dart';
import '../../../../../core/utils/file_validation.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/patient_file.dart';

/// Dialog for uploading a new patient file.
class AddFileDialog extends HookWidget {
  const AddFileDialog({
    super.key,
    required this.patientId,
    required this.onUpload,
  });

  final String patientId;

  /// Callback when uploading. Returns (success, errorMessage).
  final Future<(bool, String?)> Function({
    required String fileName,
    required List<int> bytes,
    String? notes,
  }) onUpload;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final size = MediaQuery.sizeOf(context);

    final notesController = useTextEditingController();
    final selectedFile = useState<PlatformFile?>(null);
    final isUploading = useState(false);
    final validationError = useState<String?>(null);

    Future<void> pickFile() async {
      try {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: FileValidation.allowedExtensions,
          withData: true,
        );

        if (result != null && result.files.isNotEmpty) {
          final file = result.files.first;

          // Validate file size
          final sizeError = FileValidation.validateFileSize(file.size);
          if (sizeError != null) {
            validationError.value = sizeError;
            selectedFile.value = null;
            return;
          }

          validationError.value = null;
          selectedFile.value = file;
        }
      } catch (e) {
        if (context.mounted) {
          showErrorSnackBar(context, message: 'Failed to pick file: $e');
        }
      }
    }

    Future<void> handleUpload() async {
      final file = selectedFile.value;
      if (file == null || file.bytes == null) {
        showWarningSnackBar(context, message: 'Please select a file');
        return;
      }

      isUploading.value = true;

      final (success, error) = await onUpload(
        fileName: file.name,
        bytes: file.bytes!,
        notes: notesController.text.isEmpty ? null : notesController.text,
      );

      if (context.mounted) {
        isUploading.value = false;
        if (success) {
          context.pop();
          showSuccessSnackBar(context, message: 'File uploaded successfully');
        } else {
          showErrorSnackBar(context, message: error ?? 'Failed to upload file');
        }
      }
    }

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: isUploading.value ? null : () => context.pop(),
                ),
                Expanded(
                  child: Text('Add File', style: theme.textTheme.titleLarge),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: TextButton(
                    onPressed: isUploading.value ? null : () => context.pop(),
                    child: Text(t.common.cancel),
                  ),
                ),
                FilledButton(
                  onPressed: isUploading.value || selectedFile.value == null
                      ? null
                      : handleUpload,
                  child: isUploading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Upload'),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  // File picker area
                  _buildFilePicker(
                    context,
                    selectedFile: selectedFile.value,
                    validationError: validationError.value,
                    isUploading: isUploading.value,
                    onPick: pickFile,
                    onClear: () {
                      selectedFile.value = null;
                      validationError.value = null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Notes field
                  TextField(
                    controller: notesController,
                    decoration: const InputDecoration(
                      labelText: 'Notes (optional)',
                      border: OutlineInputBorder(),
                      hintText: 'Add a description or notes about this file',
                    ),
                    maxLines: 2,
                    enabled: !isUploading.value,
                  ),
                  const SizedBox(height: 16),

                  // Info text
                  Text(
                    'Supported: ${FileValidation.allowedTypesDescription}\nMax size: ${FileValidation.maxFileSizeMB.toInt()} MB',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilePicker(
    BuildContext context, {
    required PlatformFile? selectedFile,
    required String? validationError,
    required bool isUploading,
    required VoidCallback onPick,
    required VoidCallback onClear,
  }) {
    final theme = Theme.of(context);

    if (selectedFile != null) {
      final fileType = PatientFileType.fromExtension(
        selectedFile.name.split('.').last,
      );

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                fileType.icon,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedFile.name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    FileValidation.formatFileSize(selectedFile.size),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
            if (!isUploading)
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: onClear,
                tooltip: 'Remove',
              ),
          ],
        ),
      );
    }

    return InkWell(
      onTap: isUploading ? null : onPick,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          border: Border.all(
            color: validationError != null
                ? theme.colorScheme.error
                : theme.colorScheme.outline,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              size: 48,
              color: validationError != null
                  ? theme.colorScheme.error
                  : theme.colorScheme.outline,
            ),
            const SizedBox(height: 8),
            Text(
              validationError ?? 'Tap to select a file',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: validationError != null
                    ? theme.colorScheme.error
                    : theme.colorScheme.outline,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Shows the add file dialog.
void showAddFileDialog(
  BuildContext context, {
  required String patientId,
  required Future<(bool, String?)> Function({
    required String fileName,
    required List<int> bytes,
    String? notes,
  }) onUpload,
}) {
  showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: AddFileDialog(
        patientId: patientId,
        onUpload: onUpload,
      ),
    ),
  );
}
