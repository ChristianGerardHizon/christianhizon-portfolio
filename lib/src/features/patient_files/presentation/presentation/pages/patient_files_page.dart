import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sannjosevet/src/core/extensions/date_time_extension.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/packages/file_downloader.dart';
import 'package:sannjosevet/src/core/packages/pocketbase.dart';
import 'package:sannjosevet/src/core/routing/router.dart';
import 'package:sannjosevet/src/core/strings/table_controller_keys.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/modals/confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/sliver_dynamic_table_view.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/dynamic_table_column.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:sannjosevet/src/core/widgets/failure_message.dart';
import 'package:sannjosevet/src/core/widgets/photo_viewer.dart';
import 'package:sannjosevet/src/core/widgets/popover_widget.dart';
import 'package:sannjosevet/src/core/widgets/refresh_button.dart';
import 'package:sannjosevet/src/core/widgets/stack_loader.dart';
import 'package:sannjosevet/src/features/patient_files/data/patient_file_repository.dart';
import 'package:sannjosevet/src/features/patient_files/domain/patient_file.dart';
import 'package:sannjosevet/src/features/patient_files/presentation/presentation/controllers/patient_file_table_controller.dart';
import 'package:sannjosevet/src/features/patient_files/presentation/presentation/widgets/patient_file_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientFilesPage extends HookConsumerWidget {
  const PatientFilesPage({
    super.key,
    required this.patientId,
    this.showAppBar = true,
  });
  final String patientId;
  final bool showAppBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = TableControllerKeys.patientFilePatient(patientId);
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider =
        patientFileTableControllerProvider(tableKey, patientId: patientId);
    final listState = ref.watch(listProvider);

    final isLoading = useState(false);

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(patientFileTableControllerProvider);
      ref.invalidate(provider);
      notifier.clearSelection();
    }

    ///
    /// onDelete
    ///
    onDelete(List<PatientFile> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(patientFileRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      // isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      // if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          notifier.clearSelection();
          ref.invalidate(patientFileTableControllerProvider);
          AppSnackBar.root(message: 'Successfully Deleted');
        },
      );
    }

    String generateUrl(PatientFile patientFile) {
      final baseURL = ref.read(pocketbaseProvider).baseURL;
      final collection = patientFile.collectionId;
      final file = patientFile.file;
      final id = patientFile.id;

      return '${baseURL}/api/files/$collection/$id/$file';
    }

    onTap(PatientFile patientFile) {
      if (!patientFile.isImage) {
        AppSnackBar.root(message: 'Unable to view file');
        return;
      }
      PhotoViewer.show(context, generateUrl(patientFile));
    }

    onDownload(PatientFile patientFile) async {
      final result = await TaskResult.tryCatch(() async {
        final url = generateUrl(patientFile);
        final uri = Uri.parse(url);

        if (kIsWeb) {
          launchUrl(uri);
        } else {
          final task = DownloadTask(
            url: uri.toString(),
            filename: patientFile.file,
            directory: (await getDownloadsDirectory())!.path,
            retries: 5,
            allowPause: true,
          );
          return ref.watch(fileDownloaderProvider).download(task);
        }
        ;
      }, Failure.handle)
          .run();

      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) => AppSnackBar.root(message: 'Download has started...'),
      );
    }

    onCopy(PatientFile patientFile) {
      Clipboard.setData(ClipboardData(text: generateUrl(patientFile)));
      AppSnackBar.root(message: 'Copied to clipboard');
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      PatientFileFormPageRoute(parentId: patientId).push(context);
    }

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              centerTitle: false,
              title: Text('PatientFiles'),
              actions: [
                RefreshButton(onPressed: onRefresh),
              ],
            )
          : null,
      body: StackLoader(
        opacity: .8,
        isLoading: isLoading.value,
        child: SliverDynamicTableView<PatientFile>(
          tableKey: tableKey,
          error: FailureMessage.asyncValue(listState),
          isLoading: listState.isLoading,
          items: listState.valueOrNull ?? [],
          onDelete: onDelete,
          onRowTap: onTap,

          ///
          /// Search Features
          ///
          searchCtrl: searchCtrl,
          onCreate: onCreate,

          ///
          /// Table Data
          ///
          columns: [
            DynamicTableColumn(
              header: 'File',
              width: 200,
              alignment: Alignment.centerLeft,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    data.file.toString(),
                  ),
                );
              },
            ),
            DynamicTableColumn(
              header: 'Notes',
              width: 200,
              alignment: Alignment.centerLeft,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    data.notes.optional(),
                  ),
                );
              },
            ),
            DynamicTableColumn(
              header: 'Created',
              width: 200,
              alignment: Alignment.centerLeft,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    (data.created?.fullReadable).optional(),
                  ),
                );
              },
            ),
            DynamicTableColumn(
              header: 'Actions',
              width: 159,
              alignment: Alignment.center,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.center,
                  child: PopoverWidget.icon(
                    icon: Icon(MIcons.dotsHorizontal),
                    bottomSheetHeader: const Text('Action'),
                    items: [
                      PopoverMenuItemData(
                        name: 'Download',
                        onTap: () {
                          onDownload(data);
                        },
                      ),
                      PopoverMenuItemData(
                        name: 'Copy Url',
                        onTap: () {
                          onCopy(data);
                        },
                      ),
                      if (data.isImage)
                        PopoverMenuItemData(
                          name: 'View',
                          onTap: () {
                            onTap(data);
                          },
                        ),
                      PopoverMenuItemData(
                        name: 'Delete',
                        onTap: () {
                          onDelete([data]);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],

          ///
          /// Builder for mobile
          ///
          mobileBuilder: (context, index, patientFile, selected) {
            return PatientFileCard(
              patientFile: patientFile,
              onTap: () {
                if (selected)
                  notifier.toggleRow(index);
                else
                  onTap(patientFile);
              },
              selected: selected,
              onLongPress: () {
                notifier.toggleRow(index);
              },
            );
          },
        ),
      ),
    );
  }
}
