import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../../portfolio/domain/project.dart';
import '../../../portfolio/presentation/controllers/projects_controller.dart';

/// Dialog form for creating/editing a project.
class ProjectFormDialog extends HookConsumerWidget {
  const ProjectFormDialog({super.key, this.project});

  final Project? project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);
    final isEdit = project != null;

    final techStackText = project?.techStack.isNotEmpty == true
        ? jsonEncode(project!.techStack)
        : '[]';

    final baseUrl = pocketbaseUrl;

    Future<void> handleSave() async {
      if (!formKey.currentState!.saveAndValidate()) return;

      isSaving.value = true;
      final values = formKey.currentState!.value;

      // Parse techStack JSON
      dynamic techStack;
      try {
        techStack = jsonDecode(values['techStack'] as String? ?? '[]');
      } catch (_) {
        techStack = [];
      }

      final data = <String, dynamic>{
        'title': values['title'],
        'description': values['description'] ?? '',
        'longDescription': values['longDescription'] ?? '',
        'projectUrl': values['projectUrl'] ?? '',
        'sourceUrl': values['sourceUrl'] ?? '',
        'techStack': techStack,
        'category': values['category'] ?? '',
        'status': values['status'] ?? 'active',
        'featured': values['featured'] ?? false,
        'sortOrder':
            int.tryParse(values['sortOrder']?.toString() ?? '0') ?? 0,
        'client': values['client'] ?? '',
        'role': values['role'] ?? '',
        'timeline': values['timeline'] ?? '',
      };

      final files = <http.MultipartFile>[];

      // -- Process Thumbnail --
      final thumbnailValue = values['thumbnail'] as List<dynamic>? ?? [];
      if (thumbnailValue.isEmpty) {
        // User cleared the thumbnail
        if (isEdit && project!.thumbnail.isNotEmpty) {
          data['thumbnail'] = '';
        }
      } else {
        final item = thumbnailValue.first;
        if (item is XFile) {
          final bytes = await item.readAsBytes();
          files.add(http.MultipartFile.fromBytes(
            'thumbnail',
            bytes,
            filename: item.name,
          ));
        }
        // If it's a String (existing URL), keep current — no action needed
      }

      // -- Process Gallery --
      final galleryValue = values['gallery'] as List<dynamic>? ?? [];

      // Track removed gallery images in edit mode
      if (isEdit && project!.gallery.isNotEmpty) {
        final keptUrls =
            galleryValue.whereType<String>().toSet();
        final removedFilenames = <String>[];

        for (var i = 0; i < project!.gallery.length; i++) {
          final url = project!.galleryUrls(baseUrl)[i];
          if (!keptUrls.contains(url)) {
            removedFilenames.add(project!.gallery[i]);
          }
        }

        if (removedFilenames.isNotEmpty) {
          data['gallery-'] = removedFilenames;
        }
      }

      // Add new gallery files
      for (final item in galleryValue) {
        if (item is XFile) {
          final bytes = await item.readAsBytes();
          files.add(http.MultipartFile.fromBytes(
            'gallery',
            bytes,
            filename: item.name,
          ));
        }
      }

      bool success;
      if (isEdit) {
        success = await ref
            .read(projectsControllerProvider.notifier)
            .updateProject(project!.id, data, files: files);
      } else {
        success = await ref
            .read(projectsControllerProvider.notifier)
            .create(data, files: files);
      }

      isSaving.value = false;

      if (success && context.mounted) {
        context.pop(true);
      }
    }

    return ScaffoldMessenger(
      child: Builder(
        builder: (context) => AlertDialog(
          title: Text(isEdit ? 'Edit Project' : 'New Project'),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: SingleChildScrollView(
              child: FormBuilder(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormBuilderTextField(
                      name: 'title',
                      initialValue: project?.title ?? '',
                      decoration:
                          const InputDecoration(labelText: 'Title *'),
                      validator: FormBuilderValidators.required(),
                    ),
                    const SizedBox(height: 12),
                    FormBuilderTextField(
                      name: 'description',
                      initialValue: project?.description ?? '',
                      decoration: const InputDecoration(
                          labelText: 'Short Description'),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 12),
                    FormBuilderTextField(
                      name: 'longDescription',
                      initialValue: project?.longDescription ?? '',
                      decoration: const InputDecoration(
                          labelText: 'Long Description'),
                      maxLines: 4,
                    ),
                    const SizedBox(height: 16),

                    // -- Thumbnail Image --
                    Text(
                      'Display Image',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    FormBuilderImagePicker(
                      name: 'thumbnail',
                      maxImages: 1,
                      initialValue: _buildInitialThumbnail(project, baseUrl),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      previewWidth: 150,
                      previewHeight: 100,
                      imageQuality: 85,
                      maxWidth: 1920,
                      maxHeight: 1080,
                      availableImageSources: const [
                        ImageSourceOption.gallery,
                      ],
                    ),
                    const SizedBox(height: 16),

                    // -- Gallery Images --
                    Text(
                      'Gallery Images (max 10)',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    FormBuilderImagePicker(
                      name: 'gallery',
                      maxImages: 10,
                      initialValue: _buildInitialGallery(project, baseUrl),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      previewWidth: 100,
                      previewHeight: 100,
                      imageQuality: 85,
                      maxWidth: 1920,
                      maxHeight: 1080,
                      availableImageSources: const [
                        ImageSourceOption.gallery,
                      ],
                      validator: (value) {
                        if (value != null && value.length > 10) {
                          return 'Maximum 10 gallery images allowed';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    FormBuilderTextField(
                      name: 'projectUrl',
                      initialValue: project?.projectUrl ?? '',
                      decoration:
                          const InputDecoration(labelText: 'Live URL'),
                    ),
                    const SizedBox(height: 12),
                    FormBuilderTextField(
                      name: 'sourceUrl',
                      initialValue: project?.sourceUrl ?? '',
                      decoration:
                          const InputDecoration(labelText: 'Source URL'),
                    ),
                    const SizedBox(height: 12),
                    FormBuilderTextField(
                      name: 'techStack',
                      initialValue: techStackText,
                      decoration: const InputDecoration(
                        labelText: 'Tech Stack (JSON)',
                        hintText: '["Flutter", "Dart"]',
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 12),
                    FormBuilderTextField(
                      name: 'category',
                      initialValue: project?.category ?? '',
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        hintText: 'e.g. Web, Mobile, Backend',
                      ),
                    ),
                    const SizedBox(height: 12),
                    FormBuilderTextField(
                      name: 'client',
                      initialValue: project?.client ?? '',
                      decoration: const InputDecoration(
                        labelText: 'Client',
                        hintText: 'e.g. EbeGym Inc.',
                      ),
                    ),
                    const SizedBox(height: 12),
                    FormBuilderTextField(
                      name: 'role',
                      initialValue: project?.role ?? '',
                      decoration: const InputDecoration(
                        labelText: 'Role',
                        hintText: 'e.g. Lead Developer',
                      ),
                    ),
                    const SizedBox(height: 12),
                    FormBuilderTextField(
                      name: 'timeline',
                      initialValue: project?.timeline ?? '',
                      decoration: const InputDecoration(
                        labelText: 'Timeline',
                        hintText: 'e.g. Jan 2024 - Present',
                      ),
                    ),
                    const SizedBox(height: 12),
                    FormBuilderDropdown<String>(
                      name: 'status',
                      initialValue: project?.status.name ?? 'active',
                      decoration:
                          const InputDecoration(labelText: 'Status'),
                      items: const [
                        DropdownMenuItem(
                            value: 'active', child: Text('Active')),
                        DropdownMenuItem(
                            value: 'archived', child: Text('Archived')),
                        DropdownMenuItem(
                            value: 'in_progress',
                            child: Text('In Progress')),
                      ],
                    ),
                    const SizedBox(height: 12),
                    FormBuilderSwitch(
                      name: 'featured',
                      initialValue: project?.featured ?? false,
                      title: const Text('Featured'),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                    const SizedBox(height: 12),
                    FormBuilderTextField(
                      name: 'sortOrder',
                      initialValue:
                          (project?.sortOrder ?? 0).toString(),
                      decoration: const InputDecoration(
                          labelText: 'Sort Order'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: isSaving.value ? null : handleSave,
              child: Text(isSaving.value ? 'Saving...' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }

  List<dynamic> _buildInitialThumbnail(Project? project, String baseUrl) {
    if (project == null || project.thumbnail.isEmpty) return [];
    return [project.thumbnailUrl(baseUrl)];
  }

  List<dynamic> _buildInitialGallery(Project? project, String baseUrl) {
    if (project == null || project.gallery.isEmpty) return [];
    return project.galleryUrls(baseUrl);
  }
}
